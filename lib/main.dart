import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:projeto_receitas/bloc/manager_bloc.dart';
import 'view/search_recipe_bar.dart';

void main() {
  runApp(RecipeApp());
}

class RecipeApp extends StatelessWidget {
  const RecipeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(create: ((context) => ManagerBloc()),
    child: MaterialApp(home: SearchRecipeBar()));
  }
}
