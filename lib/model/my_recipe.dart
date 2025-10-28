import 'package:cloud_firestore/cloud_firestore.dart';

class MyRecipe {
  String id;
  String name;
  String img;
  double preparationTime;
  int quantity;
  List<String> ingredients;
  List<String> instruction;

  MyRecipe({
    this.id = '',
    required this.name,
    required this.img,
    required this.preparationTime,
    required this.quantity,
    required this.ingredients,
    required this.instruction,
  });

  copyRecipe(int updatedRate) {
    return MyRecipe(
      name: name,
      img: img,
      preparationTime: preparationTime,
      quantity: quantity,
      ingredients: ingredients,
      instruction: instruction,
    );
  }

  // Fábrica de objetos, transforma: Map -> objeto
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
    );
  }
  // transforma: Objeto -> Map
  Map<String, dynamic> toMap() {
    return {
      "name": name,
      "img": img,
      "preparationTime": preparationTime,
      "quantity": quantity,
      "ingredients": ingredients,
      "instruction": instruction,
    };
  }
}
