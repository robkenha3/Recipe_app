import 'package:flutter/material.dart';

import 'home.dart';

class SearchRecipeBar extends StatefulWidget {
  const SearchRecipeBar({super.key});

  @override
  State<SearchRecipeBar> createState() => _SearchRecipeBarState();
}

class _SearchRecipeBarState extends State<SearchRecipeBar> {
  TextEditingController textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
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
          children: [Home(), Home(), Home(), Home(), Home(), Home()],
        ), // actions: [SizedBox(width: 200)],
      ),
    );
  }
}
