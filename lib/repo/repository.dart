import 'package:flutter_sqflite_demo/repo/db_con.dart';
import 'package:sqflite/sqflite.dart';

class Repository {
  DBConnection _dbConnection;

  Repository() {
    _dbConnection = DBConnection();
  }

  static Database _database;

  Future<Database> get database async {
    if (_database != null) return _database;
    _database = await _dbConnection.setDB();
    return _database;
  }

  Future<int> insertData(table, data) async {
    var conection = await database;

    return await conection.insert(table, data);
  }

  Future<int> insertTodosData(String table, Map<String, dynamic> data) async {
    var connection = await database;

    return await connection.insert(table, data);
  }

  Future<List<Map<String, dynamic>>> getData(String table) async {
    final connection = await database;

    return await connection.query(table);
  }

  Future<List<Map<String, dynamic>>> getDatabyId(
      String table, int itemId) async {
    final connection = await database;
    return await connection.query(table, where: "id=?", whereArgs: [itemId]);
  }

  Future<int> updateData(
    String table,
    Map<String, dynamic> data,
  ) async {
    final con = await database;

    return await con
        .update(table, data, where: "id=?", whereArgs: [data['id']]);
  }

  Future<int> deleteData(String table, int itemId) async {
    final con = await database;
    return await con.rawDelete("DELETE FROM $table WHERE id = $itemId");
  }

  Future<List<Map<String, dynamic>>> readTodosByCategory(
      String table, columnName, columnValue) async {
    final connection = await database;

    return await connection
        .query(table, where: "$columnName=?", whereArgs: [columnValue]);
  }
}
