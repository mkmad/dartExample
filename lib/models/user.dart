import 'package:flutter/material.dart';

class User {
  // class vars
  String _username;
  String _password;
  int _id;

  // getters
  String get username => this._username;
  String get password => this._password;
  int get id => this._id;

  // Named constructor
  User(this._username, this._password);

  // helper function to instantiate the class vars
  // from an object
  User.map(dynamic obj) {
    try {
      this._username = obj['username'];
      this._password = obj['password'];
      this._id = obj['id'];
    } catch (e) {
      debugPrint(e);
    }
  }

  // helper function to convert this obj into a map
  // Note: This is useful for json transfers
  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = new Map<String, dynamic>();

    map["username"] = this._username;
    map["password"] = this._password;
    map["id"] = this._id == null ? "" : this._id;

    return map;
  }

  // helper function to instantiate the class vars
  // from a map
  User.fromMap(Map<String, dynamic> map) {
    try {
      this._username = map['username'];
      this._password = map['password'];
      this._id = map['id'];
    } catch (e) {
      debugPrint(e);
    }
  }
}
