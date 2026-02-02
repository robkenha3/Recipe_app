import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../model/my_recipe.dart';
import '../../model/recipe.dart';
import '../../notifier/favorite_list_notifier.dart';
import '../../notifier/my_recipe_list_notifier.dart';
import '../screen/recipe_screen.dart';

class RecipeFavoriteMyListCard extends StatelessWidget {
  final dynamic recipe;
  final IconData icon;
  final String cardType;
  final String cardStyle;

  RecipeFavoriteMyListCard({
    super.key,
    required this.recipe,
    required this.icon,
    required this.cardType,
    required this.cardStyle,
  });

  @override
  Widget build(BuildContext context) {
    final favoriteNotifier = context.watch<FavoriteListNotifier>();
    final myRecipeNotifier = context.watch<MyRecipeListNotifier>();

    final bool isFavorite = favoriteNotifier.favoriteRecipes.any(
      (r) => r.id == recipe.id,
    );

    String categoryText = "Sem categoria";

    if (recipe is Recipe) {
      categoryText = recipe.category.displayName;
    } else if (recipe is MyRecipe) {
      categoryText = recipe.category ?? "Sem categoria";
    }

    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: InkWell(
        onTap: () => {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) =>
                  RecipeScreen(recipe: recipe, cardStyle: cardStyle),
            ),
          ),
        },
        child: Card(
          elevation: 6,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          child: Container(
            decoration: BoxDecoration(
              color: const Color.fromRGBO(60, 60, 60, 1),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 15, top: 10),
                      child: IconButton(
                        onPressed: () async {
                          if (cardType == "favorite") {
                            favoriteNotifier.toggleFavorite(recipe);
                          } else if (cardType == "myRecipes") {
                            await myRecipeNotifier.removeMyRecipeNotifier(
                              recipe.id,
                            );
                          }
                        },
                        icon: Icon(
                          cardType == "myRecipes"
                              ? Icons.delete
                              : (isFavorite
                                    ? Icons.favorite
                                    : Icons.favorite_border),
                          color: cardType == "myRecipes"
                              ? Colors.black
                              : Colors.red,
                          size: 28,
                        ),
                      ),
                    ),
                  ],
                ),

                buildRecipeImage(recipe),

                // Nome
                Padding(
                  padding: const EdgeInsets.only(left: 12, top: 8),
                  child: Text(
                    recipe.name,
                    style: const TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),

                // Categoria
                Padding(
                  padding: const EdgeInsets.only(left: 12, bottom: 12, top: 4),
                  child: Text(
                    categoryText,
                    style: const TextStyle(
                      fontSize: 15,
                      color: Colors.redAccent,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Widget buildRecipeImage(dynamic recipe) {
  final String? imageUrl = recipe.img;

  if (imageUrl == null || imageUrl.isEmpty) {
    return Container(
      height: 140,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.grey[800],
        borderRadius: BorderRadius.circular(12),
      ),
      child: const Center(
        child: Icon(Icons.image_not_supported, size: 60, color: Colors.white54),
      ),
    );
  }

  return ClipRRect(
    borderRadius: BorderRadius.circular(12),
    child: CachedNetworkImage(
      imageUrl: imageUrl,
      height: 140,
      width: double.infinity,
      fit: BoxFit.cover,
      placeholder: (_, __) => Container(
        height: 140,
        color: Colors.grey[700],
        child: const Center(
          child: CircularProgressIndicator(color: Colors.redAccent),
        ),
      ),
      errorWidget: (_, __, ___) => Container(
        height: 140,
        color: Colors.grey[700],
        child: const Center(
          child: Icon(Icons.broken_image, size: 60, color: Colors.white54),
        ),
      ),
    ),
  );
}
