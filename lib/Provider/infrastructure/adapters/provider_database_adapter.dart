import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../../domain/entities/provider_entity.dart';
import '../../application/ports/provider_port.dart';

class ProviderSQLiteAdapter implements ProviderPort {
  Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final path = join(await getDatabasesPath(), 'provider_database.db');
    return openDatabase(
      path,
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE providers(id TEXT PRIMARY KEY, name TEXT, contactInfo TEXT)',
        );
      },
      version: 1,
    );
  }

  @override
  Future<void> createProvider(Provider provider) async {
    final db = await database;
    await db.insert('providers', {
      'id': provider.id,
      'name': provider.name,
      'contactInfo': provider.contactInfo,
    });
  }

  @override
  Future<void> updateProvider(Provider provider) async {
    final db = await database;
    await db.update(
      'providers',
      {
        'id': provider.id,
        'name': provider.name,
        'contactInfo': provider.contactInfo,
      },
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
    final List<Map<String, dynamic>> maps = await db.query('providers');
    return List.generate(maps.length, (i) {
      return Provider(
        id: maps[i]['id'],
        name: maps[i]['name'],
        contactInfo: maps[i]['contactInfo'],
        contactNumber: maps[i]['contactNumber'],
      );
    });
  }
}
