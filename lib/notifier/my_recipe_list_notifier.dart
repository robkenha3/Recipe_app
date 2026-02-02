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
    loadMyRecipesNotifier();
  }

  Future<void> loadMyRecipesNotifier() async {
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

  Future<void> addMyRecipeNotifier(MyRecipe newRecipe) async {
    try {
      String newId = await createMyRecipe(newRecipe);
      MyRecipe myRecipeCopy = newRecipe.copyMyRecipe(newId);

      _myRecipes.add(myRecipeCopy);

      notifyListeners();
    } catch (e) {
      print("Erro ao adicionar receita: $e");
    }
  }

  Future<void> removeMyRecipeNotifier(String myrecipeId) async {
    try {
      await deleteMyRecipe(myrecipeId);

      _myRecipes.removeWhere((el) => el.id == myrecipeId);

      notifyListeners();
    } catch (e) {
      print("Erro ao deletar receita: $e");
    }
  }

  Future<void> updateMyRecipeNotifier(MyRecipe updateRecipe) async {
    try {
      await updateMyRecipe(updateRecipe);

      int index = _myRecipes.indexWhere((el) => el.id == updateRecipe.id);

      if (index != -1) {
        _myRecipes[index] = updateRecipe;
        notifyListeners();
      }
    } catch (e) {
      print("Erro ao atualizar receita: $e");
    }
  }
}
