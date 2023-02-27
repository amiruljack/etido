import 'package:etido/Models/Todos.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

/// A provider class to manage the list of to-do objects.
///
/// This provider class uses [GetStorage] for data persistence and [ChangeNotifier]
/// for notifying listeners of changes to the list of to-do objects.
class TodosProvider extends ChangeNotifier {
  /// A map of to-do objects where the keys are the IDs of the to-do objects.
  Map<String, TodoObject> _todoObjectMap = {};

  /// An instance of [GetStorage] used for data persistence.
  final box = GetStorage();

  /// Initializes the provider by initializing the [GetStorage] instance and reading
  /// all stored to-do objects into the [_todoObjectMap].
  ///
  /// This method must be called before any other method of the provider.
  ///
  /// Throws an exception if [GetStorage.init()] fails.
  Future initialize() async {
    await GetStorage.init();
    List<String> keys = List.from(box.getKeys());
    _todoObjectMap = keys.asMap().map((k, key) => MapEntry(key, TodoObject.fromMap(box.read(key))));
    notifyListeners();
  }

  /// Adds a new to-do object to the [_todoObjectMap] and persists it using [GetStorage].
  ///
  /// If a to-do object with the same ID already exists in the [_todoObjectMap], it will
  /// be replaced with the new to-do object.
  void setTodo(TodoObject todoObject) {
    _todoObjectMap[todoObject.todoID] = todoObject;
    box.write(todoObject.todoID, todoObject.toMap());

    notifyListeners();
  }

  /// Removes a to-do object with the specified ID from the [_todoObjectMap] and deletes
  /// it from the [GetStorage] instance.
  void removeTodo(String todoID) {
    _todoObjectMap.remove(todoID);
    box.remove(todoID);
    notifyListeners();
  }

  /// Returns a list of all to-do objects stored in the [_todoObjectMap].
  List<TodoObject> get getTodos => _todoObjectMap.values.toList();
}
