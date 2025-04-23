// ignore_for_file: depend_on_referenced_packages

import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

import 'package:study_traker/model/studysession_model.dart';
import 'package:study_traker/model/subject_model.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();
  static Database? _database;

  DatabaseHelper._privateConstructor();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, 'study_tracker.db');
    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE subjects (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        totalHours REAL DEFAULT 0
      )
    ''');

    await db.execute('''
      CREATE TABLE sessions (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        subjectId INTEGER,
        startTime TEXT,
        endTime TEXT,
        duration REAL,
        FOREIGN KEY (subjectId) REFERENCES subjects (id)
      )
    ''');
  }

  // إضافة مادة
  Future<int> insertSubject(Subject subject) async {
    Database db = await instance.database;
    return await db.insert('subjects', subject.toMap());
  }

  // عرض كل المواد
  Future<List<Subject>> getAllSubjects() async {
    Database db = await instance.database;
    final result = await db.query('subjects');
    return result.map((map) => Subject.fromMap(map)).toList();
  }

  // تحديث مادة
  Future<int> updateSubject(Subject subject) async {
    Database db = await instance.database;
    return await db.update(
      'subjects',
      subject.toMap(),
      where: 'id = ?',
      whereArgs: [subject.id],
    );
  }

  // حذف مادة
  Future<int> deleteSubject(int id) async {
    Database db = await instance.database;
    return await db.delete('subjects', where: 'id = ?', whereArgs: [id]);
  }

  // إضافة جلسة
  Future<int> insertSession(StudySession session) async {
    Database db = await instance.database;
    return await db.insert('sessions', session.toMap());
  }

  // عرض الجلسات حسب المادة
  Future<List<StudySession>> getSessionsBySubject(int subjectId) async {
    Database db = await instance.database;
    final result = await db.query(
      'sessions',
      where: 'subjectId = ?',
      whereArgs: [subjectId],
    );
    return result.map((map) => StudySession.fromMap(map)).toList();
  }

  // عرض الجلسات حسب التاريخ (اختياري)
  Future<List<StudySession>> getSessionsByDate(String date) async {
    Database db = await instance.database;
    final result = await db.query(
      'sessions',
      where: 'startTime LIKE ?',
      whereArgs: ['$date%'], // مثال: "2025-04-20%"
    );
    return result.map((map) => StudySession.fromMap(map)).toList();
  }

  // حذف جلسة
  Future<int> deleteSession(int id) async {
    Database db = await instance.database;
    return await db.delete('sessions', where: 'id = ?', whereArgs: [id]);
  }
}
