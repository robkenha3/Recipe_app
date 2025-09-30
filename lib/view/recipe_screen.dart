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
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
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
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(widget.recipe.name),
                Icon(Icons.favorite_border, color: Colors.red),
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
                          padding: const EdgeInsets.symmetric(horizontal: 1.0),
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
            Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 7.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Ingredientes:"),
                      Text("${widget.recipe.ingredients}"),
                      Text("Modo de Preparo"),
                      Text("${widget.recipe.instruction}"),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
