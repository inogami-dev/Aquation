import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('aquation_ai_insights.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE ai_insights (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        timestamp TEXT NOT NULL,
        temperature REAL NOT NULL,
        ph_level REAL NOT NULL,
        dissolved_oxygen REAL NOT NULL,
        turbidity REAL NOT NULL,
        insight TEXT NOT NULL,
        feedback TEXT
      )
    ''');
  }

  /// Inserts a new AI insight analysis record alongside the sensor values.
  /// Returns the generated record ID.
  Future<int> insertInsight({
    required double temperature,
    required double phLevel,
    required double dissolvedOxygen,
    required double turbidity,
    required String insight,
  }) async {
    final db = await instance.database;
    final row = {
      'timestamp': DateTime.now().toIso8601String(),
      'temperature': temperature,
      'ph_level': phLevel,
      'dissolved_oxygen': dissolvedOxygen,
      'turbidity': turbidity,
      'insight': insight,
      'feedback': '',
    };
    return await db.insert('ai_insights', row);
  }

  /// Updates the user feedback on an existing insight record.
  Future<int> updateFeedback(int id, String feedback) async {
    final db = await instance.database;
    return await db.update(
      'ai_insights',
      {'feedback': feedback},
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  /// Fetches all stored insights sorted chronologically (newest first).
  Future<List<Map<String, dynamic>>> getInsights() async {
    final db = await instance.database;
    return await db.query('ai_insights', orderBy: 'timestamp DESC');
  }

  /// Deletes a specific stored insight record.
  Future<int> deleteInsight(int id) async {
    final db = await instance.database;
    return await db.delete(
      'ai_insights',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  /// Closes the active database connection.
  Future close() async {
    final db = _database;
    if (db != null) {
      await db.close();
    }
  }
}
