import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../notifier/recipe_list_notifier.dart';
import 'category_filter_bar.dart';
import 'recipe_card.dart';

class HomeScreenContent extends StatefulWidget {
  const HomeScreenContent({super.key});

  @override
  State<HomeScreenContent> createState() => _HomeScreenContentState();
}

class _HomeScreenContentState extends State<HomeScreenContent> {
  TextEditingController textController = TextEditingController();

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final recipeNotifier = context.watch<RecipeListNotifier>();

    return Scaffold(
      appBar: AppBar(
        title: TextField(
          controller: textController,
          onChanged: (value) {
            recipeNotifier.filterRecipes(value);
          },
          decoration: InputDecoration(
            hintText: "Buscar receita...",
            filled: true,
            fillColor: Colors.white,
            prefixIcon: Icon(Icons.search),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: BorderSide.none,
            ),
          ),
        ),
        backgroundColor: Colors.white,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 10),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: CategoryFilterBar(
              selected: recipeNotifier.selectedCategory,
              onSelected: (cat) => recipeNotifier.filterByCategory(cat),
            ),
          ),

          SizedBox(height: 15),

          Expanded(
            child: RecipeGridList(),
          ),
        ],
      ),
    );
  }
}
