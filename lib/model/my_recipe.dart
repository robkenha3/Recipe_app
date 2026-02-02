import 'package:cloud_firestore/cloud_firestore.dart';

class MyRecipe {
  String id;
  String name;
  String img;
  double preparationTime;
  int quantity;
  List<String> ingredients;
  List<String> instruction;
  String? category;

  MyRecipe({
    this.id = '',
    required this.name,
    required this.img,
    required this.preparationTime,
    required this.quantity,
    required this.ingredients,
    required this.instruction,
    this.category,
  });

  copyMyRecipe(String recipeId) {
    return MyRecipe(
      id: recipeId,
      name: name,
      img: img,
      preparationTime: preparationTime,
      quantity: quantity,
      ingredients: ingredients,
      instruction: instruction,
      category: category,
    );
  }

  factory MyRecipe.toObject(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return MyRecipe(
      id: doc.id,
      name: data["name"],
      img: data["img"],
      preparationTime: data["preparationTime"],
      quantity: data["quantity"],
      ingredients: List<String>.from(data["ingredients"]),
      instruction: List<String>.from(data["instruction"]),
      category: data["category"],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "name": name,
      "img": img,
      "preparationTime": preparationTime,
      "quantity": quantity,
      "ingredients": ingredients,
      "instruction": instruction,
      "category": category,
    };
  }
}
