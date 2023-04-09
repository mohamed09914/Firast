import 'dart:async';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../model/user.dart';

class DatabaseHelper {

  final String tableUser = "userTable";
  final String columnId = "id";
  final String columnName = "username";
  final String columnCounter = "counter";
  final String columnLoction = "Loction";
  final String columnNotice = "Notice";
  final String columnOffice = "Office";
  final String columnPhone = "Phone";
  final String columnState = "State";
  final String columnTime = "Time";
  final String columnType = "Type";

  //Singlton
  static final DatabaseHelper _instance = new DatabaseHelper._init();
  //internal can be any name
  DatabaseHelper._init();
  //to cashe all the states of the Database  - better for memory
  //not create new DB helper
  factory DatabaseHelper() => _instance;

  //Database reference
  static Database? _db;

  Future<Database> get db async {
    if (_db != null) {
      return _db!;
    }
    _db = await initDb();
    return _db!;
  }

  Future<Database> initDb() async {
    final documentDirectory = await getDatabasesPath();
    final path = join(documentDirectory, "maindb.db");
    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    await db.execute("CREATE TABLE $tableUser($columnId INTEGER KEY,$columnName TEXT,$columnCounter TEXT,$columnLoction TEXT,$columnNotice TEXT,$columnOffice TEXT,$columnPhone TEXT,$columnState TEXT,$columnTime TEXT,$columnType TEXT)"
        );
  }
  //CRUD - Create Read Update DELETE
  //READ
  Future<int> saveUser(User user) async {
    //will call get db from above
    var dbClient = await db;
    //result of insert is number
    int result = await dbClient.insert(tableUser, user.toMap());
    return result;
  }
  //GET USERS
  Future<List> getAllUsers() async {
    var dbClient = await db;
    var result = await dbClient.rawQuery("SELECT * FROM $tableUser");
    return result;
  }

  Future<User?> getUser(int userId) async {
    var dbClient = await db;
    var result = await dbClient
        .rawQuery("SELECT * FROM $tableUser WHERE $columnId = $userId");
    if (result.length == 0) return null;
    return new User.fromMap(result.first);
    //END of Video 2
  }

  Future<int> deleteUser(int userId) async {
    var dbClient = await db;
    return await dbClient
        .delete(tableUser, where: "$columnId = ?", whereArgs: [userId]);
  }

  Future<int> updateUser(User user) async {
    var dbClient = await db;
    return await dbClient.update(tableUser, user.toMap(),
        where: "$columnId = ? ", whereArgs: [user.id]);
  }

  Future close() async {
    var dbClient = await _instance.db;
    return dbClient.close();
  }
//End of Video 3
}