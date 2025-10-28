import 'package:flutter/material.dart';
import 'package:projeto_receitas/view/components/home_screen_content.dart';
import 'package:projeto_receitas/view/screen/my_recipe_screen.dart';
import 'add_recipe_screen.dart';
import 'favorite_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    HomeScreenContent(),
    FavoriteScreen(),
    AddRecipeScreen(title: "Adicionar Receita"),
    MyRecipeScreen(),
    MyRecipeScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    void onItemTapped(int index) {
      setState(() {
        _selectedIndex = index;
      });
    }

    return Scaffold(
      body: IndexedStack(index: _selectedIndex, children: _pages),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: onItemTapped,

        type: BottomNavigationBarType.fixed,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Início"),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: "Favorito",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_circle, size: 30.0),
            label: "",
          ),
          BottomNavigationBarItem(icon: Icon(Icons.checklist), label: "Lista"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Perfil"),
        ],

        selectedItemColor: Color.fromRGBO(240, 69, 57, 1),
        unselectedItemColor: const Color.fromARGB(255, 112, 112, 112),
      ),
    );
  }
}
