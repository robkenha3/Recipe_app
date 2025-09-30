import 'package:flutter/material.dart';
import 'package:projeto_receitas/view/recipe_screen.dart';

import '../model/recipe.dart';

class RecipeCard extends StatefulWidget {
  const RecipeCard({super.key});

  @override
  State<RecipeCard> createState() => _RecipeCardState();
}

class _RecipeCardState extends State<RecipeCard> {
  List<Recipe> recipes = [
    Recipe(
      name: 'Lasanha',
      img: Icons.food_bank,
      preparationTime: 60,
      rate: 5,
      quantity: 4,
      favorite: true,
      ingredients: ["massa", "presunto", "queijo"],
      instruction: ["cozinhar massa", "temperar carne"],
    ),
    Recipe(
      name: 'Strogonoff',
      img: Icons.food_bank,
      preparationTime: 40,
      rate: 5,
      quantity: 2,
      favorite: true,
      ingredients: ["massa", "presunto", "queijo"],
      instruction: ["cozinhar massa", "temperar carne"],
    ),
    Recipe(
      name: 'Feijoada',
      img: Icons.food_bank,
      preparationTime: 120,
      rate: 4,
      quantity: 5,
      favorite: true,
      ingredients: ["massa", "presunto", "queijo"],
      instruction: ["cozinhar massa", "temperar carne"],
    ),
    Recipe(
      name: 'Frango Frito',
      img: Icons.food_bank,
      preparationTime: 45,
      rate: 5,
      quantity: 1,
      favorite: true,
      ingredients: ["massa", "presunto", "queijo"],
      instruction: ["cozinhar massa", "temperar carne"],
    ),
    Recipe(
      name: 'Macarrão a bolonhesa',
      img: Icons.food_bank,
      preparationTime: 30,
      rate: 5,
      quantity: 3,
      favorite: true,
      ingredients: ["massa", "presunto", "queijo"],
      instruction: ["cozinhar massa", "temperar carne"],
    ),
    Recipe(
      name: 'Galinhada',
      img: Icons.food_bank,
      preparationTime: 80,
      rate: 5,
      quantity: 4,
      favorite: true,
      ingredients: ["massa", "presunto", "queijo"],
      instruction: ["cozinhar massa", "temperar carne"],
    ),
    Recipe(
      name: 'Bife Acebolado',
      img: Icons.food_bank,
      preparationTime: 40,
      rate: 4,
      quantity: 2,
      favorite: true,
      ingredients: ["massa", "presunto", "queijo"],
      instruction: ["cozinhar massa", "temperar carne"],
    ),
  ];

  updateRating(int index, int updatedRate) {
    Recipe recipe = recipes[index];
    recipes[index] = recipe.copyRecipe(updatedRate);
    setState(() {});
  }

  List<RecipeInfo> conversorRecipesToRecipeCard() {
    List<RecipeInfo> newRecipes = recipes.asMap().entries.map((entry) {
      int index = entry.key;
      Recipe recipe = entry.value;
      return RecipeInfo(
        recipe: recipe,
        onRatingChange: (value) {
          updateRating(index, value);
        },
      );
    }).toList();
    return newRecipes;
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        // context faz busca na widget tree
        // constraints tem o tamanho da tela (maxWidth, maxHeight, minWidth, minHeight)

        // pc
        if (constraints.maxWidth >= 900) {
          return GridView.count(
            crossAxisCount: 3,
            childAspectRatio: 0.8,
            children: conversorRecipesToRecipeCard(),
          );
          // tablet
        } else if (constraints.maxWidth >= 600) {
          return GridView.count(
            crossAxisCount: 2,
            childAspectRatio: 0.8,
            children: conversorRecipesToRecipeCard(),
          );
          // Celular
        } else {
          return ListView.builder(
            itemCount: recipes.length,
            itemBuilder: (context, int position) {
              int newPosition = position % recipes.length;
              return RecipeInfo(
                recipe: recipes[newPosition],
                onRatingChange: (value) {
                  updateRating(newPosition, value);
                },
              );
            },
          );
        }
      },
    );
  }
}

class RecipeInfo extends StatelessWidget {
  final Recipe recipe;
  final Function onRatingChange;

  const RecipeInfo({
    super.key,
    required this.recipe,
    required this.onRatingChange,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: () => {
          Navigator.of(context).push(
            MaterialPageRoute<bool>(
              builder: (BuildContext context) {
                return RecipeScreen(
                  recipe: recipe,
                  onRatingChange: (value) {
                    onRatingChange(value);
                  },
                );
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

              Row(
                children: [
                  Expanded(
                    child: Center(
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 10.0),
                        child: Text(
                          recipe.name,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(5, (index) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 1.0,
                            ),
                            child: Icon(
                              Icons.star,
                              size: 25,
                              color: recipe.rate < index + 1
                                  ? Colors.black
                                  : Colors.yellow[400],
                            ),
                          );
                        }),
                      ),
                    ],
                  ),
                  Text(
                    "${recipe.preparationTime} min",
                    style: TextStyle(fontSize: 18),
                  ),
                  // SizedBox()
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
