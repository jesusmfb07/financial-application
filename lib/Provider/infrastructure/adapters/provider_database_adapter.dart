import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../../domain/aggregates/provider_aggregate.dart';
import '../../domain/entities/provider_entity.dart';
import '../../application/ports/provider_port.dart';

class ProviderSQLiteAdapter implements ProviderPort {
  static final ProviderSQLiteAdapter _instance = ProviderSQLiteAdapter._internal();
  Database? _database;

  factory ProviderSQLiteAdapter() {
    return _instance;
  }

  ProviderSQLiteAdapter._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final databasePath = await getDatabasesPath();
    final path = join(databasePath, 'provider_database.db');

    return openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE providers('
              id TEXT PRIMARY KEY,'
               name TEXT,'
               phoneNumber TEXT,'
               ruc TEXT'
              ),
        ''');
      },
    );
  }

  @override
  Future<void> createProvider(ProviderAggregate aggregate,Provider provider) async {
    final db = await database;
    await db.insert('providers', provider.toMap());
  }

  @override
  Future<void> updateProvider(ProviderAggregate aggregate,Provider provider) async {
    final db = await database;
    await db.update(
      'providers',
      provider.toMap(),
      where: 'id = ?',
      whereArgs: [provider.id],
    );
  }

  @override
  Future<void> deleteProvider(String id) async {
    final db = await database;
    await db.delete(
      'providers',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  @override
  Future<List<Provider>> getProviders() async {
    final db = await database;
    final result = await db.query('providers');
    return result.map((map) => Provider.fromMap(map)).toList();
  }
}

