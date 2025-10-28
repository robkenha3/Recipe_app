import 'package:cloud_firestore/cloud_firestore.dart';

import '../../model/recipe.dart';
import '../connection/firestore_connection.dart';

Future<List<Recipe>> readAllRecipes() async {
  try {
    final QuerySnapshot<Map<String, dynamic>> recipeSnapshot = await dbRecipe
        .get();

    final List<Recipe> recipes = recipeSnapshot.docs.map((doc) {
      return Recipe.toObject(doc);
    }).toList();
    return recipes;
  } catch (e) {
    print('Erro ao ler receitas: $e');
    return [];
  }
}

Future<String> createRecipe(Recipe newRecipe) async {
  try {
    final DocumentReference recipeRef = await dbRecipe.add(newRecipe.toMap());
    String newRecipeId = recipeRef.id;
    return newRecipeId;
  } catch (e) {
    print("Erro ao criar receita: $e");
    return '';
  }
}

Future<void> updateRecipe(Recipe updatedRecipe) async {
  try {
    await dbRecipe.doc(updatedRecipe.id).update(updatedRecipe.toMap());
  } catch (e) {
    print("Erro em atualizar a receita: $e");
  }
}

Future<void> deleteRecipe(String recipeId) async {
  try {
    await dbRecipe.doc(recipeId).delete();
  } catch (e) {
    print("Erro ao deletar receita: $e");
  }
}
