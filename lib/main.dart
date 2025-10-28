import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:projeto_receitas/firebase_options.dart';
import 'package:projeto_receitas/notifier/my_recipe_list_notifier.dart';
import 'package:projeto_receitas/notifier/recipe_list_notifier.dart';
// import 'package:projeto_receitas/notifier/recipe_list_notifier.dart';
// import 'package:projeto_receitas/notifier/recipe_list_widget.dart';
import 'package:provider/provider.dart';
import 'view/screen/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(RecipeApp());
}

class RecipeApp extends StatelessWidget {
  const RecipeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) {
            return RecipeListNotifier();
          },
        ),
        ChangeNotifierProvider(
          create: (BuildContext context) {
            return MyRecipeListNotifier();
          },
        ),
      ],
      child: MaterialApp(home: HomeScreen()),
    );
  }
}
