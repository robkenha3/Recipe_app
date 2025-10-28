import 'package:cloud_firestore/cloud_firestore.dart';

import '../../model/my_recipe.dart';
import '../connection/firestore_connection.dart';

Future<List<MyRecipe>> readAllMyRecipes() async {
  try {
    final QuerySnapshot<Map<String, dynamic>> recipeSnapshot = await dbMyRecipe.get();

    final List<MyRecipe> recipes = recipeSnapshot.docs.map((doc) {
      return MyRecipe.toObject(doc);
    }).toList();
    return recipes;
  } catch (e) {
    print('Erro ao ler receitas: $e');
    return [];
  }
}

Future<String> createMyRecipe(MyRecipe newRecipe) async {
  try {
    final DocumentReference recipeRef = await dbMyRecipe.add(newRecipe.toMap());
    String newRecipeId = recipeRef.id;
    return newRecipeId;
  } catch (e) {
    print("Erro ao criar receita: $e");
    return '';
  }
}

Future<void> updateMyRecipe(MyRecipe updatedRecipe) async {
  try {
    await dbMyRecipe.doc(updatedRecipe.id).update(updatedRecipe.toMap());
  } catch (e) {
    print("Erro em atualizar a receita: $e");
  }
}

Future<void> deleteMyRecipe(String recipeId) async {
  try {
    await dbMyRecipe.doc(recipeId).delete();
  } catch (e) {
    print("Erro ao deletar receita: $e");
  }
}
