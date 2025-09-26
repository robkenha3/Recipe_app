import 'package:flutter/material.dart';
import 'view/search_recipe_bar.dart';

void main() {
  runApp(RecipeApp());
}

class RecipeApp extends StatelessWidget {
  const RecipeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: SearchRecipeBar());
  }
}
