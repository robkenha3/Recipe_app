import 'package:flutter/material.dart';
import 'package:projeto_receitas/model/my_recipe.dart';
import 'package:projeto_receitas/notifier/my_recipe_list_notifier.dart';
import 'package:provider/provider.dart';

import '../../notifier/recipe_list_notifier.dart';
// import '../../notifier/recipe_list_widget.dart';
import '../../model/recipe.dart';

class RecipeScreen extends StatelessWidget {
  final int index;
  final String cardStyle;

  const RecipeScreen({super.key, required this.index, required this.cardStyle});

  @override
  Widget build(BuildContext context) {
    final recipeListNotifier = context.watch<RecipeListNotifier>();
    List<Recipe> generalRecipes = recipeListNotifier.recipes;

    final myRecipeListNotifier = context.watch<MyRecipeListNotifier>();
    List<MyRecipe> userRecipes = myRecipeListNotifier.myRecipes;

    final bool isGeneralRecipe = cardStyle == "recipeCard";
    final List listToUse = isGeneralRecipe ? generalRecipes : userRecipes;

    final dynamic recipeToDisplay = listToUse[index];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[300],
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),

      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromARGB(255, 254, 254, 254),
              Color.fromARGB(255, 241, 241, 241),
              Color.fromARGB(255, 243, 243, 243),
              Color.fromARGB(255, 249, 249, 249),
            ],
            begin: Alignment.topCenter,
            end: AlignmentGeometry.bottomCenter,
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(color: Colors.grey[300]),
                      child: Icon(Icons.image, size: 350),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Text(
                          recipeToDisplay.name,
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 27),
                    child: Icon(
                      Icons.favorite_border,
                      color: Colors.red,
                      size: 40,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    children: [
                      Row(
                        children: [
                          Icon(Icons.timer_sharp),
                          Text(": ${recipeToDisplay.preparationTime} min"),
                        ],
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Row(
                        children: [
                          Icon(Icons.person),
                          Text(": ${recipeToDisplay.quantity}"),
                        ],
                      ),
                    ],
                  ),
                  if (isGeneralRecipe)
                    Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: List.generate(5, (indexStar) {
                            final currentRate =
                                (recipeListNotifier.recipes.length > index)
                                ? recipeListNotifier.recipes[index].rate
                                : 0;
                            return Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 1.0,
                              ),
                              child: InkWell(
                                customBorder: const CircleBorder(),
                                onTap: () {
                                  recipeListNotifier.updateRating(
                                    index,
                                    indexStar,
                                  );
                                },
                                child: Icon(
                                  Icons.star,
                                  size: 25,
                                  color: currentRate < indexStar
                                      ? Colors.black
                                      : Colors.yellow[400],
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      ],
                    ),
                ],
              ),
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Text(
                  "Ingredientes:",
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                ),
              ),
              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: recipeToDisplay.ingredients.length,
                itemBuilder: (BuildContext context, int indexIng) {
                  return ListTile(
                    leading: Icon(
                      Icons.circle,
                      size: 10,
                      color: Colors.green[200],
                    ),
                    title: Text(recipeToDisplay.ingredients[indexIng]),
                  );
                },
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Text(
                  "Modo de Preparo:",
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                ),
              ),
              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: recipeToDisplay.instruction.length,
                itemBuilder: (BuildContext context, int indexIns) {
                  final int itemNumber = indexIns + 1;

                  return ListTile(
                    leading: Text(
                      "$itemNumber.",
                      style: TextStyle(fontSize: 15),
                    ),
                    title: Text(recipeToDisplay.instruction[indexIns]),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
