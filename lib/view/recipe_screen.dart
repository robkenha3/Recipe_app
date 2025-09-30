import 'package:flutter/material.dart';

import '../model/recipe.dart';

class RecipeScreen extends StatefulWidget {
  final Recipe recipe;

  const RecipeScreen({super.key, required this.recipe});

  @override
  State<RecipeScreen> createState() => _RecipeScreenState();
}

class _RecipeScreenState extends State<RecipeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(leading: Icon(Icons.arrow_back_ios)),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Container(
                  decoration: BoxDecoration(color: Colors.grey[300]),
                  child: Icon(widget.recipe.img, size: 350),
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(widget.recipe.name),
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
                      Text(": ${widget.recipe.preparationTime} min"),
                    ],
                  ),
                ],
              ),
              Column(
                children: [
                  Row(
                    children: [
                      Icon(Icons.person),
                      Text(": ${widget.recipe.quantity} pessoas"),
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
    );
  }
}
