import 'package:flutter_sqflite_demo/models/todos.dart';
import 'package:flutter_sqflite_demo/repo/repository.dart';

class TodosServices {
  Repository _repository = Repository();

  Future<int> insertData(Todos todos) async {
    return await _repository.insertTodosData("todos", todos.todoMap());
  }

  Future<List<Map<String, dynamic>>> readData() async {
    return await _repository.getData("todos");
  }

  Future<int> deleteData(int itemId) async {
    return await _repository.deleteData("todos", itemId);
  }

  Future<List<Map<String, dynamic>>> readByCategory(category) async {
    return await _repository.readTodosByCategory("todos", "category", category);
  }
}
