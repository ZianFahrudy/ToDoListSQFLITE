import 'package:flutter_sqflite_demo/models/category.dart';
import 'package:flutter_sqflite_demo/repo/repository.dart';

class CategoryServices {
  Repository _repo = Repository();

  CategoryServices() {
    _repo = Repository();
  }

  Future<int> saveCategory(Category category) async {
    return await _repo.insertData("categories", category.categoryMap());
  }

  Future<List<Map<String, dynamic>>> getData() async {
    return await _repo.getData("categories");
  }

  Future<List<Map<String, dynamic>>> getDatabyId(int catId) async {
    return await _repo.getDatabyId("categories", catId);
  }

  Future<int> updateData(Category category) async {
    return await _repo.updateData("categories", category.categoryMap());
  }

  Future<int> deleteData(int itemId) async {
    return await _repo.deleteData("categories", itemId);
  }
}
