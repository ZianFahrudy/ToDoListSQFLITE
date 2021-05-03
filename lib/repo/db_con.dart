import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DBConnection {
  Future<Database> setDB() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = join(directory.path, 'ziansqflite.db');
    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute(
        "CREATE TABLE categories(id INTEGER PRIMARY KEY AUTOINCREMENT , name TEXT, description TEXT)");

    await db.execute(
        "CREATE TABLE todos(id INTEGER PRIMARY KEY, title TEXT, description TEXT, todosDate TEXT, category TEXT)");
  }
}
