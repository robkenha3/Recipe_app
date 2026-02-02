import 'package:flutter/material.dart';
import '../../model/recipe_category.dart';

class CategoryFilterBar extends StatelessWidget {
  final RecipeCategory selected;
  final Function(RecipeCategory) onSelected;

  const CategoryFilterBar({required this.selected, required this.onSelected});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: RecipeCategory.values.map((cat) {
          final isSelected = cat == selected;

          return GestureDetector(
            onTap: () => onSelected(cat),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              margin: EdgeInsets.only(right: 10),
              decoration: BoxDecoration(
                color: isSelected ? Colors.redAccent : Colors.grey.shade200,
                borderRadius: BorderRadius.circular(30),
                boxShadow: isSelected
                    ? [
                        BoxShadow(
                          color: Colors.red.withOpacity(0.3),
                          blurRadius: 8,
                        ),
                      ]
                    : [],
              ),
              child: Text(
                categoryToText(cat),
                style: TextStyle(
                  color: isSelected ? Colors.white : Colors.black87,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  String categoryToText(RecipeCategory cat) {
    switch (cat) {
      case RecipeCategory.all:
        return "Todos";
      case RecipeCategory.chicken:
        return "Frango";
      case RecipeCategory.meat:
        return "Carne Vermelha";
      case RecipeCategory.fish:
        return "Peixe";
      case RecipeCategory.dessert:
        return "Sobremesa";
      case RecipeCategory.fit:
        return "Fit";
      case RecipeCategory.vegetarian:
        return "Vegetariano";
      case RecipeCategory.sauces:
        return "Molhos";
      case RecipeCategory.pasta:
        return "Massa";
      case RecipeCategory.japanese:
        return "Japones";
    }
  }
}
