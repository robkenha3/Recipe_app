import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../model/recipe.dart';
import '../../notifier/favorite_list_notifier.dart';
import '../components/recipe_favorite_myrecipe_card.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final favoriteNotifier = context.watch<FavoriteListNotifier>();
    final List<Recipe> favoriteRecipes = favoriteNotifier.favoriteRecipes;

    if (favoriteRecipes.isEmpty) {
      return Scaffold(
        appBar: AppBar(title: Center(child: const Text("Receitas Favoritas"))),
        body: const Center(
          child: Text(
            "Nenhuma receita favoritada ainda!",
            style: TextStyle(fontSize: 18),
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text(
            "Receitas Favoritas",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ),
      body: ListView.builder(
        itemCount: favoriteRecipes.length,
        itemBuilder: (context, index) {
          return RecipeFavoriteMyListCard(
            recipe: favoriteRecipes[index],
            icon: Icons.favorite,
            cardType: 'favorite',
            cardStyle: 'recipeCard',
          );
        },
      ),
    );
  }
}
