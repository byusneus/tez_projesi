import 'dart:async';
import 'dart:io';

import 'package:bitirme_odevi/model/conversation.dart';
import 'package:bitirme_odevi/model/meeting.dart';
import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:synchronized/synchronized.dart';

class DatabaseHelper {
  static DatabaseHelper _databaseHelper;
  static Database _database;


  factory DatabaseHelper() {
    if (_databaseHelper == null) {
      _databaseHelper = DatabaseHelper._internal();
      return _databaseHelper;
    } else {
      return _databaseHelper;
    }
  }
  DatabaseHelper._internal();

  Future<Database> _getDatabase() async {
    if (_database == null) {
      _database = await _initializeDatabase();
      return _database;
    } else {
      return _database;
    }
  }

  Future<Database> _initializeDatabase() async {
    Directory klasor = await getApplicationDocumentsDirectory();
    String path = join(klasor.path, "kayit.db");

    var kayitDB = await openDatabase(path, version: 1, onCreate: _createDB);

    return kayitDB;
  }

  FutureOr<void> _createDB(Database db, int version) async {
    await db.execute("CREATE TABLE 'conversation' ( 'conversationID' INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, 'conversationUser' TEXT NOT NULL, 'conversationNote' TEXT, 'conversationDate' TEXT NOT NULL )");
    await db.execute("CREATE TABLE 'meeting' ( 'meetingID'	INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, 'meetingDep'	TEXT NOT NULL, 'meetingNote'	TEXT, 'meetingDate'	TEXT NOT NULL )");

  }

  Future<List<Map<String, dynamic>>> conversationRead() async {
    var db = await _getDatabase();
    var sonuc = await db.query("conversation", orderBy: 'conversationID DESC');
    return sonuc;
  }

  Future<int> conversationCreate(Conversation conversation) async {
    var db = await _getDatabase();
    var sonuc = await db.insert("conversation", conversation.toMap());
    return sonuc;
  }

  Future<int> conversationUpdate(Conversation conversation) async {
    var db = await _getDatabase();
    var sonuc = await db.update("conversation", conversation.toMap(),
        where: 'conversationID= ?', whereArgs: [conversation.conversationID]);
    return sonuc;
  }

  Future<int> conversationDelete(int conversationID) async {
    var db = await _getDatabase();
    var sonuc = await db.delete("conversation",
        where: 'conversationID= ?', whereArgs: [conversationID]);
    return sonuc;
  }

  Future<List<Map<String, dynamic>>> meetingRead() async {
    var db = await _getDatabase();
    var sonuc = await db.query("meeting", orderBy: 'meetingID DESC');
    return sonuc;
  }

  Future<int> meetingCreate(Meeting meeting) async {
    var db = await _getDatabase();
    var sonuc = await db.insert("meeting", meeting.toMap());
    return sonuc;
  }

  Future<int> meetingUpdate(Meeting meeting) async {
    var db = await _getDatabase();
    var sonuc = await db.update("meeting", meeting.toMap(),
        where: 'meetingID= ?', whereArgs: [meeting.meetingID]);
    return sonuc;
  }

  Future<int> meetingDelete(int meetingID) async {
    var db = await _getDatabase();
    var sonuc = await db
        .delete("meeting", where: 'meetingID= ?', whereArgs: [meetingID]);
    return sonuc;
  }
}
