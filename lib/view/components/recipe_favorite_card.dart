import 'package:flutter/material.dart';
import 'package:projeto_receitas/logic/recipe_list_notifier.dart';
import 'package:projeto_receitas/logic/recipe_list_widget.dart';
import 'package:projeto_receitas/model/recipe.dart';

import '../screen/recipe_screen.dart';

class RecipeFavoriteCard extends StatelessWidget {
  final int index;

  const RecipeFavoriteCard({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    RecipeListNotifier recipeListNotifier = RecipeListWidget.of(context);
    Recipe recipe = recipeListNotifier.recipes[index];

    return Padding(
      padding: EdgeInsets.all(12.0),
      child: InkWell(
        onTap: () => {
          Navigator.of(context).push(
            MaterialPageRoute<bool>(
              builder: (BuildContext context) {
                return RecipeScreen(index: index);
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
                      child: Icon(
                        Icons.favorite_border,
                        color: Colors.red,
                        size: 30,
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
                    recipe.name,
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
