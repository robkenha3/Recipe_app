import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../model/my_recipe.dart';
import '../../notifier/my_recipe_list_notifier.dart';
import '../components/recipe_favorite_myrecipe_card.dart';

class MyRecipeScreen extends StatelessWidget {
  const MyRecipeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final myRecNotifier = context.watch<MyRecipeListNotifier>();
    final List<MyRecipe> myRecipes = myRecNotifier.myRecipes;

    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text("Minhas Receitas")),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.add_circle, color: Colors.red, size: 35),
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: myRecipes.length,
        itemBuilder: (context, index) {
          return RecipeFavoriteMyListCard(
            recipe: myRecipes[index],
            icon: Icons.delete,
            cardType: "myRecipes",
            cardStyle: 'myRecipeCard',
          );
        },
      ),
    );
  }
}
