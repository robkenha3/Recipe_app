import 'package:cloud_firestore/cloud_firestore.dart';

import 'recipe_category.dart';

class Recipe {
  String id;
  String name;
  String img;
  int preparationTime;
  int rate;
  int quantity;
  List<String> ingredients;
  List<String> instruction;
  RecipeCategory category;

  Recipe({
    this.id = '',
    required this.name,
    required this.img,
    required this.preparationTime,
    required this.rate,
    required this.quantity,
    required this.ingredients,
    required this.instruction,
    this.category = RecipeCategory.all,
  });

  copyRecipe(int updatedRate) {
    return Recipe(
      name: name,
      img: img,
      preparationTime: preparationTime,
      rate: updatedRate,
      quantity: quantity,
      ingredients: ingredients,
      instruction: instruction,
      category: category,
    );
  }

  // Fábrica de objetos, transforma: Map -> objeto
  factory Recipe.toObject(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return Recipe(
      id: doc.id,
      name: data["name"],
      img: data["img"],
      preparationTime: data["preparationTime"],
      rate: data["rate"],
      quantity: data["quantity"],
      ingredients: List<String>.from(data["ingredients"]),
      instruction: List<String>.from(data["instruction"]),
      category: parseCategory(data["category"]),
    );
  }
  // transforma: Objeto -> Map
  Map<String, dynamic> toMap() {
    return {
      "name": name,
      "img": img,
      "preparationTime": preparationTime,
      "rate": rate,
      "quantity": quantity,
      "ingredients": ingredients,
      "instruction": instruction,
      "category": category.name,
    };
  }

  static RecipeCategory parseCategory(dynamic value) {
    if (value == null) return RecipeCategory.all;

    if (value is String) {
      try {
        return RecipeCategory.values.firstWhere((e) => e.name == value);
      } catch (_) {
        return RecipeCategory.all;
      }
    }

    return RecipeCategory.all;
  }
}
