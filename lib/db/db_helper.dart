import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:sqflite/sqflite.dart' as sql;

class SQLHelper {
  static Future<void> createTables(sql.Database database) async {
    await database.execute("""CREATE TABLE block(
        id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
        name TEXT,
        row TEXT,
        model TEXT
      )
      """);
  }

  static Future<sql.Database> db() async {
    return sql.openDatabase(
      'azuratest.db',
      version: 1,
      onCreate: (sql.Database database, int version) async {
        await createTables(database);
      },
    );
  }

  static Future<int> createBlockItem(String? name, String? row, String? model) async {
    final db = await SQLHelper.db();

    final data = {'name': name,  'row':row , 'model':model };
    final id = await db.insert('block', data,
        conflictAlgorithm: sql.ConflictAlgorithm.replace);
    return id;
  }

  static Future<List<Map<String, dynamic>>> getBlocks() async {
    final db = await SQLHelper.db();
    return db.query('block', orderBy: "id");
  }

  static Future<List<Map<String, dynamic>>> getBlock(int id) async {
    final db = await SQLHelper.db();
    return db.query('block', where: "id = ?", whereArgs: [id], limit: 1);
  }

}