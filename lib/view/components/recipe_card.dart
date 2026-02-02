import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../../notifier/recipe_list_notifier.dart';
import '../../notifier/favorite_list_notifier.dart';
import '../../model/recipe.dart';
import '../screen/recipe_screen.dart';

class RecipeGridList extends StatelessWidget {
  const RecipeGridList({super.key});

  List<RecipeCardItem> _buildRecipeItems(List<Recipe> recipes) {
    return recipes.map((recipe) {
      return RecipeCardItem(key: ValueKey(recipe.id), recipe: recipe);
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final recipeListNotifier = context.watch<RecipeListNotifier>();
    List<Recipe> recipes = recipeListNotifier.recipes;

    if (recipeListNotifier.isLoading && recipes.isEmpty) {
      return const Center(
        child: CircularProgressIndicator(color: Colors.redAccent),
      );
    }

    if (recipes.isEmpty) {
      return const Center(child: Text("Nenhuma receita encontrada."));
    }

    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        int crossAxisCount;
        double childAspectRatio;

        if (constraints.maxWidth >= 1070) {
          crossAxisCount = 3;
          childAspectRatio = 0.76;
        } else if (constraints.maxWidth >= 900) {
          crossAxisCount = 3;
          childAspectRatio = 0.70;
        } else if (constraints.maxWidth >= 600) {
          crossAxisCount = 2;
          childAspectRatio = 0.75;
        } else {
          return ListView.builder(
            itemCount: recipes.length,
            itemBuilder: (BuildContext context, int position) {
              return RecipeCardItem(
                key: ValueKey(recipes[position].id),
                recipe: recipes[position],
              );
            },
          );
        }

        return GridView.count(
          crossAxisCount: crossAxisCount,
          childAspectRatio: childAspectRatio,
          padding: const EdgeInsets.all(8),
          children: _buildRecipeItems(recipes),
        );
      },
    );
  }
}

class RecipeCardItem extends StatelessWidget {
  final Recipe recipe;

  const RecipeCardItem({super.key, required this.recipe});

  Widget _buildRecipeImage(String? imageUrl) {
    if (imageUrl == null || imageUrl.isEmpty) {
      return AspectRatio(
        aspectRatio: 16 / 9,
        child: Container(
          color: Colors.grey[300],
          child: const Center(
            child: Icon(Icons.image, size: 80, color: Colors.grey),
          ),
        ),
      );
    }

    return AspectRatio(
      aspectRatio: 16 / 9,
      child: CachedNetworkImage(
        imageUrl: imageUrl,
        fit: BoxFit.cover,
        placeholder: (context, url) => Container(
          color: Colors.grey[200],
          child: const Center(
            child: CircularProgressIndicator(color: Colors.redAccent),
          ),
        ),
        errorWidget: (context, url, error) => Container(
          color: Colors.grey[200],
          child: const Center(
            child: Icon(Icons.broken_image, size: 80, color: Colors.grey),
          ),
        ),
      ),
    );
  }

  Widget _buildTimeChip(int time) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.9),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.access_time, size: 16, color: Colors.black54),
          const SizedBox(width: 4),
          Text(
            "${time} min",
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    print('URL recebida para ${recipe.name}: ${recipe.img}');
    final favoriteListNotifier = context.watch<FavoriteListNotifier>();

    final bool isFavorite = favoriteListNotifier.favoriteRecipes.any(
      (r) => r.id == recipe.id,
    );

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) =>
                  RecipeScreen(recipe: recipe, cardStyle: "recipeCard"),
            ),
          );
        },

        child: Card(
          elevation: 8,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          clipBehavior: Clip.antiAlias,

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  _buildRecipeImage(recipe.img),

                  Positioned(
                    bottom: 8,
                    left: 8,
                    child: _buildTimeChip(recipe.preparationTime),
                  ),

                  Positioned(
                    top: 8,
                    right: 8,
                    child: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white.withOpacity(0.8),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 4,
                          ),
                        ],
                      ),
                      child: IconButton(
                        icon: Icon(
                          isFavorite ? Icons.favorite : Icons.favorite_border,
                          color: isFavorite ? Colors.red : Colors.grey,
                        ),
                        onPressed: () {
                          context.read<FavoriteListNotifier>().toggleFavorite(
                            recipe,
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),

              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      recipe.name,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 8),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: List.generate(5, (indexStar) {
                        return Icon(
                          Icons.star,
                          size: 20,
                          color: recipe.rate > indexStar
                              ? Colors.amber
                              : Colors.grey[300],
                        );
                      }),
                    ),
                    const SizedBox(height: 4),

                    // Categoria
                    Text(
                      recipe.category.displayName,
                      style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
