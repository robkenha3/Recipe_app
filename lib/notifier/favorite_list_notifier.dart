import 'package:flutter/material.dart';
import 'package:projeto_receitas/model/recipe.dart';
import '../data/api/favorite_api.dart';

class FavoriteListNotifier extends ChangeNotifier {
  List<Recipe> _favoriteRecipes = [];

  List<Recipe> get favoriteRecipes => _favoriteRecipes;

  FavoriteListNotifier() {
    loadFavoriteRecipes();
  }

  Future<void> loadFavoriteRecipes() async {
    _favoriteRecipes = await readAllFavoriteRecipes();
    notifyListeners();
  }

  Future<void> addFavoriteRecipe(Recipe recipe) async {
    favoriteRecipes.add(recipe);
    notifyListeners();
  }

  Future<void> removeFavoriteRecipe(String recipeId) async {
    favoriteRecipes.removeWhere((r) => r.id == recipeId);
    notifyListeners();
  }

  Future<void> toggleFavorite(Recipe recipe) async {
    bool isFav = _favoriteRecipes.any((r) => r.id == recipe.id);

    if (isFav) {
      // remover
      await deleteFavoriteRecipe(recipe.id);
      _favoriteRecipes.removeWhere((r) => r.id == recipe.id);
    } else {
      // adicionar
      String favId = await createFavoriteRecipe(recipe);
      recipe.id = favId;
      _favoriteRecipes.add(recipe);
    }

    notifyListeners();
  }
}
