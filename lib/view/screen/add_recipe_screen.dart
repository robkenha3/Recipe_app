import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:projeto_receitas/view/components/image_picker_field.dart';
import 'package:projeto_receitas/view/screen/confirm_screen.dart';

import '../../model/my_recipe.dart';
import '../../notifier/my_recipe_list_notifier.dart';

class AddRecipeScreen extends StatefulWidget {
  final String title;

  const AddRecipeScreen({super.key, required this.title});

  @override
  State<AddRecipeScreen> createState() => _AddRecipeScreenState();
}

class _AddRecipeScreenState extends State<AddRecipeScreen> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController textControllerName = TextEditingController();
  TextEditingController textControllerTime = TextEditingController();
  TextEditingController textControllerServe = TextEditingController();

  final TextEditingController _newIngredientController =
      TextEditingController();
  final TextEditingController _newInstructionController =
      TextEditingController();

  final List<String> _ingredients = [];
  final List<String> _instructions = [];

  void _addIngredient() {
    String ingredient = _newIngredientController.text.trim();
    if (ingredient.isNotEmpty) {
      setState(() {
        _ingredients.add(ingredient);
        _newIngredientController.clear();
      });
    }
  }

  void _removeIngredient(int index) {
    setState(() {
      _ingredients.removeAt(index);
    });
  }

  void _addInstruction() {
    String instruction = _newInstructionController.text.trim();
    if (instruction.isNotEmpty) {
      setState(() {
        _instructions.add(instruction);
        _newInstructionController.clear();
      });
    }
  }

  void _removeInstruction(int index) {
    setState(() {
      _instructions.removeAt(index);
    });
  }

  bool _saveRecipe() {
    if (_formKey.currentState!.validate()) {
      final double? time = double.tryParse(textControllerTime.text);
      final int? quantity = int.tryParse(textControllerServe.text);
      final String name = textControllerName.text;
      if (name == "") {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Por favor, digite o nome da receita.")),
        );
        return false;
      }

      if (time == null || quantity == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              "Por favor, insira números válidos para Tempo e Porções.",
            ),
          ),
        );
        return false;
      }

      MyRecipe newMyRecipe = MyRecipe(
        name: name,
        img: 'URL_DA_IMAGEM_AQUI',
        preparationTime: time,
        quantity: quantity,

        ingredients: _ingredients,
        instruction: _instructions,
      );

      context.read<MyRecipeListNotifier>().addMyRecipeNotifier(newMyRecipe);
      return true;
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Center(child: Text(widget.title))),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 10),
                ImagePickerField(),
                SizedBox(height: 10),

                Text(
                  "Nome da Receita",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10),

                TextFormField(
                  controller: textControllerName,
                  decoration: InputDecoration(
                    hintText: "Nome da Receita",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15.0),
                      borderSide: BorderSide(color: Colors.grey, width: 0),
                    ),
                    isDense: true,
                  ),
                ),

                SizedBox(height: 10),
                Text(
                  "Tempo de Preparo",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10),

                TextFormField(
                  controller: textControllerTime,
                  decoration: InputDecoration(
                    hintText: "Tempo de Preparo em minutos",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15.0),
                      borderSide: BorderSide(color: Colors.grey, width: 0),
                    ),
                    isDense: true,
                  ),
                ),

                SizedBox(height: 10),
                Text(
                  "Quantidade de Pessoas",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10),

                TextFormField(
                  controller: textControllerServe,
                  decoration: InputDecoration(
                    hintText: "Quantidade de Pessoas",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15.0),
                      borderSide: BorderSide(color: Colors.grey, width: 0),
                    ),
                    isDense: true,
                  ),
                ),
                SizedBox(height: 10),

                _buildListField(
                  title: "Ingredientes",
                  list: _ingredients,
                  controller: _newIngredientController,
                  onAdd: _addIngredient,
                  onRemove: _removeIngredient,
                ),
                SizedBox(height: 10),

                _buildListField(
                  title: "Modo de Preparo",
                  list: _instructions,
                  controller: _newInstructionController,
                  onAdd: _addInstruction,
                  onRemove: _removeInstruction,
                ),
                SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  height: 35,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color.fromRGBO(240, 69, 57, 1),
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadiusGeometry.circular(15.0),
                      ),
                    ),
                    onPressed: () {
                      if (_saveRecipe() == true) {
                        Navigator.of(context).push(
                          MaterialPageRoute<bool>(
                            builder: (BuildContext context) {
                              return ConfirmScreen();
                            },
                          ),
                        );
                      }
                    },
                    child: Text("Salvar"),
                  ),
                ),
                SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Widget _buildListField({
  required String title,
  required List<String> list,
  required TextEditingController controller,
  required VoidCallback onAdd,
  required Function(int) onRemove,
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(title, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
      SizedBox(height: 5),

      Row(
        children: [
          Expanded(
            child: TextFormField(
              controller: controller,
              decoration: InputDecoration(
                hintText: "Adicionar novo item",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                isDense: true,
              ),
            ),
          ),
          SizedBox(width: 8),
          IconButton(
            icon: Icon(Icons.add_circle, color: Colors.red, size: 32),
            onPressed: onAdd,
          ),
        ],
      ),

      ListView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: list.length,
        itemBuilder: (context, index) {
          return ListTile(
            contentPadding: EdgeInsets.zero,
            leading: Text(
              "${index + 1}.",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            title: Text(list[index]),
            trailing: IconButton(
              icon: Icon(Icons.delete, size: 18),
              onPressed: () => onRemove(index),
            ),
          );
        },
      ),
    ],
  );
}
