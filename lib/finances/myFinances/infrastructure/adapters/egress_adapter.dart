import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../../application/ports/egress_port.dart';
import '../../domain/entities/egress_entry_entity.dart';
import '../mappers/egress_mappers.dart';

class EgressEntrySQLiteAdapter implements EgressEntryPort {
  static final EgressEntrySQLiteAdapter _instance = EgressEntrySQLiteAdapter._internal();
  Database? _database;

  factory EgressEntrySQLiteAdapter() {
    return _instance;
  }

  EgressEntrySQLiteAdapter._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final databasePath = await getDatabasesPath();
    final path = join(databasePath, 'finance.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: (db,  version) async {
        await db.execute('''
        CREATE TABLE IF NOT EXISTS egress_entries (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          description TEXT,
          amount REAL,
          date TEXT,
          category TEXT,
          provider TEXT
        )
      ''');
      },
      onOpen: (db) async {
        // Verificar si la tabla egress_entries existe
        final result = await db.rawQuery(
            "SELECT name FROM sqlite_master WHERE type='table' AND name='egress_entries'");
        if (result.isEmpty) {
          // La tabla no existe, crearla
          await db.execute('''
          CREATE TABLE IF NOT EXISTS egress_entries (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            description TEXT,
            amount REAL,
            date TEXT,
            category TEXT,
            provider TEXT
          )
        ''');
          print('Table created successfully.');
        }
      },
    );
  }

  Future<void> createEntry(EgressEntry entry) async {
    final db = await database;
    await db.insert('egress_entries', EgressEntryMapper.toMap(entry));
  }

  Future<List<EgressEntry>> getEntries() async {
    final db = await database;
    final maps = await db.query('egress_entries');
    return List.generate(maps.length, (i) {
      return EgressEntryMapper.fromMap(maps[i]);
    });
  }

  Future<void> updateEntry(EgressEntry entry) async {
    final db = await database;
    await db.update(
      'egress_entries',
      EgressEntryMapper.toMap(entry),
      where: 'id = ?',
      whereArgs: [entry.id],
    );
  }

  Future<void> deleteEntry(int id) async {
    final db = await database;
    await db.delete(
      'egress_entries',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
