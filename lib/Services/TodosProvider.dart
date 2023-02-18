import 'package:etido/Models/Todos.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

class TodosProvider extends ChangeNotifier {
  Map<String, TodoObject> _todoObjectMap = {};
  final box = GetStorage();

  Future initialize() async {
    await GetStorage.init();
    List<String> keys = List.from(box.getKeys());
    _todoObjectMap = keys.asMap().map((k, key) => MapEntry(key, TodoObject.fromMap(box.read(key))));
    notifyListeners();
  }

  void setTodo(TodoObject todoObject) {
    _todoObjectMap[todoObject.todoID] = todoObject;
    box.write(todoObject.todoID, todoObject.toMap());

    notifyListeners();
  }

  void removeTodo(String todoID) {
    _todoObjectMap.remove(todoID);
    notifyListeners();
  }

  List<TodoObject> get getTodos => _todoObjectMap.values.toList();
}
