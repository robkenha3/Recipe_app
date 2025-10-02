import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/manager_bloc.dart';
import '../model/recipe.dart';

class MyWidget extends StatefulWidget {
  const MyWidget({super.key});

  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ElevatedButton(
        onPressed: () {
          ManagerBloc bloc = BlocProvider.of<ManagerBloc>(context);
          Recipe recipe = Recipe(
            name: 'Macarrão à carbonara',
            img: Icons.food_bank,
            preparationTime: 15,
            rate: 5,
            quantity: 2,
            favorite: true,
            ingredients: [
              "bacon picado a gosto",
              "3 ovos",
              "pimenta-do-reino a gosto",
              "creme de leite se quiser dar um toque diferente à receita",
              "queijo ralado a gosto",
              "sal",
              "macarrão de sua escolha (espaguete, fusili,etc.)",
            ],
            instruction: [
              "Frite bem o bacon, até ficar crocante (pode-se adicionar salame picado).",
              "Coloque o macarrão para cozinhar em água e sal.",
              "No refratário onde será servido o macarrão, bata bem os ovos com um garfo.",
              "No refratário onde será servido o macarrão, bata bem os ovos com um garfo.",
              "Quando o macarrão estiver pronto, escorra e coloque (bem quente) sobre a mistura de ovos, misture bem.",
              "O calor da massa cozinha os ovos.",
              "Coloque o bacon, ainda quente, sobre o macarrão e sirva.",
            ],
          );
          bloc.add(SubmitEvent(recipe: recipe)); // lança evento
        },
        child: Text("Adicionar"),
      ),
    );
  }
}
