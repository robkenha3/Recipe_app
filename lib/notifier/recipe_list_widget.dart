import 'package:flutter/widgets.dart';

import 'recipe_list_notifier.dart';

class RecipeListWidget extends InheritedWidget {
  final RecipeListNotifier recipeListNotifier;

  @override
  const RecipeListWidget({
    super.key,
    required super.child,
    required this.recipeListNotifier,
  });

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) {
    return true;
  }

  static RecipeListNotifier of(BuildContext context) {
    RecipeListWidget? r = context
        .dependOnInheritedWidgetOfExactType<RecipeListWidget>();
    return r!.recipeListNotifier;
  }
}
