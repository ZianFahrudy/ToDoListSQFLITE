import 'package:flutter/material.dart';
import 'package:flutter_sqflite_demo/ui/pages/category_page.dart';
import 'package:flutter_sqflite_demo/ui/pages/home_page.dart';
import 'package:flutter_sqflite_demo/ui/pages/todosByCategory_pages.dart';
import 'package:flutter_sqflite_demo/ui/pages/todos_page.dart';
import 'package:get/get.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      getPages: [
        GetPage(
          name: '/category',
          page: () => CategoryPage(),
        ),
        GetPage(name: '/todos', page: () => TodosPage()),
        GetPage(name: '/todosCategory', page: () => TodosCategoryPages())
      ],
      initialRoute: '/',
      home: HomePage(),
    );
  }
}
