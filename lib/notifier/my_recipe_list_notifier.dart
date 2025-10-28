import 'package:flutter/material.dart';

import '../data/api/my_recipe_api.dart';
import '../model/my_recipe.dart';

class MyRecipeListNotifier extends ChangeNotifier {
  List<MyRecipe> _myRecipes = [];
  bool isLoading = true;

  List<MyRecipe> get myRecipes {
    return _myRecipes;
  }

  MyRecipeListNotifier() {
    loadMyRecipes();
  }

  Future<void> loadMyRecipes() async {
    isLoading = true;
    notifyListeners();

    try {
      _myRecipes = await readAllMyRecipes();
    } catch (e) {
      print("Erro ao carregar minhas receitas: $e");
      _myRecipes = [];
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
