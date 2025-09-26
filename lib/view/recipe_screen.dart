import 'package:flutter/material.dart';

import '../model/recipe.dart';

class RecipeScreen extends StatefulWidget {
  const RecipeScreen({super.key});

  @override
  State<RecipeScreen> createState() => _RecipeScreenState();
}

class _RecipeScreenState extends State<RecipeScreen> {
  List<Recipe> recipes = [
    Recipe(
      name: 'Lasanha',
      img: Icons.food_bank,
      preparationTime: 60,
      avaliation: 5,
      quantity: 3,
      favorite: true,
      ingredients: ["massa", "presunto", "queijo"],
      instruction: ["cozinhar massa", "temperar carne"],
    ),
    Recipe(
      name: 'Strogonoff',
      img: Icons.food_bank,
      preparationTime: 40,
      avaliation: 5,
      quantity: 3,
      favorite: true,
      ingredients: ["massa", "presunto", "queijo"],
      instruction: ["cozinhar massa", "temperar carne"],
    ),
    Recipe(
      name: 'Feijoada',
      img: Icons.food_bank,
      preparationTime: 120,
      avaliation: 4,
      quantity: 3,
      favorite: true,
      ingredients: ["massa", "presunto", "queijo"],
      instruction: ["cozinhar massa", "temperar carne"],
    ),
    Recipe(
      name: 'Frango Frito',
      img: Icons.food_bank,
      preparationTime: 45,
      avaliation: 5,
      quantity: 3,
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
      quantity: 3,
      favorite: true,
      ingredients: ["massa", "presunto", "queijo"],
      instruction: ["cozinhar massa", "temperar carne"],
    ),
    Recipe(
      name: 'Bife Acebolado',
      img: Icons.food_bank,
      preparationTime: 40,
      avaliation: 4,
      quantity: 3,
      favorite: true,
      ingredients: ["massa", "presunto", "queijo"],
      instruction: ["cozinhar massa", "temperar carne"],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(leading: Icon(Icons.arrow_back_ios)),
        body: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(color: Colors.grey[300]),
                    child: Icon(recipes[0].img, size: 350),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(recipes[0].name),
                Icon(Icons.favorite_border, color: Colors.red),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  children: [
                    Row(
                      children: [
                        Icon(Icons.timer_sharp),
                        Text(": ${recipes[0].preparationTime} min"),
                      ],
                    ),
                  ],
                ),
                Column(
                  children: [
                    Row(
                      children: [
                        Icon(Icons.person),
                        Text(": ${recipes[0].quantity} pessoas"),
                      ],
                    ),
                  ],
                ),
              ],
            ),
            Row(children: [Text("Ingredientes")]),
            // Lógica da listagem do ingredientes
            Column(
              children: [
                Row(children: [Text(". fijwfei")]),
              ],
            ),
            Row(children: [Text("Modo de Preparo")]),
            // Lógica da listagem do modo de preparo
            Column(
              children: [
                Row(children: [Text("1. ajdfgk")]),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
