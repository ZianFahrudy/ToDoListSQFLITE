import 'package:flutter/material.dart';
import 'package:flutter_sqflite_demo/models/todos.dart';
import 'package:flutter_sqflite_demo/services/category_services.dart';
import 'package:flutter_sqflite_demo/services/todos_services.dart';
import 'package:flutter_sqflite_demo/ui/widgets/drawer_card.dart';
import 'package:get/get.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TodosServices _todosServices = TodosServices();
  CategoryServices _categoryServices = CategoryServices();

  List<Todos> _listTodos = [];

  List<Widget> _listWidgetCategory = [];

  getCategoryData() async {
    final data = await _categoryServices.getData();

    data.forEach((e) {
      setState(() {
        _listWidgetCategory.add(GestureDetector(
          onTap: () {
            Get.toNamed('/todosCategory', arguments: e['name'].toString());
          },
          child: ListTile(
            title: Text(e['name']),
          ),
        ));
      });
    });
  }

  @override
  void initState() {
    loadTodosData();
    getCategoryData();

    super.initState();
  }

  loadTodosData() async {
    // _listTodos = List<Todos>();
    var data = await _todosServices.readData();

    data.forEach((item) {
      setState(() {
        Todos todos = Todos();
        todos.id = item['id'];
        todos.title = item['title'];
        todos.category = item['category'];
        todos.description = item['description'];
        todos.todosDate = item['todosDate'];

        _listTodos.add(todos);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notes'),
      ),
      drawer: DrawerCard(_listWidgetCategory),
      body: _listTodos.isEmpty
          ? Center(
              child: Text("No Todos"),
            )
          : ListView.builder(
              itemCount: _listTodos.length,
              itemBuilder: (context, i) {
                return Card(
                    elevation: 4,
                    child: ListTile(
                      title: Text(_listTodos[i].title),
                      subtitle: Text(_listTodos[i].category),
                      trailing: Text(_listTodos[i].todosDate),
                    ));
              }),
      floatingActionButton: FloatingActionButton(
          child: Text("Todos"),
          onPressed: () {
            Get.toNamed('/todos');
          }),
    );
  }
}
