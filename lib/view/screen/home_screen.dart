import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:projeto_receitas/view/components/home_screen_content.dart';
import 'package:projeto_receitas/view/screen/my_recipe_screen.dart';
import 'package:projeto_receitas/view/screen/profile_screen.dart';
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
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    void onItemTapped(int index) {
      final user = FirebaseAuth.instance.currentUser;

      // Bloquea páginas se não estiver logado
      if ((index == 2 || index == 3) && user == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Faça login para acessar essa funcionalidade"),
          ),
        );
        return;
      }

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
        items: const <BottomNavigationBarItem>[
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
        unselectedItemColor: Color.fromARGB(255, 112, 112, 112),
      ),
    );
  }
}
