import 'package:flutter/material.dart';
import 'package:flutter_sqflite_demo/models/category.dart';
import 'package:flutter_sqflite_demo/services/category_services.dart';

import 'package:get/get.dart';

class CategoryPage extends StatefulWidget {
  @override
  _CategoryPageState createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  TextEditingController _categoryController = TextEditingController();

  TextEditingController _categoryDescriptionController =
      TextEditingController();
  TextEditingController _updateCategoryController = TextEditingController();

  TextEditingController _updateCategoryDescriptionController =
      TextEditingController();

  CategoryServices _categoryServices = CategoryServices();
  var category;
  Category _category = Category();
  List<Category> categoryList = List<Category>();

  @override
  void initState() {
    getAllCategory();

    super.initState();
  }

  getCategoryById(BuildContext context, int id) async {
    category = await _categoryServices.getDatabyId(id);

    setState(() {
      _updateCategoryController.text = category[0]['name'] ?? "No name";
      _updateCategoryDescriptionController.text =
          category[0]['description'] ?? "No desc";
    });

    showUpdateCategoryDialog(context);
  }

  Future<void> getAllCategory() async {
    categoryList = List<Category>();
    final result = await _categoryServices.getData();

    for (var category in result) {
      setState(() {
        var categoryModel = Category();
        categoryModel.id = category['id'];
        categoryModel.name = category['name'];
        categoryModel.description = category['description'];

        categoryList.add(categoryModel);
      });
    }
  }

  showCategoryDialog() async {
    await showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text("Add Category"),
              content: SingleChildScrollView(
                child: Column(
                  children: [
                    TextField(
                      controller: _categoryController,
                      decoration: InputDecoration(
                        hintText: "Category",
                      ),
                    ),
                    TextField(
                      controller: _categoryDescriptionController,
                      decoration: InputDecoration(
                        hintText: "Description",
                      ),
                    )
                  ],
                ),
              ),
              actions: [
                FlatButton(
                    color: Colors.blue,
                    onPressed: () async {
                      _category.name = _categoryController.text;
                      _category.description =
                          _categoryDescriptionController.text;

                      final result =
                          await _categoryServices.saveCategory(_category);

                      if (result != null) {
                        _categoryController.clear();
                        _categoryDescriptionController.clear();
                        Get.back();

                        getAllCategory();
                      }
                    },
                    child: Text("Save")),
                FlatButton(
                    color: Colors.red,
                    onPressed: () {
                      Get.back();
                    },
                    child: Text("Cancel"))
              ],
            ));
  }

  showDeteleCategoryDialog(BuildContext context, int itemId) async {
    await showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text("are you sure delete category?"),
              actions: [
                FlatButton(
                    color: Colors.blue,
                    onPressed: () async {
                      await _categoryServices.deleteData(itemId);
                      Get.back();
                      setState(() {
                        getAllCategory();
                      });
                    },
                    child: Text("Delete")),
                FlatButton(
                    color: Colors.green,
                    onPressed: () {
                      Get.back();
                    },
                    child: Text("Cancel"))
              ],
            ));
  }

  showUpdateCategoryDialog(BuildContext context) async {
    await showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text("Edit Category"),
              content: SingleChildScrollView(
                child: Column(
                  children: [
                    TextField(
                      controller: _updateCategoryController,
                      decoration: InputDecoration(
                        hintText: "Category",
                      ),
                    ),
                    TextField(
                      controller: _updateCategoryDescriptionController,
                      decoration: InputDecoration(
                        hintText: "Description",
                      ),
                    )
                  ],
                ),
              ),
              actions: [
                FlatButton(
                    color: Colors.blue,
                    onPressed: () async {
                      _category.id = category[0]['id'];
                      _category.name = _updateCategoryController.text;
                      _category.description =
                          _updateCategoryDescriptionController.text;

                      var result =
                          await _categoryServices.updateData(_category);
                      if (result > 0) {
                        print(result);
                        Get.back();
                        getAllCategory();
                      }
                    },
                    child: Text("Update")),
                FlatButton(
                    color: Colors.red,
                    onPressed: () {
                      Get.back();
                    },
                    child: Text("Cancel"))
              ],
            ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Category'),
      ),
      body: ListView.builder(
          itemCount: categoryList.length == null ? [] : categoryList.length,
          itemBuilder: (ctx, i) => Card(
                child: ListTile(
                  leading: IconButton(
                    icon: Icon(Icons.edit),
                    onPressed: () {
                      getCategoryById(context, categoryList[i].id);
                    },
                  ),
                  title: Text(categoryList[i].name),
                  trailing: IconButton(
                    icon: Icon(
                      Icons.delete,
                      color: Colors.red,
                    ),
                    onPressed: () async {
                      showDeteleCategoryDialog(context, categoryList[i].id);
                      // await _categoryServices.deleteData(categoryList[i].id);
                    },
                  ),
                ),
              )),
      drawer: Drawer(
        child: Column(
          children: [
            UserAccountsDrawerHeader(
                currentAccountPicture: CircleAvatar(
                  child: Image.asset("assets/profile.jpg"),
                ),
                accountName: Text("Zian Fahrudy"),
                accountEmail: Text("zianfahrudy@gmail.com")),
            GestureDetector(
              onTap: () {
                Get.offNamed('/');
              },
              child: ListTile(
                leading: Icon(Icons.home),
                title: Text("Home"),
              ),
            ),
            GestureDetector(
              onTap: () {
                Get.offNamed('/category');
              },
              child: ListTile(
                leading: Icon(Icons.category),
                title: Text("Category"),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            showCategoryDialog();
          }),
    );
  }
}
