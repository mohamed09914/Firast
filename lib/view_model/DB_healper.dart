import 'dart:async';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import '../model/User.dart';
import '../model/login.dart';

class DatabaseHelper1 {
  final String tableUser = "login";
  final String columnId = "id";
  final String columnPassword = "password";

  static final DatabaseHelper1 _instance = new DatabaseHelper1.init();

  DatabaseHelper1.init();

  factory DatabaseHelper1() => _instance;

  static Database? _db;

  Future<Database> get db async {
    if (_db != null) {
      return _db!;
    }
    _db = await initDb();
    return _db!;
  }

  initDb() async {
    final documentDirectory = await getDatabasesPath();
    String path = join(documentDirectory, "mydatadb.db");
    var ourDb = await openDatabase(path, version:1, onCreate: _onCreate);
    return ourDb;
  }
  Future _onCreate(Database db, int version) async {
    await db.execute("CREATE TABLE $tableUser($columnId INTEGER KEY, $columnPassword TEXT)");
  }
  Future<int> saveLogin(Login user) async {
    var dbClient = await db;
    int result = await dbClient.insert(tableUser, user.toMap());
    return result;
  }
  Future<List> getAllLogin() async {
    var dbClient = await db;
    var result = await dbClient.rawQuery("SELECT * FROM $tableUser");
    return result.toList();
  }
  Future<int?> getCountLogin() async {
    var dbClient = await db;
    int? result = Sqflite.firstIntValue(await dbClient.rawQuery("SELECT COUNT(*) FROM $tableUser"));
    return result;
  }
  Future<Login?> getLogin(String pass) async {
    var dbClient = await db;
    var result = await dbClient
        .rawQuery("SELECT * FROM $tableUser WHERE $columnPassword = $pass");
    if (result.length == 0) return null;
    return new Login.fromMap(result.first);
    //END of Video 2
  }
  Future<int> deleteLogin(int userId) async {
    var dbClient = await db;
    return await dbClient
        .delete(tableUser, where: "$columnId = ?", whereArgs: [userId]);
  }
  Future<int> updateLogin(Login user) async {
    var dbClient = await db;
    return await dbClient.update(tableUser, user.toMap(),
        where: "$columnId = ? ", whereArgs: [user.id]);
  }
  Future close() async {
    var dbClient = await db;
    return dbClient.close();
  }
}