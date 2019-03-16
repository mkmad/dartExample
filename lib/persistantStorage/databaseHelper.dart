import 'dart:async';
import 'dart:io';

import 'package:flutter_app/models/user.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  // table info
  final String table = "dbTable";
  final String columnId = "dbColumnID";
  final String user = "dbUser";
  final String password = "dbPassword";

  // Internal constructor (this is required since this class is going
  // to be a singleton)
  DatabaseHelper.internal();

  // This is how you create a singleton class
  static final DatabaseHelper _instance = new DatabaseHelper.internal();
  factory DatabaseHelper() => _instance;

  // database instance
  static Database _db;

  // This is a getter for the _db variable
  Future<Database> get db async {
    return _db == null ? await initDB() : _db;
  }

  // Async function to fetch the file path
  Future<String> fetchFilePath() async {
    final Directory directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  // initialize the database
  Future<Database> initDB() async {
    // path to the database file
    String path = join(await fetchFilePath(), "main.db");

    // open a database connection, we also specify the onCreate
    // handler in the function
    Database dbClient =
        await openDatabase(path, version: 1, onCreate: _onCreate);
    return dbClient;
  }

  // The onCreate handler for openDatabase call
  void _onCreate(Database db, int version) async {
    // sql statement to create a table
    String sql = "create table $table"
        "($columnId integer primary key, "
        "$user text, "
        "$password text)";

    // execute the sql statement
    await db.execute(sql);
  }

  // CRUD functions

  // Insert a user
  Future<int> insertUser(User user) async {
    var dbClient = await db;
    // insert expects a map and the table name
    int res = await dbClient.insert(table, user.toMap());
    return res;
  }

  // Update User
  Future<int> updateUser(User user) async {
    var dbClient = await db;

    // Note how the update params are given
    // Also note how the user map is passed
    // to update similar to insert
    int res = await dbClient.update(table, user.toMap(),
        where: "$columnId=?", whereArgs: [user.id]);

    return res;
  }

  // Delete a user
  Future<int> deleteUser(int id) async {
    var dbClient = await db;

    // Note how the delete params are given
    int res =
        await dbClient.delete(table, where: "$columnId=?", whereArgs: [id]);

    return res;
  }

  // Fetch all Users
  Future<List> getAllUsers() async {
    var dbClient = await db;
    // sql to execute
    String sql = "select * from $table";
    // insert expects a map and the table name
    List res = await dbClient.rawQuery(sql);
    return res;
  }

  // Get a single user
  Future<User> getUser(int id) async {
    var dbClient = await db;
    // sql to execute
    String sql = "select * from $table where $columnId=$id";

    // returns a list of maps
    List res = await dbClient.rawQuery(sql);

    // create a user from map and return it
    return User.fromMap(res.first);
  }

  // Close a db connection
  Future<void> close() async {
    var dbClient = await db;
    return dbClient.close();
  }
}
