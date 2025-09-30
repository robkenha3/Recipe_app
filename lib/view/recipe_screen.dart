import 'package:flutter/material.dart';

import '../model/recipe.dart';

class RecipeScreen extends StatefulWidget {
  final Recipe recipe;
  final Function onRatingChange;

  const RecipeScreen({
    super.key,
    required this.recipe,
    required this.onRatingChange,
  });

  @override
  State<RecipeScreen> createState() => _RecipeScreenState();
}

class _RecipeScreenState extends State<RecipeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[300],
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),

      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromARGB(255, 254, 254, 254),
              Color.fromARGB(255, 241, 241, 241),
              Color.fromARGB(255, 243, 243, 243),
              Color.fromARGB(255, 249, 249, 249),
            ],
            begin: Alignment.topCenter,
            end: AlignmentGeometry.bottomCenter,
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(color: Colors.grey[300]),
                      child: Icon(widget.recipe.img, size: 350),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Text(
                          widget.recipe.name,
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 27),
                    child: Icon(
                      Icons.favorite_border,
                      color: Colors.red,
                      size: 40,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    children: [
                      Row(
                        children: [
                          Icon(Icons.timer_sharp),
                          Text(": ${widget.recipe.preparationTime} min"),
                        ],
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Row(
                        children: [
                          Icon(Icons.person),
                          Text(": ${widget.recipe.quantity}"),
                        ],
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(5, (index) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 1.0,
                            ),
                            child: InkWell(
                              customBorder: const CircleBorder(),
                              onTap: () {
                                widget.onRatingChange(index + 1);
                                widget.recipe.rate = index + 1;
                                setState(() {});
                              },
                              child: Icon(
                                Icons.star,
                                size: 25,
                                color: widget.recipe.rate < index + 1
                                    ? Colors.black
                                    : Colors.yellow[400],
                              ),
                            ),
                          );
                        }),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Text(
                  "Ingredientes:",
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                ),
              ),
              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: widget.recipe.ingredients.length,
                itemBuilder: (BuildContext context, int indexIng) {
                  final String ingredient = widget.recipe.ingredients[indexIng];
                  return ListTile(
                    leading: Icon(
                      Icons.circle,
                      size: 10,
                      color: Colors.green[200],
                    ),
                    title: Text(ingredient),
                  );
                },
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Text(
                  "Modo de Preparo:",
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                ),
              ),
              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: widget.recipe.instruction.length,
                itemBuilder: (BuildContext context, int indexIns) {
                  final String instruction =
                      widget.recipe.instruction[indexIns];
                  final int itemNumber = indexIns + 1;

                  return ListTile(
                    leading: Text(
                      "$itemNumber.",
                      style: TextStyle(fontSize: 15),
                    ),
                    title: Text(instruction),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
