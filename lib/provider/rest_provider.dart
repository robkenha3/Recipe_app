import 'dart:async';

import 'package:dio/dio.dart';

import '../model/recipe.dart';

class RestProvider {
  static RestProvider helper = RestProvider._();
  RestProvider._();

  Dio dio = Dio();
  String baseUrl = "https://teste-26764-default-rtdb.firebaseio.com/";

  // Inserir receita no
  Future<void> insertRecipe(Recipe recipe) async {
    try {
      await dio.post("$baseUrl/recipes.json", data: recipe.objectToMap());
    } catch (e) {
      print("Erro ao inserir receita: $e");
    }
  }
}
