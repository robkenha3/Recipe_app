import 'package:flutter/material.dart';
import 'package:projeto_receitas/logic/recipe_list_notifier.dart';
import 'package:projeto_receitas/logic/recipe_list_widget.dart';
import 'view/search_recipe_bar.dart';

void main() {
  runApp(RecipeApp());
}

class RecipeApp extends StatelessWidget {
  const RecipeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return RecipeListWidget(
      recipeListNotifier: RecipeListNotifier(),
      child: MaterialApp(home: SearchRecipeBar()),
    );
  }
}
