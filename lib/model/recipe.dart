import 'package:flutter/material.dart';

class Recipe {
  String name;
  IconData img;
  int preparationTime;
  int rate;
  int quantity;
  bool favorite;
  List<String> ingredients;
  List<String> instruction;

  Recipe({
    required this.name,
    required this.img,
    required this.preparationTime,
    required this.rate,
    required this.quantity,
    this.favorite = false,
    required this.ingredients,
    required this.instruction,
  });

  copyRecipe(int updatedRate) {
    return Recipe(
      name: name,
      img: img,
      preparationTime: preparationTime,
      rate: updatedRate,
      quantity: quantity,
      favorite: favorite,
      ingredients: ingredients,
      instruction: instruction,
    );
  }

  // Fábrica de objetos, transforma: Map -> objeto
  factory Recipe.mapToObject(Map<String, dynamic> recipe) {
    return Recipe(
      name: recipe["name"],
      img: recipe["img"],
      preparationTime: recipe["preparationTime"],
      rate: recipe["rate"],
      quantity: recipe["quantity"],
      favorite: recipe["favorite"],
      ingredients: recipe["ingredients"],
      instruction: recipe["instruction"],
    );
  }
  // transforma: Objeto -> Map
  Map<String, dynamic> objectToMap() {
    return {
      "name": name,
      // "img": img.toString(),
      "preparationTime": preparationTime,
      "rate": rate,
      "quantity": quantity,
      "favorite": favorite,
      "ingredients": ingredients,
      "instruction": instruction,
    };
  }
}
