:- use_module(library(scasp)).
:- style_check(-singleton).
%:- set_prolog_flag(scasp_unknown, fail).

%Workout exercises based on level on intensity and
%the user goal either being to bulk or shred.

workout(push_up, high_intensity, shred).
workout(sit_up, medium_intensity, shred).
workout(squat, low_intensity, bulk).
workout(pull_up, high_intensity, shred).
workout(plank, medium_intensity, shred).
workout(jumping_jacks, low_intensity, bulk).
workout(bulgarian_squat, high_intensity, bulk).
workout(walking, low_intensity, bulk).
workout(weight_lifting, high_intensity, bulk).
workout(burpee, high_intensity, shred).
workout(running, high_intensity, shred).
workout(superman_lifts, medium_intensity, bulk).
workout(mountain_climbers, high_intensity, shred).
workout(hammer_curl, medium_intensity, bulk).
workout(yoga, low_intensity, shred).
workout(pilates, medium_intensity, shred).
workout(hip_raise, medium_intensity, shred).
workout(bicep_curl, medium_intensity, bulk).
workout(calf_raise, medium_intensity, bulk).
workout(lateral_pulldown, medium_intensity, bulk).

%Filters all exercises based on the goal of shredding or bulking.
just_shred(Exercise) :- workout(Exercise, _, shred).
just_bulk(Exercise) :- workout(Exercise, _, bulk).

%Stablishes how long an exercise should take based on its intensity (if lower, do it for less time).
get_duration(high_intensity, 30).
get_duration(medium_intensity, 60).
get_duration(low_intensity, 90).

%Calculates total amount of time it takes to execute exercises given a condition.
duration_list([], A, A).
duration_list([Exercise | Rest], RestDuration, TotalDuration) :-
    workout(Exercise, Intensity, _),
    get_duration(Intensity, Duration),
    CurrentDuration is Duration + RestDuration,
    duration_list(Rest, CurrentDuration, TotalDuration).

%Finds the exercises and how long the list will take depending on the goal (bulk or shred) and intensity level, and uses the duration_list to calculate exercises found.
findall_clause(Exercise, Goal, Intensity) :- workout(Exercise, Intensity, Goal).

workout_set(Goal, Intensity, Exercises, TotalDuration) :-
    findall(Exercise, findall_clause(Exercise, Goal, Intensity), Exercises),
    duration_list(Exercises, 0, TotalDuration).


%starts the program makes a workout set based on your goals and preferred intensity level
recommend_workoutSystem:-

    write('Welcome to the FITGLO Health Personal Assistant!'), nl,
    write('Hello! What goal do you want to have? [bulk or shred]'), nl,
    read(Goal_answer),
    write('okay cool, '),
    write(Goal_answer),nl,

    write('Also, level of intensity do you prefer? [low_intensity, medium_intensity, or high_intensity]'), nl,
    read(Intensity_answer),
    write('okay cool, '),
    write(Intensity_answer),nl,
    write('Here is your workout set :'),nl,
    write('--------------------------'),
    (
   		Goal_answer = bulk -> 
            group_set_b(bulk, Intensity_answer);
        Goal_answer = shred -> 
            group_set_s(shred, Intensity_answer)).

%seperates the workouts in the set
writeln(X) :- write(X), nl.

%this the generates and displays based on if it is shred or bulk, prints intensity, map lists the exercises and displays duration
group_set_s(shred, Intensity):- workout_set(shred, Intensity, Exercises, TotalDuration),nl,maplist(writeln, Exercises),nl, write('Total duration in seconds: '),write(TotalDuration).
group_set_b(bulk, Intensity):- workout_set(bulk, Intensity, Exercises, TotalDuration),nl,maplist(writeln, Exercises), nl, write('Total duration in seconds: '),write(TotalDuration).


% Query for starting the Workout Set recommendation system
%?-recommend_workoutSystem.

%---------------------------------------------------------------------------------------

%Recipes with goal types, ingredients in a list and calorie content
%Lean diet (Shred)
recipe(oat_meal, [apples, oat_meal, coconut_flakes, peanut_butter], lean_diet, 340, shred).
recipe(grilled_chicken_salad, [chicken_breast, mixed_greens, cucumber, cherry_tomatoes, avocado, olive_oil, lemon_juice], lean_diet, 350, shred).
recipe(baked_salmon_with_asparagus, [salmon_fillet, asparagus, olive_oil, garlic, lemon_slices], lean_diet, 400, shred).
recipe(turkey_and_zucchini_noodles, [ground_turkey, zucchini_noodles, garlic, olive_oil, cherry_tomatoes, basil], lean_diet, 300, shred).
recipe(beef_and_broccoli_stir_fry, [lean_beef, broccoli, garlic, ginger, soy_sauce, sesame_oil, green_onions], lean_diet, 370, shred).
recipe(egg_and_sausage_muffins, [eggs, ground_sausage, spinach, bell_peppers, cheese], lean_diet, 330, shred).

%Vegan (Bulk or Shred)
recipe(tofu_stir_fry_with_cauliflower_rice, [tofu, cauliflower_rice, bell_peppers, broccoli, peas, sesame_oil, soy_sauce], vegan, 320, shred).
recipe(zucchini_noodles_with_avocado_pesto, [zucchini_noodles, cherry_tomatoes, avocado, pine_nuts, garlic, basil, lemon_juice], vegan, 310, shred).
recipe(creamy_coconut_curry_with_tofu_and_greens, [tofu, spinach, kale, zucchini, coconut_milk, curry_powder, garlic], vegan, 360, shred).
recipe(sweet_potato_and_chickpea_buddha_bowl, [chickpeas, sweet_potatoes, quinoa, spinach, avocado, tahini_dressing], vegan, 450, bulk).
recipe(vegan_black_bean_burrito_bowl, [black_beans, brown_rice, corn, lettuce, tomatoes, avocado, guacamole], vegan, 470, bulk).
recipe(quinoa_and_roasted_vegetable_bowl, [quinoa, sweet_potatoes, butternut_squash, kale, brussels_sprouts, tahini_dressing], vegan, 440, bulk).

%High Protein (Bulk)
recipe(chicken_and_quinoa_bowl, [chicken_breast, quinoa, black_beans, corn, avocado, cilantro, lime_juice], high_protein, 500, bulk).
recipe(beef_and_sweet_potato_bowl, [lean_beef, sweet_potatoes, broccoli, olive_oil, garlic, soy_sauce], high_protein, 550, bulk).
recipe(grilled_turkey_burgers_with_roasted_veggies, [ground_turkey, bell_peppers, zucchini, onions, olive_oil, garlic], high_protein, 520, bulk).
recipe(chicken_and_black_beans_stir_fry, [chicken_breast, black_beans, bell_peppers, onions, garlic, olive_oil, soy_sauce], high_protein, 510, bulk).
recipe(salmon_and_quinoa_bowl, [salmon_fillet, quinoa, spinach, avocado, lemon_juice, olive_oil], high_protein, 530, bulk).
recipe(pork_and_broccoli_stir_fry, [lean_pork, broccoli, garlic, ginger, soy_sauce, sesame_oil], high_protein, 540, bulk).

%Recommend recipes based on diet type, calorie limit, and goal
recommend_recipe(DietType, MaxCalories, Goal, Recipe) :-
    
    %Find all the recipes that have fewer calories than the user-given calories and put in RecipeList
    findall(Recipe, (recipe(Recipe, _, DietType, Calories, Goal), Calories < MaxCalories), RecipeList),
    random_member(Recipe, RecipeList), %Pick random recipe
    recipe(Recipe, Ingredients, _, Calories, _), %Collect details of randomly selected recipe
    
    %Print recipe info using function
    write('Recommended recipe: '), write(Recipe), nl,
    write('Ingredients: '), nl,
    print_ingredients(Ingredients).

% Function to print ingredients using recursion
print_ingredients([]). % Base case: when the list is empty, nothing is printed
print_ingredients([H|T]) :- write(H), nl, print_ingredients(T). %Write the current ingredient then print the rest

% Recommendation system
recommend_recipeSystem :- 
    write('Welcome to the FITGLO Health Personal Assistant!'), nl,
    write('Please state your fitness goals (bulk/shred): '), nl,
    read(Goal),
    
    (Goal = bulk -> 
        write('What type of diet are you following? (vegan/high_protein)'), nl; %else
        write('What type of diet are you following? (vegan/lean_diet)'), nl
    ),
    read(DietType),
    
    (Goal = bulk -> 
        write('What is your calorie limit? (450 - 600 Range only, Please)'), nl,
        write('(Vegan: 450 - 500, High Protein: 510 - 600)'), nl; %else
    
    	%Shred limit collect
        write('What is your calorie limit? (310 - 410 Range only, Please)'), nl,
        write('(Vegan: 310 - 370, Lean Diet: 310 - 410)'), nl
    ),
    read(MaxCalories),
    
    (Goal = bulk, MaxCalories >= 450, MaxCalories =< 600 -> 
        recommend_recipe(DietType, MaxCalories, Goal, _); %else
    Goal = shred, MaxCalories >= 310, MaxCalories =< 410 -> 
        recommend_recipe(DietType, MaxCalories, Goal, _); %else
    
    write('Please enter a valid calorie range, thank you.'), nl %default case

    ).

% Query for starting the recommendation system
%?- recommend_recipeSystem.











