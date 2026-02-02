import 'package:flutter/material.dart';
import 'package:projeto_receitas/data/api/recipe_api.dart';

import '../model/recipe.dart';
import '../model/recipe_category.dart';

class RecipeListNotifier extends ChangeNotifier {
  List<Recipe> _recipes = [];          
  List<Recipe> _filteredRecipes = []; 
  bool isLoading = true;

  String searchQuery = "";
  RecipeCategory selectedCategory = RecipeCategory.all;

  List<Recipe> get recipes => _filteredRecipes;

  RecipeListNotifier() {
    loadRecipes();
  }

  Future<void> loadRecipes() async {
    isLoading = true;
    notifyListeners();

    try {
      _recipes = await readAllRecipes();

      _filteredRecipes = _recipes;
    } catch (e) {
      print("Erro ao carregar receitas: $e");
      _recipes = [];
      _filteredRecipes = [];
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  // Filtrar por texto (busca por nome)
  void filterRecipes(String query) {
    searchQuery = query.toLowerCase();
    applyFilters();
  }


  // Filtrar por categoria (enum)
  void filterByCategory(RecipeCategory category) {
    selectedCategory = category;
    applyFilters();
  }


  void applyFilters() {
    List<Recipe> filtered = _recipes;

    // Filtro por categoria
    if (selectedCategory != RecipeCategory.all) {
      filtered = filtered.where((recipe) {
        return recipe.category == selectedCategory;
      }).toList();
    }

    // Filtro por texto
    if (searchQuery.isNotEmpty) {
      filtered = filtered.where((recipe) {
        return recipe.name.toLowerCase().contains(searchQuery);
      }).toList();
    }

    _filteredRecipes = filtered;
    notifyListeners();
  }


  void updateRating(int index, int updatedRate) {
    Recipe recipe = _recipes[index];
    _recipes[index] = recipe.copyRecipe(updatedRate);

    applyFilters();
    notifyListeners();
  }
}
