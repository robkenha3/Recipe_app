import 'package:flutter/material.dart';
import 'package:projeto_receitas/model/my_recipe.dart';
import 'package:projeto_receitas/notifier/my_recipe_list_notifier.dart';
// import 'package:projeto_receitas/notifier/recipe_list_notifier.dart';
import 'package:projeto_receitas/view/components/recipe_favorite_mylist_card.dart';
import 'package:provider/provider.dart';

// import '../../model/recipe.dart';

class MyRecipeScreen extends StatefulWidget {
  const MyRecipeScreen({super.key});

  @override
  State<MyRecipeScreen> createState() => _MyRecipeScreenState();
}

class _MyRecipeScreenState extends State<MyRecipeScreen> {
  @override
  Widget build(BuildContext context) {
    final myRecipeListNotifier = context.watch<MyRecipeListNotifier>();
    List<MyRecipe> myRecipes = myRecipeListNotifier.myRecipes;

    // recipeListNotifier.addListener(() {
    //   setState(() {});
    // });

    return Scaffold(
      appBar: AppBar(
        leading: Text(""),
        title: Center(
          child: Text(
            "Minhas Receitas",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.add_circle, color: Colors.red, size: 35),
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: myRecipes.length,
        itemBuilder: (BuildContext context, int position) {
          int newPosition = position % myRecipes.length;
          return RecipeFavoriteMyListCard(
            indexMyList: newPosition,
            icon: Icons.delete,
            cardType: "myRecipes",
            cardStyle: 'myRecipeCard',
          );
        },
      ),
    );
  }
}
