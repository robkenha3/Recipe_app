import 'package:flutter/material.dart';
import 'package:projeto_receitas/service/recipes_service.dart';
import 'package:projeto_receitas/view/recipe_screen.dart';

import '../model/recipe.dart';

class RecipeCard extends StatefulWidget {
  const RecipeCard({super.key});

  @override
  State<RecipeCard> createState() => _RecipeCardState();
}

class _RecipeCardState extends State<RecipeCard> {
  RecipesService recipesService = RecipesService();

  List<Recipe> recipes = [
    Recipe(
      name: 'Lasanha',
      img: Icons.food_bank,
      preparationTime: 60,
      avaliation: 5,
      quantity: 4,
      favorite: true,
      ingredients: ["massa", "presunto", "queijo"],
      instruction: ["cozinhar massa", "temperar carne"],
    ),
    Recipe(
      name: 'Strogonoff',
      img: Icons.food_bank,
      preparationTime: 40,
      avaliation: 5,
      quantity: 2,
      favorite: true,
      ingredients: ["massa", "presunto", "queijo"],
      instruction: ["cozinhar massa", "temperar carne"],
    ),
    Recipe(
      name: 'Feijoada',
      img: Icons.food_bank,
      preparationTime: 120,
      avaliation: 4,
      quantity: 5,
      favorite: true,
      ingredients: ["massa", "presunto", "queijo"],
      instruction: ["cozinhar massa", "temperar carne"],
    ),
    Recipe(
      name: 'Frango Frito',
      img: Icons.food_bank,
      preparationTime: 45,
      avaliation: 5,
      quantity: 1,
      favorite: true,
      ingredients: ["massa", "presunto", "queijo"],
      instruction: ["cozinhar massa", "temperar carne"],
    ),
    Recipe(
      name: 'Macarrão a bolonhesa',
      img: Icons.food_bank,
      preparationTime: 30,
      avaliation: 5,
      quantity: 3,
      favorite: true,
      ingredients: ["massa", "presunto", "queijo"],
      instruction: ["cozinhar massa", "temperar carne"],
    ),
    Recipe(
      name: 'Galinhada',
      img: Icons.food_bank,
      preparationTime: 80,
      avaliation: 5,
      quantity: 4,
      favorite: true,
      ingredients: ["massa", "presunto", "queijo"],
      instruction: ["cozinhar massa", "temperar carne"],
    ),
    Recipe(
      name: 'Bife Acebolado',
      img: Icons.food_bank,
      preparationTime: 40,
      avaliation: 4,
      quantity: 2,
      favorite: true,
      ingredients: ["massa", "presunto", "queijo"],
      instruction: ["cozinhar massa", "temperar carne"],
    ),
  ];

  List<RecipeInfo> conversorRecipesToRecipeCard() {
    List<RecipeInfo> newRecipes = recipes.map((el) {
      return RecipeInfo(recipe: el);
    }).toList();
    return newRecipes;
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        // context faz busca na widget tree
        // constraints tem o tamanho da tela (maxWidth, maxHeight, minWidth, minHeight)

        // tablet
        if (constraints.maxWidth >= 900) {
          return GridView.count(
            crossAxisCount: 3,
            childAspectRatio: 0.8,
            children: conversorRecipesToRecipeCard(),
          );
        } else if (constraints.maxWidth >= 600) {
          return GridView.count(
            crossAxisCount: 2,
            childAspectRatio: 0.8,
            children: conversorRecipesToRecipeCard(),
          );
        } else {
          return ListView.builder(
            itemCount: recipes.length,
            itemBuilder: (context, int position) {
              int newPosition = position % recipes.length;
              return RecipeInfo(recipe: recipes[newPosition]);
            },
          );
        }
      },
    );
  }
}

class RecipeInfo extends StatelessWidget {
  final Recipe recipe;

  const RecipeInfo({super.key, required this.recipe});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: () => {
          Navigator.of(context).push(
            MaterialPageRoute<bool>(
              builder: (BuildContext context) {
                return RecipeScreen(recipe: recipe);
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
                  Text(
                    "Avaliação: ${recipe.avaliation}",
                    style: TextStyle(fontSize: 18),
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
