import 'package:flutter/material.dart';
import 'package:projeto_receitas/logic/recipe_list_notifier.dart';
import 'package:projeto_receitas/logic/recipe_list_widget.dart';
import 'package:projeto_receitas/view/components/recipe_favorite_card.dart';

import '../../model/recipe.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({super.key});

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  @override
  Widget build(BuildContext context) {
    RecipeListNotifier recipeListNotifier = RecipeListWidget.of(context);
    List<Recipe> recipes = recipeListNotifier.recipes;
    recipeListNotifier.addListener(() {
      setState(() {});
    });

    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            "Receitas Favoritas",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ),
      body: ListView.builder(
        itemCount: recipes.length,
        itemBuilder: (BuildContext context, int position) {
          int newPosition = position % recipes.length;
          return RecipeFavoriteCard(index: newPosition);
        },
      ),
    );
  }
}
