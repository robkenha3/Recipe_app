import 'package:flutter/material.dart';
import 'package:projeto_receitas/view/screen/favorite_screen.dart';

import '../screen/home.dart';

class SearchRecipeBar extends StatefulWidget {
  const SearchRecipeBar({super.key});

  @override
  State<SearchRecipeBar> createState() => _SearchRecipeBarState();
}

class _SearchRecipeBarState extends State<SearchRecipeBar> {
  TextEditingController textController = TextEditingController();

  int _selectedIndex = 0;

  final List<Widget> _pages = [Home(), FavoriteScreen()];

  @override
  Widget build(BuildContext context) {
    void onItemTapped(int index) {
      setState(() {
        _selectedIndex = index;
      });
      Navigator.of(context).push(
        MaterialPageRoute<bool>(
          builder: (BuildContext context) {
            return _pages[_selectedIndex];
          },
        ),
      );
    }

    return DefaultTabController(
      length: 6,
      child: Scaffold(
        appBar: AppBar(
          // leading: Icon(Icons.arrow_back_ios),
          backgroundColor: Color.fromARGB(70, 218, 218, 218),
          title: Center(
            child: FractionallySizedBox(
              widthFactor: 0.85,
              child: TextField(
                controller: textController,
                onChanged: (value) => {setState(() {})},
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50.0),
                    borderSide: const BorderSide(
                      color: Colors.transparent,
                      width: 0,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50.0),
                    borderSide: const BorderSide(
                      color: Colors.transparent,
                      width: 0,
                    ),
                  ),
                  filled: true,
                  fillColor: Color.fromRGBO(255, 254, 254, 1),
                  prefixIcon: Icon(Icons.search, color: Colors.black),
                ),
              ),
            ),
          ),

          bottom: const TabBar(
            tabs: [
              Tab(icon: Icon(Icons.home)),
              Tab(text: "Café da manhã"),
              Tab(text: "Almoço"),
              Tab(text: "Jantar"),
              Tab(text: "Sobremesa"),
              Tab(text: "Fit"),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            Home(),
            Container(color: Colors.green),
            Container(color: Colors.red),
            Container(color: Colors.green),
            Container(color: Colors.red),
            Container(color: Colors.green),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _selectedIndex,
          onTap: (int index) {
            onItemTapped(index);
          },

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
      ),
    );
  }
}
