import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:hive_todo_app/main.dart';
import 'package:hive_todo_app/model/todo_model.dart';
import 'package:hive_todo_app/todo_from_screen.dart';

final box = Hive.box<TodoModel>(todoBox);

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("TODOs"),
          actions: [
            IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder:
                        (context) => TodoFromScreen(
                          todoModel: TodoModel(
                            title: "",
                            description: "",
                            color: TodoColor.blue,
                          ),
                        ),
                  ),
                );
              },
              icon: Icon(Icons.add_circle_rounded),
            ),
          ],
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Center(
                child: Text(
                  "My TODO Items",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
                ),
              ),
            ),
            Expanded(
              child: ValueListenableBuilder<Box<TodoModel>>(
                valueListenable: box.listenable(),
                builder: (context, todoBox, child) {
                  final todoList = todoBox.values.toList();
                  if (todoList.isEmpty) {
                    return const Text('Empty');
                  }
                  return ListView.builder(
                    itemCount: todoList.length,
                    itemBuilder: (context, index) {
                      todoList[index].id = box.keyAt(index);
                      return TodoItem(todo: todoList[index]);
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TodoItem extends StatelessWidget {
  const TodoItem({super.key, required this.todo});

  final TodoModel todo;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(todo.description),
            backgroundColor: Colors.black,
            action: SnackBarAction(
              label: "Edite",
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => TodoFromScreen(todoModel: todo),
                  ),
                );
              },
            ),
          ),
        );
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 12),
        child: Dismissible(
          key: ValueKey<int>(todo.id),
          onDismissed: (direction) {
            if (direction == DismissDirection.endToStart) {
              box.delete(todo.id);
            }
          },
          confirmDismiss:
              (direction) async => direction == DismissDirection.endToStart,
          dismissThresholds: const {DismissDirection.endToStart: 0.3},
          background: Container(
            padding: EdgeInsets.all(12),
            color: Colors.red,
            child: Icon(Icons.delete),
          ),
          child: Container(
            padding: EdgeInsets.all(12),
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 4.0),
                      child: Icon(
                        Icons.edit_note,
                        size: 24,
                        color: Color(todo.color.code),
                      ),
                    ),
                    Text(
                      todo.title,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Color(todo.color.code),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 24),
                  child: Text(
                    todo.description,
                    textAlign: TextAlign.justify,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const Divider(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
