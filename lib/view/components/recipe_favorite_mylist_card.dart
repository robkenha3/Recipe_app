import 'package:flutter/material.dart';
import 'package:projeto_receitas/notifier/my_recipe_list_notifier.dart';
import 'package:projeto_receitas/notifier/recipe_list_notifier.dart';
// import 'package:projeto_receitas/notifier/recipe_list_widget.dart';
import 'package:projeto_receitas/model/recipe.dart';
import 'package:provider/provider.dart';

import '../../model/my_recipe.dart';
import '../screen/recipe_screen.dart';

class RecipeFavoriteMyListCard extends StatelessWidget {
  final int indexFavorite;
  final int indexMyList;
  final IconData icon;
  final String cardType;
  final String cardStyle;

  const RecipeFavoriteMyListCard({
    super.key,
    this.indexFavorite = 0,
    this.indexMyList = 0,
    required this.icon,
    required this.cardType,
    required this.cardStyle,
  });

  @override
  Widget build(BuildContext context) {
    final recipeListNotifier = context.watch<RecipeListNotifier>();
    Recipe recipe = recipeListNotifier.recipes[indexFavorite];

    final myRecipeListNotifier = context.watch<MyRecipeListNotifier>();
    MyRecipe myRecipe = myRecipeListNotifier.myRecipes[indexMyList];

    return Padding(
      padding: EdgeInsets.all(12.0),
      child: InkWell(
        onTap: () => {
          Navigator.of(context).push(
            MaterialPageRoute<bool>(
              builder: (BuildContext context) {
                return RecipeScreen(
                  index: cardType == "favorite" ? indexFavorite : indexMyList,
                  cardStyle: cardStyle == "recipeCard"
                      ? cardStyle
                      : "myRecipeCard",
                );
              },
            ),
          ),
        },
        child: Card(
          child: Container(
            decoration: BoxDecoration(
              color: Color.fromRGBO(60, 60, 60, 1),
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 15, top: 10),
                      child: IconButton(
                        onPressed: () {},
                        icon: Icon(
                          icon,
                          color: icon == Icons.favorite_border
                              ? Colors.red
                              : Colors.black,
                          size: 30,
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [Icon(Icons.image, size: 100.0)],
                ),
                Padding(
                  padding: EdgeInsets.only(left: 10),
                  child: Text(
                    cardType == "favorite" ? recipe.name : myRecipe.name,
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Text(
                    "Categoria",
                    style: TextStyle(fontSize: 15, color: Colors.white),
                  ),
                ),
                SizedBox(height: 10),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
