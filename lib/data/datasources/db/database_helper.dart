import 'dart:async';

import 'package:ditonton/data/models/movie_table.dart';
import 'package:ditonton/data/models/tv_table.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static DatabaseHelper? _databaseHelper;
  DatabaseHelper._instance() {
    _databaseHelper = this;
  }

  factory DatabaseHelper() => _databaseHelper ?? DatabaseHelper._instance();

  static Database? _database;

  Future<Database?> get database async {
    if (_database == null) {
      _database = await _initDb();
    }
    return _database;
  }

  static const String _tblWatchlist = 'watchlist';

  Future<Database> _initDb() async {
    final path = await getDatabasesPath();
    final databasePath = '$path/ditonton.db';

    var db = await openDatabase(databasePath, version: 1, onCreate: _onCreate);
    return db;
  }

  void _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE  $_tblWatchlist (
        id INTEGER PRIMARY KEY,
        title TEXT,
        overview TEXT,
        posterPath TEXT,
        redirect TEXT
      );
    ''');
  }

  Future<int> insertWatchlistMovie(MovieTable movie) async {
    final db = await database;
    return await db!.insert(_tblWatchlist, movie.toJson());
  }

  Future<int> insertWatchlistTv(TvTable tv) async {
    final db = await database;
    return await db!.insert(_tblWatchlist, tv.toJson());
  }

  Future<int> removeWatchlist(int id, String redirect) async {
    final db = await database;
    return await db!.delete(
      _tblWatchlist,
      where: 'id = ? and redirect = ?',
      whereArgs: [id, redirect],
    );
  }

  Future<Map<String, dynamic>?> getWatchlistById(
      int id, String redirect) async {
    final db = await database;
    final results = await db!.query(
      _tblWatchlist,
      where: 'id = ? and redirect = ?',
      whereArgs: [id, redirect],
    );

    if (results.isNotEmpty) {
      return results.first;
    } else {
      return null;
    }
  }

  Future<List<Map<String, dynamic>>> getWatchlist() async {
    final db = await database;
    final List<Map<String, dynamic>> results = await db!.query(_tblWatchlist);

    return results;
  }
}
