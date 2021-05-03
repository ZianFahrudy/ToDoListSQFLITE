import 'package:flutter/material.dart';
import 'package:flutter_sqflite_demo/models/todos.dart';
import 'package:flutter_sqflite_demo/services/todos_services.dart';
import 'package:get/get.dart';

class TodosCategoryPages extends StatefulWidget {
  @override
  _TodosCategoryPagesState createState() => _TodosCategoryPagesState();
}

class _TodosCategoryPagesState extends State<TodosCategoryPages> {
  TodosServices _todosServices = TodosServices();
  List<Todos> _listTodos = [];

  getTodosByCategory() async {
    final data = await _todosServices.readByCategory(Get.arguments.toString());

    for (var item in data) {
      setState(() {
        Todos todos = Todos();
        todos.title = item['title'];
        todos.description = item['description'];
        todos.todosDate = item['todosDate'];

        _listTodos.add(todos);
      });
    }
  }

  @override
  void initState() {
    getTodosByCategory();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(Get.arguments.toString())),
      body: ListView.builder(
          itemCount: _listTodos.length,
          itemBuilder: (ctx, i) => Card(
                child: ListTile(
                  title: Text(_listTodos[i].title),
                  subtitle: Text(_listTodos[i].description),
                  trailing: Text(_listTodos[i].todosDate),
                ),
              )),
    );
  }
}
