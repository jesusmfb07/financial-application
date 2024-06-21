import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../../application/ports/egress_entry_port.dart';
import '../../domain/entities/egress_entry_entity.dart';

class EgressEntrySQLiteAdapter implements EgressEntryPort {
  static final EgressEntrySQLiteAdapter _instance = EgressEntrySQLiteAdapter._internal();
  late Database _database;

  factory EgressEntrySQLiteAdapter() {
    return _instance;
  }

  EgressEntrySQLiteAdapter._internal();

  Future<Database> get database async {
    if (_database.isOpen) return _database;
    _database = await _initDatabase();
    return _database;
  }

  Future<Database> _initDatabase() async {
    final databasePath = await getDatabasesPath();
    final path = join(databasePath, 'egress_entries.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE egress_entries (
            id TEXT PRIMARY KEY,
            description TEXT,
            amount REAL,
            date TEXT,
            categoryId TEXT,
            providerId TEXT
          )
        ''');
      },
    );
  }

  @override
  Future<void> createEntry(EgressEntry entry) async {
    final db = await database;
    await db.insert('egress_entries', entry.toMap());
  }

  @override
  Future<void> updateEntry(EgressEntry entry) async {
    final db = await database;
    await db.update(
      'egress_entries',
      entry.toMap(),
      where: 'id = ?',
      whereArgs: [entry.id],
    );
  }

  @override
  Future<void> deleteEntry(String id) async {
    final db = await database;
    await db.delete(
      'egress_entries',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  @override
  Future<List<EgressEntry>> getEntries() async {
    final db = await database;
    final result = await db.query('egress_entries');
    return result.map((map) => EgressEntry.fromMap(map)).toList();
  }
}