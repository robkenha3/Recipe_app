import 'package:flutter/material.dart';

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
      avaliation: 5,
    ),
    Recipe(
      name: 'Strogonoff',
      img: Icons.food_bank,
      preparationTime: 40,
      avaliation: 5,
    ),
    Recipe(
      name: 'Feijoada',
      img: Icons.food_bank,
      preparationTime: 120,
      avaliation: 4,
    ),
    Recipe(
      name: 'Frango Frito',
      img: Icons.food_bank,
      preparationTime: 45,
      avaliation: 5,
    ),
    Recipe(
      name: 'Macarrão a bolonhesa',
      img: Icons.food_bank,
      preparationTime: 30,
      avaliation: 5,
    ),
    Recipe(
      name: 'Galinhada',
      img: Icons.food_bank,
      preparationTime: 80,
      avaliation: 5,
    ),
    Recipe(
      name: 'Bife Acebolado',
      img: Icons.food_bank,
      preparationTime: 40,
      avaliation: 4,
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
    return ListView(children: conversorRecipesToRecipeCard());
  }
}

class RecipeInfo extends StatelessWidget {
  Recipe recipe;

  RecipeInfo({super.key, required this.recipe});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        elevation: 5,
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Container(
                    height: 300,
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    child: Icon(recipe.img, size: 80),
                  ),
                ),
              ],
            ),
      
            Row(
              children: [
                Expanded(
                  child: Container(
                    padding: EdgeInsets.only(top: 10, bottom: 50),
                    alignment: Alignment.center,
                    child: Text(
                      recipe.name,
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            ),
      
            Container(
              padding: EdgeInsets.only(bottom: 10),
              child: Row(
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
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
