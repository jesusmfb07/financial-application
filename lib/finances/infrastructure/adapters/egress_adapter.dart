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
      version: 6, // Incrementa la versión
      onCreate: (db, version) async {
        print('Creating database version $version');
        await _createTable(db);
      },
      onUpgrade: (db, oldVersion, newVersion) async {
        print('Upgrading database from $oldVersion to $newVersion');
        if (oldVersion < 5) {
          await _createTable(db);
        }
      },
    );
  }

  Future<void> _createTable(Database db) async {
    try {
      await db.execute('''
      CREATE TABLE IF NOT EXISTS egress_entries (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        description TEXT,
        amount REAL,
        date TEXT,
        category TEXT,
        provider TEXT,
        attachmentPath TEXT,
        currencySymbol TEXT,
      )
    ''');
      print('Table egress_entries created successfully');
    } catch (e) {
      print('Error creating table: $e');
    }
  }

  Future<void> createEntry(EgressEntry entry) async {
    final db = await database;
    try {
      await db.insert('egress_entries', EgressEntryMapper.toMap(entry));
      print('Entry inserted successfully');
    } catch (e) {
      print('Error inserting entry: $e');
      // Verificar si la tabla existe
      var tableExists = await db.rawQuery("SELECT name FROM sqlite_master WHERE type='table' AND name='egress_entries'");
      if (tableExists.isEmpty) {
        print('Table does not exist, attempting to create');
        await _createTable(db);
      } else {
        print('Unexpected error: $e');
        throw e;
      }
    }
  }

  Future<List<EgressEntry>> getEntries() async {
    final db = await database;
    try {
      final maps = await db.query('egress_entries');
      return List.generate(maps.length, (i) {
        return EgressEntryMapper.fromMap(maps[i]);
      });
    } catch (e) {
      print('Error retrieving entries: $e');
      // Verificar si la tabla existe
      var tableExists = await db.rawQuery("SELECT name FROM sqlite_master WHERE type='table' AND name='egress_entries'");
      if (tableExists.isEmpty) {
        print('Table does not exist, attempting to create');
        await _createTable(db);
        return [];
      } else {
        print('Unexpected error: $e');
        throw e;
      }
    }
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

  Future<void> deleteDatabase() async {
    final databasePath = await getDatabasesPath();
    final path = join(databasePath, 'finance.db');
    await databaseFactory.deleteDatabase(path);
    print('Database deleted');
    _database = null; // Reset database instance
  }
}
