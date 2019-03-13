import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

class DatabaseHelper {
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
    final String table = "dbTable";
    final String columnId = "dbColumnID";
    final String user = "dbUser";
    final String password = "dbPassword";

    // sql statement to create a table
    String sql = "create table $table"
        "($columnId integer primary key, "
        "$user text, "
        "$password text)";

    // execute the sql statement
    await db.execute(sql);
  }
}
