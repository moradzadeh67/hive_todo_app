import 'package:hive/hive.dart';

part 'todo_model.g.dart';

@HiveType(typeId: 0)
class TodoModel extends HiveObject {
  @HiveField(0)
  int id = -1;
  @HiveField(1)
  String title;
  @HiveField(2)
  String description;
  @HiveField(3)
  TodoColor color;

  TodoModel({
    required this.id,
    required this.title,
    required this.description,
    required this.color,
  });
}

@HiveType(typeId: 1)
enum TodoColor {
  @HiveField(0)
  green(0xFF24FD03),
  @HiveField(1)
  red(0xffFF0000),
  @HiveField(2)
  blue(0xff0000FF),
  @HiveField(3)
  black(0xFF000000);

  final int code;
  const TodoColor(this.code);
}
