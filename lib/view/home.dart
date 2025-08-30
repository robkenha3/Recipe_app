import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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

        // actions: [SizedBox(width: 200)],
      ),
    );
  }
}
