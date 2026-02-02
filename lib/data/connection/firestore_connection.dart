import 'package:cloud_firestore/cloud_firestore.dart';

FirebaseFirestore _connection = FirebaseFirestore.instance;

CollectionReference<Map<String, dynamic>> dbRecipe = _connection.collection("Recipe");
CollectionReference<Map<String, dynamic>> dbMyRecipe = _connection.collection("MyRecipe");
CollectionReference<Map<String, dynamic>> dbFavorite = _connection.collection("Favorite");
