import 'package:flutter/material.dart';
import 'package:projeto_receitas/logic/recipe_list_notifier.dart';
import 'package:projeto_receitas/view/recipe_screen.dart';

import '../logic/recipe_list_widget.dart';
import '../model/recipe.dart';

class RecipeCard extends StatefulWidget {
  const RecipeCard({super.key});

  @override
  State<RecipeCard> createState() => _RecipeCardState();
}

class _RecipeCardState extends State<RecipeCard> {
  @override
  Widget build(BuildContext context) {
    RecipeListNotifier recipeListNotifier = RecipeListWidget.of(context);
    List<Recipe> recipes = recipeListNotifier.recipes;
    recipeListNotifier.addListener(() {
      setState(() {});
    });

    List<RecipeInfo> conversorRecipesToRecipeCard() {
      List<RecipeInfo> newRecipes = recipes.asMap().entries.map((entry) {
        int index = entry.key;
        return RecipeInfo(index: index);
      }).toList();
      return newRecipes;
    }

    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        // context faz busca na widget tree
        // constraints tem o tamanho da tela (maxWidth, maxHeight, minWidth, minHeight)

        // pc
        if (constraints.maxWidth >= 1070) {
          return GridView.count(
            crossAxisCount: 3,
            childAspectRatio: 0.76,
            children: conversorRecipesToRecipeCard(),
          );
          // tablet
        } else if (constraints.maxWidth >= 900) {
          return GridView.count(
            crossAxisCount: 3,
            childAspectRatio: 0.70,
            children: conversorRecipesToRecipeCard(),
          );
        } else if (constraints.maxWidth >= 600) {
          return GridView.count(
            crossAxisCount: 2,
            childAspectRatio: 0.75,
            children: conversorRecipesToRecipeCard(),
          );
          // Celular
        } else {
          return ListView.builder(
            itemCount: recipes.length,
            itemBuilder: (BuildContext context, int position) {
              int newPosition = position % recipes.length;
              return RecipeInfo(index: newPosition);
            },
          );
        }
      },
    );
  }
}

class RecipeInfo extends StatelessWidget {
  final int index;

  const RecipeInfo({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    RecipeListNotifier recipeListNotifier = RecipeListWidget.of(context);
    Recipe recipe = recipeListNotifier.recipes[index];

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: () => {
          Navigator.of(context).push(
            MaterialPageRoute<bool>(
              builder: (BuildContext context) {
                return RecipeScreen(index: index);
              },
            ),
          ),
        },
        child: Card(
          elevation: 5,
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: FittedBox(
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.circular(1.0),
                        ),
                        child: Icon(recipe.img),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),

              Row(
                children: [
                  Expanded(
                    child: Center(
                      child: Text(
                        recipe.name,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
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
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(5, (indexStar) {
                          return Icon(
                            Icons.star,
                            size: 25,
                            color: recipe.rate < indexStar
                                ? Colors.black
                                : Colors.yellow[400],
                          );
                        }),
                      ),
                    ],
                  ),
                  Text(
                    "${recipe.preparationTime} min",
                    style: TextStyle(fontSize: 18),
                  ),
                ],
              ),
              SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}
