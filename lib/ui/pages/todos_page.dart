import 'package:flutter/material.dart';
import 'package:flutter_sqflite_demo/models/todos.dart';
import 'package:flutter_sqflite_demo/services/category_services.dart';
import 'package:flutter_sqflite_demo/services/todos_services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class TodosPage extends StatefulWidget {
  @override
  _TodosPageState createState() => _TodosPageState();
}

class _TodosPageState extends State<TodosPage> {
  TextEditingController _titleController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();
  TextEditingController _todoDateController = TextEditingController();

  List<DropdownMenuItem> listDropdownMenuitem = [];
  dynamic selectedValue;

  TodosServices _todosServices = TodosServices();

  @override
  void initState() {
    loadData();
    super.initState();
  }

  getTodosData() async {
    await _todosServices.readData();
  }

  Future<void> loadData() async {
    var categoryServices = CategoryServices();

    List<Map<String, dynamic>> category = await categoryServices.getData();

    // NOTE: JALAN
    // category.forEach((element) {
    //   setState(() {
    //     listDropdownMenuitem.add(DropdownMenuItem(
    //         value: element['name'], child: Text(element['name'])));
    //   });
    // });
    //
    for (var item in category) {
      setState(() {
        listDropdownMenuitem.add(
            DropdownMenuItem(value: item['name'], child: Text(item['name'])));
      });
    }
    // NOTE: GAK JALAN KALO PAKE MAP?
    // category.map((e) {
    //   setState(() {
    //     DropdownMenuItem(value: e['name'], child: Text(e['name']));
    //   });
    // });
  }

  // initialDate
  DateTime _dateTime = DateTime.now();

  selectedTodoDate(BuildContext context) async {
    final _pickedDate = await showDatePicker(
        context: context,
        initialDate: _dateTime,
        firstDate: DateTime(2000),
        lastDate: DateTime(2100));
    if (_pickedDate != null) {
      setState(() {
        _dateTime = _pickedDate;
        _todoDateController.text = DateFormat("yyyy-MM-dd").format(_pickedDate);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Todos'),
      ),
      body: Form(
        child: Column(
          children: [
            TextFormField(
              controller: _titleController,
              decoration:
                  InputDecoration(hintText: "Title", labelText: "Title"),
            ),
            TextFormField(
              controller: _descriptionController,
              decoration: InputDecoration(
                  hintText: "Description", labelText: "Description"),
            ),
            TextFormField(
              controller: _todoDateController,
              onTap: () {
                selectedTodoDate(context);
              },
              decoration: InputDecoration(
                  prefixIcon: Icon(Icons.date_range),
                  hintText: "Date",
                  labelText: "Date"),
            ),
            DropdownButtonFormField<dynamic>(
                hint: Text('Pilih Category'),
                value: selectedValue,
                items: listDropdownMenuitem,
                onChanged: (e) {
                  selectedValue = e;
                }),
            Container(
              height: 45,
              width: double.infinity,
              child: RaisedButton(
                  color: Colors.blue,
                  child: Text(
                    'Save',
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () async {
                    Todos _todos = Todos();

                    _todos.title = _titleController.text;
                    _todos.description = _descriptionController.text;
                    _todos.category = selectedValue.toString();
                    _todos.todosDate = _todoDateController.text;

                    await _todosServices.insertData(_todos);
                    Get.back();
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
