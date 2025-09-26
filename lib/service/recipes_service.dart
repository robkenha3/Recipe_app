import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;

import '../model/recipe.dart';

class RecipesService {
  final String _assetsPath = "assets/data/recipes.json";

  // Read
  Future<List<Recipe>> readRecipe() async {
    try {
      String content = await rootBundle.loadString(_assetsPath);
      List<dynamic> jsonList = jsonDecode(content);    
      return jsonList.map((el) => Recipe.mapToObject(el)).toList();
    } catch (e) {
      return [];
    }
  }

  // Create
  
}
