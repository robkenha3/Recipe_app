import 'package:flutter/material.dart';
import 'package:projeto_receitas/view/components/recipe_card.dart';
import 'package:projeto_receitas/view/screen/home_screen.dart';
import 'favorite_screen.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [HomeScreen(), FavoriteScreen(), RecipeCard()];
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
          BottomNavigationBarItem(icon: Icon(Icons.checklist), label: "Meu"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Perfil"),
        ],

        selectedItemColor: Colors.blue[800],
        unselectedItemColor: Colors.grey,
      ),
    );
  }
}
