import 'package:cloud_firestore/cloud_firestore.dart';

import '../../model/recipe.dart';
import '../connection/firestore_connection.dart';

Future<List<Recipe>> readAllFavoriteRecipes() async {
  try {
    final QuerySnapshot<Map<String, dynamic>> favoriteSnapshot =
        await dbFavorite.get();
    final List<Recipe> favoriteRecipes = favoriteSnapshot.docs.map((doc) {
      return Recipe.toObject(doc);
    }).toList();

    return favoriteRecipes;
  } catch (e) {
    print('Erro ao ler receitas favoritas: $e');
    return [];
  }
}

Future<String> createFavoriteRecipe(Recipe newRecipe) async {
  try {
    final DocumentReference recipeRef = await dbFavorite.add(newRecipe.toMap());
    String newRecipeId = recipeRef.id;
    return newRecipeId;
  } catch (e) {
    print("Erro ao criar receita: $e");
    return '';
  }
}

Future<void> deleteFavoriteRecipe(String favoriteId) async {
  try {
    await dbFavorite.doc(favoriteId).delete();
  } catch (e) {
    print("Erro ao deletar receita favorita: $e");
  }
}
