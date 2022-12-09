import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:src/LocalDB/HistoryInfo.dart';

import '../UserInfo.dart';

// Methods for this class were inspired by https://www.youtube.com/watch?v=UpKrhZ0Hppk
// and the Flutter documentation https://docs.flutter.dev/cookbook/persistence/sqlite

class UserInfoDB {
  static final UserInfoDB instance = UserInfoDB._init();

  static Database? _database;

  UserInfoDB._init();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('userinfo.db');
    return _database!;
  }

  Future<Database> _initDB(String DBpath) async {
    final path = join(await getDatabasesPath(), DBpath);

    Database db = await openDatabase(path, version: 1, onCreate: _onCreate);
    return db;
  }

  Future _onCreate(Database db, int version) async {
    await db.execute(
        'CREATE TABLE history(id INTEGER PRIMARY KEY, name TEXT, calories INTEGER)');
    await db.execute(
        'CREATE TABLE user(id INTEGER PRIMARY KEY, name TEXT, weight INTEGER, height INTEGER, goalstatus INTEGER)');
  }

  Future<List<HistoryInfo>> readHistory() async {
    final db = await instance.database;

    final result = await db.query('history');

    return result.map((json) => HistoryInfo.fromJson(json)).toList();
  }

  Future<HistoryInfo> createHistoryEntry(HistoryInfo entry) async {
    final db = await instance.database;

    final addedID = await db.insert('history', entry.toMap());
    HistoryInfo cpy = HistoryInfo(name: entry.name, calories: entry.calories);
    return cpy;
  }

  void createUser(UserInfo user) async {
    final db = await instance.database;

    await db.insert('user', user.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<UserInfo?> getUser() async {
    final db = await instance.database;
    final List<Map<String, dynamic>> maps =
        await db.query('user', where: 'id = 0');
    if (maps.length == 0) {
      return null;
    }
    return UserInfo(
        id: maps[0]['id'],
        name: maps[0]['name'],
        weight: maps[0]['weight'],
        height: maps[0]['height'],
        goalStatus: maps[0]['goalstatus']);
  }

  Future<void> updateUser(UserInfo user) async {
    final db = await instance.database;

    await db.update(
      'user',
      user.toMap(),
      where: 'id = ?',
      whereArgs: [user.id],
    );
  }

  Future<void> deleteHistoryEntry(int entry_id) async {
    final db = await instance.database;

    await db.delete('history', where: 'id = ?', whereArgs: [entry_id]);
  }

  

  void clearDB() async {
    final db = await instance.database;
    db.delete('user');
  }
}
