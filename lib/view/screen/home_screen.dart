import 'package:flutter/material.dart';

import '../components/recipe_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    //PageView -> ver sobre isso para trocar o tabBar
    return DefaultTabController(
      length: 6,
      child: Scaffold(
        appBar: AppBar(
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
            RecipeCard(),
            Container(color: Colors.green),
            Container(color: Colors.red),
            Container(color: Colors.green),
            Container(color: Colors.red),
            Container(color: Colors.green),
          ],
        ),
      ),
    );
  }
}
