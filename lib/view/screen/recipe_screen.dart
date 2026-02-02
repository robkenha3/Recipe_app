import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../model/my_recipe.dart';
import '../../model/recipe.dart';
import '../../notifier/favorite_list_notifier.dart';
import '../../notifier/recipe_list_notifier.dart';

class RecipeScreen extends StatelessWidget {
  final dynamic recipe;
  final String cardStyle;

  const RecipeScreen({
    super.key,
    required this.recipe,
    required this.cardStyle,
  });

  @override
  Widget build(BuildContext context) {
    final recipeListNotifier = context.watch<RecipeListNotifier>();
    final favoriteListNotifier = context.watch<FavoriteListNotifier>();

    // Converte para Recipe
    final Recipe recipeToDisplay = _normalizeToRecipe(recipe);

    // Se for uma receita criada pelo usuário, marcar isGeneralRecipe = false
    final bool isGeneralRecipe =
        cardStyle == "recipeCard" || recipe is Recipe;

    // Verifica favorito pela id
    final bool isFavorite = favoriteListNotifier.favoriteRecipes.any(
      (r) => r.id.isNotEmpty && r.id == recipeToDisplay.id,
    );

    // rating, tenta encontrar o índice da receita na lista geral
    final int indexInGeneral = recipeListNotifier.recipes.indexWhere(
      (r) => r.id == recipeToDisplay.id,
    );

    return Scaffold(
      appBar: _buildAppBar(context),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromARGB(255, 254, 254, 254),
              Color.fromARGB(255, 241, 241, 241),
              Color.fromARGB(255, 243, 243, 243),
              Color.fromARGB(255, 249, 249, 249),
            ],
            begin: Alignment.topCenter,
            end: AlignmentGeometry.bottomCenter,
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildRecipeImage(recipeToDisplay.img),
              const SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            recipeToDisplay.name,
                            style: const TextStyle(
                              fontSize: 26,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                            ),
                          ),
                        ),
                        if (cardStyle == "recipeCard")
                          IconButton(
                            icon: Icon(
                              isFavorite
                                  ? Icons.favorite
                                  : Icons.favorite_border,
                              color: Colors.red,
                              size: 32,
                            ),
                            onPressed: () async {
                             
                              await favoriteListNotifier.toggleFavorite(
                                recipeToDisplay,
                              );
                            },
                          ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _buildDetailChip(
                          icon: Icons.timer_outlined,
                          label: "${recipeToDisplay.preparationTime} min",
                        ),
                        _buildDetailChip(
                          icon: Icons.person_outline,
                          label: "${recipeToDisplay.quantity} pessoas",
                        ),
                        // Só mostra rating se a receita existir na lista geral (tem índice)
                        if (isGeneralRecipe && indexInGeneral != -1)
                          _buildRatingStars(
                            context,
                            indexInGeneral,
                            recipeListNotifier,
                          ),
                      ],
                    ),
                    const SizedBox(height: 30),
                    _buildSectionTitle("Ingredientes"),
                    const SizedBox(height: 10),
                    ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: recipeToDisplay.ingredients.length,
                      separatorBuilder: (_, __) => const Divider(
                        height: 1,
                        indent: 10,
                        endIndent: 10,
                        color: Colors.grey,
                      ),
                      itemBuilder: (_, indexIng) => ListTile(
                        contentPadding: EdgeInsets.zero,
                        leading: Icon(
                          Icons.check_circle_outline,
                          size: 20,
                          color: Colors.green[600],
                        ),
                        title: Text(
                          recipeToDisplay.ingredients[indexIng],
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.black87,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 30),
                    _buildSectionTitle("Modo de Preparo"),
                    const SizedBox(height: 10),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: recipeToDisplay.instruction.length,
                      itemBuilder: (_, indexIns) {
                        final int itemNumber = indexIns + 1;
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: 24,
                                height: 24,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color: Colors.redAccent.withOpacity(0.8),
                                  shape: BoxShape.circle,
                                ),
                                child: Text(
                                  "$itemNumber",
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: Text(
                                  recipeToDisplay.instruction[indexIns],
                                  style: const TextStyle(
                                    fontSize: 16,
                                    height: 1.4,
                                    color: Colors.black87,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Normaliza um object (Recipe ou MyRecipe) para Recipe.
  static Recipe _normalizeToRecipe(dynamic r) {
    if (r is Recipe) return r;
    if (r is MyRecipe) {
      return Recipe(
        id: r.id,
        name: r.name,
        img: r.img,
        preparationTime: r.preparationTime.toInt(),

        rate: 0,
        quantity: r.quantity,
        ingredients: r.ingredients,
        instruction: r.instruction,
      );
    }
    // se veio um Map ou outra coisa, tenta mapear
    if (r is Map<String, dynamic>) {
      return Recipe(
        id: r['id'] ?? '',
        name: r['name'] ?? '',
        img: r['img'] ?? '',
        preparationTime: (r['preparationTime'] is int)
            ? r['preparationTime']
            : (r['preparationTime'] ?? 0).toInt(),
        rate: r['rate'] ?? 0,
        quantity: r['quantity'] ?? 0,
        ingredients: List<String>.from(r['ingredients'] ?? []),
        instruction: List<String>.from(r['instruction'] ?? []),
      );
    }
    return Recipe(
      id: '',
      name: 'Receita',
      img: '',
      preparationTime: 0,
      rate: 0,
      quantity: 0,
      ingredients: [],
      instruction: [],
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
    );
  }

  Widget _buildRecipeImage(dynamic imageSource) {
    Widget imageWidget;

    if (imageSource is String && imageSource.startsWith('http')) {
      imageWidget = CachedNetworkImage(
        imageUrl: imageSource,
        fit: BoxFit.cover,
        placeholder: (context, url) => Container(
          color: Colors.grey[200],
          child: const Center(
            child: CircularProgressIndicator(color: Colors.red),
          ),
        ),
        errorWidget: (context, url, error) => Container(
          color: Colors.grey[200],
          child: const Icon(Icons.broken_image, size: 80, color: Colors.grey),
        ),
      );
    } else {
      imageWidget = Container(
        color: Colors.grey[300],
        child: const Icon(Icons.image, size: 200, color: Colors.grey),
      );
    }

    return ClipRRect(
      borderRadius: const BorderRadius.vertical(bottom: Radius.circular(25)),
      child: AspectRatio(aspectRatio: 16 / 9, child: imageWidget),
    );
  }

  Widget _buildDetailChip({required IconData icon, required String label}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 3,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 18, color: Colors.redAccent),
          const SizedBox(width: 6),
          Text(
            label,
            style: const TextStyle(fontSize: 14, color: Colors.black87),
          ),
        ],
      ),
    );
  }

  Widget _buildRatingStars(
    BuildContext context,
    int recipeIndex,
    RecipeListNotifier notifier,
  ) {
    final currentRate = (notifier.recipes.length > recipeIndex)
        ? notifier.recipes[recipeIndex].rate
        : 0;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(5, (indexStar) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 1.0),
          child: InkWell(
            customBorder: const CircleBorder(),
            onTap: () {
              context.read<RecipeListNotifier>().updateRating(
                recipeIndex,
                indexStar,
              );
            },
            child: Icon(
              Icons.star,
              size: 25,
              color: currentRate >= (indexStar)
                  ? Colors.amber
                  : Colors.grey[400],
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      decoration: BoxDecoration(
        color: Colors.redAccent.withOpacity(0.1),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Colors.redAccent,
        ),
      ),
    );
  }
}
