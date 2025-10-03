import 'package:flutter/material.dart';

import '../logic/recipe_list_notifier.dart';
import '../logic/recipe_list_widget.dart';
import '../model/recipe.dart';

class RecipeScreen extends StatelessWidget {
  final int index;

  const RecipeScreen({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    RecipeListNotifier recipeListNotifier = RecipeListWidget.of(context);
    Recipe recipe = recipeListNotifier.recipes[index];

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
                      child: Icon(recipe.img, size: 350),
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
                          recipe.name,
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
                          Text(": ${recipe.preparationTime} min"),
                        ],
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Row(
                        children: [
                          Icon(Icons.person),
                          Text(": ${recipe.quantity}"),
                        ],
                      ),
                    ],
                  ),
                  ListenableBuilder(
                    listenable: recipeListNotifier,
                    builder: (context, _) {
                      Recipe recipe = recipeListNotifier.recipes[index];
                      return Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: List.generate(5, (indexStar) {
                              return Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 1.0,
                                ),
                                child: InkWell(
                                  customBorder: const CircleBorder(),
                                  onTap: () {
                                    recipeListNotifier.updateRecipe(
                                      index,
                                      indexStar,
                                    );
                                  },
                                  child: Icon(
                                    Icons.star,
                                    size: 25,
                                    color: recipe.rate < indexStar
                                        ? Colors.black
                                        : Colors.yellow[400],
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                        ],
                      );
                    },
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
                itemCount: recipe.ingredients.length,
                itemBuilder: (BuildContext context, int indexIng) {
                  final String ingredient = recipe.ingredients[indexIng];
                  return ListTile(
                    leading: Icon(
                      Icons.circle,
                      size: 10,
                      color: Colors.green[200],
                    ),
                    title: Text(ingredient),
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
                itemCount: recipe.instruction.length,
                itemBuilder: (BuildContext context, int indexIns) {
                  final String instruction = recipe.instruction[indexIns];
                  final int itemNumber = indexIns + 1;

                  return ListTile(
                    leading: Text(
                      "$itemNumber.",
                      style: TextStyle(fontSize: 15),
                    ),
                    title: Text(instruction),
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
