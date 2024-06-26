// import 'package:sqflite/sqflite.dart';
// import 'package:path/path.dart';
// import '../../domain/entities/contact_entity.dart';
// import '../../application/ports/contact/contact_port.dart';
//
// class DatabaseAdapter implements ContactPort {
//   static final DatabaseAdapter _instance = DatabaseAdapter._internal();
//   factory DatabaseAdapter() => _instance;
//
//   static Database? _database;
//
//   DatabaseAdapter._internal();
//
//   Future<Database> get database async {
//     if (_database != null) return _database!;
//     _database = await _initDatabase();
//     return _database!;
//   }
//
//   Future<Database> _initDatabase() async {
//     String path = join(await getDatabasesPath(), 'contacts.db');
//     return await openDatabase(
//       path,
//       version: 1,
//       onCreate: (db, version) {
//         return db.execute(
//           'CREATE TABLE contacts(id INTEGER PRIMARY KEY, name TEXT, lastName TEXT)',
//         );
//       },
//     );
//   }
//
//   @override
//   Future<List<Contact>> getContacts() async {
//     final db = await database;
//     final List<Map<String, dynamic>> maps = await db.query('contacts');
//     return List.generate(maps.length, (i) {
//       return Contact(
//         maps[i]['id'],
//         maps[i]['name'],
//         maps[i]['lastName'],
//       );
//     });
//   }
//
//   @override
//   Future<void> createContact(Contact contact) async {
//     final db = await database;
//     await db.insert('contacts', {
//       'name': contact.name,
//       'lastName': contact.lastName,
//     });
//   }
// }
//
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../../application/ports/contact/contact_port.dart';
import '../../domain/entities/contact_entity.dart';

class DatabaseAdapter implements ContactPort {
  static final DatabaseAdapter _instance = DatabaseAdapter._internal();

  factory DatabaseAdapter() => _instance;

  static Database? _database;

  DatabaseAdapter._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'contacts.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE contacts(id INTEGER PRIMARY KEY, name TEXT, lastName TEXT)',
        );
      },
    );
  }

  @override
  Future<List<Contact>> getContacts() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('contacts');
    return List.generate(maps.length, (i) {
      return Contact(
        maps[i]['id'],
        maps[i]['name'],
        maps[i]['lastName'],
      );
    });
  }

  @override
  Future<void> createContact(Contact contact) async {
    final db = await database;
    await db.insert('contacts', {
      'id': contact.id,
      'name': contact.name,
      'lastName': contact.lastName,
    });
  }
  @override
  Future<void> deleteContact(Contact contact) async {
    final db = await database;
    await db.delete(
      'contacts',
      where: 'id = ?',
      whereArgs: [contact.id],
    );
  }
  @override
  Future<void> updateContact(Contact contact) async {
    final db = await database;
    await db.update(
      'contacts',
      {
        'name': contact.name,
        'lastName': contact.lastName,
      },
      where: 'id = ?',
      whereArgs: [contact.id],
    );
  }

}