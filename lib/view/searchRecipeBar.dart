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
      length: 5,
      child: Scaffold(
        appBar: AppBar(
          leading: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: Icon(Icons.arrow_back_ios),
          ),
          backgroundColor: Color.fromARGB(70, 218, 218, 218),
          // backgroundColor: Colors.white,
          title: Padding(
            padding: EdgeInsets.symmetric(horizontal: 200.0),
            child: Container(
              height: 40,
              decoration: BoxDecoration(
                color: Color.fromRGBO(255, 254, 254, 1),
                borderRadius: BorderRadius.circular(50.0),
              ),
              child: TextField(
                controller: textController,
                onChanged: (value) => {setState(() {})},
                decoration: InputDecoration(
                  border: InputBorder.none,
                  prefixIcon: Icon(Icons.search, color: Colors.black),
                ),
              ),
            ),
          ),
          bottom: const TabBar(
            tabs: [
              Tab(icon: Icon(Icons.coffee)),
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
            Home(),
            Container(color: Colors.red),
            Container(color: Colors.green),
            Container(color: Colors.red),
            Container(color: Colors.green),
          ],
        ), // actions: [SizedBox(width: 200)],
      ),
    );
  }
}
