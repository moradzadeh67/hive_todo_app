import 'package:flutter/material.dart';
import 'package:hive_todo_app/model/todo_model.dart';

late TodoColor _selectedColor;

class TodoFromScreen extends StatelessWidget {
  TodoFromScreen({super.key, required this.todoModel});
  TodoModel todoModel;
  @override
  Widget build(BuildContext context) {
    _selectedColor = todoModel.color;
    final titleController = TextEditingController(text: todoModel.title);
    final descriptionController = TextEditingController(
      text: todoModel.description,
    );
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Todo Form"),
          leading: IconButton(
            icon: Icon(Icons.keyboard_arrow_left),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 12),
          child: Column(children: [_TodoColorSllector()]),
        ),
      ),
    );
  }
}

class _TodoColorSllector extends StatefulWidget {
  _TodoColorSllector({super.key});
  @override
  State<_TodoColorSllector> createState() => _TodoColorSllectorState();
}

class _TodoColorSllectorState extends State<_TodoColorSllector> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ColorItem(
          onTap: () => setState(() => _selectedColor = TodoColor.blue),
          colorCode: TodoColor.blue.code,
          isSelected: _selectedColor == TodoColor.blue,
        ),
        ColorItem(
          onTap: () => setState(() => _selectedColor = TodoColor.black),
          colorCode: TodoColor.black.code,
          isSelected: _selectedColor == TodoColor.black,
        ),
        ColorItem(
          onTap: () => setState(() => _selectedColor = TodoColor.green),
          colorCode: TodoColor.green.code,
          isSelected: _selectedColor == TodoColor.green,
        ),
        ColorItem(
          onTap: () => setState(() => _selectedColor = TodoColor.red),
          colorCode: TodoColor.red.code,
          isSelected: _selectedColor == TodoColor.red,
        ),
      ],
    );
  }
}

class ColorItem extends StatelessWidget {
  const ColorItem({
    super.key,
    required this.onTap,
    required this.isSelected,
    required this.colorCode,
  });

  final Function() onTap;
  final bool isSelected;
  final int colorCode;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        width: 30,
        height: 30,
        alignment: Alignment.center,
        margin: const EdgeInsets.all(3),
        padding: const EdgeInsets.all(3),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Color(colorCode),
        ),
        child: isSelected ? Icon(Icons.check) : null,
      ),
    );
  }
}
