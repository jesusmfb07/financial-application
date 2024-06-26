import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../../application/ports/income_port.dart';
import '../../domain/entities/income_entry_entity.dart';
import '../mappers/income_mappers.dart';

class IncomeEntrySQLiteAdapter implements IncomeEntryPort {
  static final IncomeEntrySQLiteAdapter _instance = IncomeEntrySQLiteAdapter._internal();
  Database? _database;

  factory IncomeEntrySQLiteAdapter() {
    return _instance;
  }

  IncomeEntrySQLiteAdapter._internal();

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
      version: 5, // Increment the version to force the upgrade
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE income_entries (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            description TEXT,
            amount REAL,
            date TEXT,
            category TEXT,
            attachmentPath TEXT,
            currencySymbol TEXT
          )
        ''');
      },
      onUpgrade: (db, oldVersion, newVersion) async {
        if (oldVersion < 5) {
          await db.execute('''
            CREATE TABLE IF NOT EXISTS income_entries (
              id INTEGER PRIMARY KEY AUTOINCREMENT,
              description TEXT,
              amount REAL,
              date TEXT,
              category TEXT,
              attachmentPath TEXT,
              currencySymbol TEXT
            )
          ''');
        }
      },
    );
  }

  Future<void> createEntry(IncomeEntry entry) async {
    final db = await database;
    await db.insert('income_entries', IncomeEntryMapper.toMap(entry));
  }

  Future<List<IncomeEntry>> getEntries() async {
    final db = await database;
    final maps = await db.query('income_entries');
    return List.generate(maps.length, (i) {
      return IncomeEntryMapper.fromMap(maps[i]);
    });
  }

  Future<void> updateEntry(IncomeEntry entry) async {
    final db = await database;
    await db.update(
      'income_entries',
      IncomeEntryMapper.toMap(entry),
      where: 'id = ?',
      whereArgs: [entry.id],
    );
  }
  Future<void> deleteDatabase() async {
    final databasePath = await getDatabasesPath();
    final path = join(databasePath, 'finance.db');
    await databaseFactory.deleteDatabase(path);
    _database = null; // Reset database instance
  }
}
