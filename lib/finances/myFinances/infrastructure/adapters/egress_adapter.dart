import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
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

    await deleteDatabase(path);

    return await openDatabase(
      path,
      version: 3, // Asegúrate de que el número de versión sea correcto
      onCreate: (db, version) async {
        await _createEgressEntriesTable(db);
      },
      onUpgrade: (db, oldVersion, newVersion) async {
        if (oldVersion < 3) {
          await _createEgressEntriesTable(db);
        }
      },
    );
  }

  Future<void> _createEgressEntriesTable(Database db) async {
    print('Creating egress_entries table');
    await db.execute('''
    CREATE TABLE IF NOT EXISTS egress_entries (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      description TEXT,
      amount REAL,
      date TEXT,
      category TEXT,
      provider TEXT,
      attachmentPath TEXT // Asegúrate de incluir esta línea
    )
  ''');
    print('egress_entries table created or already exists');
  }

  Future<void> createEntry(EgressEntry entry) async {
    final db = await database;
    await db.insert('egress_entries', EgressEntryMapper.toMap(entry));
    print('Entry created: ${entry.description}');
  }

  Future<List<EgressEntry>> getEntries() async {
    final db = await database;
    final maps = await db.query('egress_entries');
    print('Retrieved ${maps.length} entries');
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
    print('Entry updated: ${entry.id}');
  }
}
