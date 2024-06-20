// // infrastructure/adapters/register_sqlite_adapter.dart
// import 'package:sqflite/sqflite.dart';
// import 'package:path/path.dart';
// import '../../domain/entities/register_entity.dart';
// import '../../application/ports/register_port.dart';
//
// class RegisterSQLiteAdapter implements RegisterPort {
//   static final RegisterSQLiteAdapter _instance = RegisterSQLiteAdapter._internal();
//   Database? _database;
//
//   factory RegisterSQLiteAdapter() {
//     return _instance;
//   }
//
//   RegisterSQLiteAdapter._internal();
//
//   Future<Database> get database async {
//     if (_database != null) return _database!;
//     _database = await _initDatabase();
//     return _database!;
//   }
//
//   Future<Database> _initDatabase() async {
//     final databasePath = await getDatabasesPath();
//     final path = join(databasePath, 'registers.db');
//
//     return await openDatabase(
//       path,
//       version: 1,
//       onCreate: (db, version) async {
//         await db.execute('''
//           CREATE TABLE registers (
//             id TEXT PRIMARY KEY,
//             type TEXT,
//             amount REAL,
//             date TEXT,
//             description TEXT
//           )
//         ''');
//       },
//     );
//   }
//
//   @override
//   Future<void> createRegister(Register register) async {
//     final db = await database;
//     await db.insert('registers', register.toMap());
//   }
//
//   @override
//   Future<void> updateRegister(Register register) async {
//     final db = await database;
//     await db.update(
//       'registers',
//       register.toMap(),
//       where: 'id = ?',
//       whereArgs: [register.id],
//     );
//   }
//
//   @override
//   Future<void> deleteRegister(String id) async {
//     final db = await database;
//     await db.delete(
//       'registers',
//       where: 'id = ?',
//       whereArgs: [id],
//     );
//   }
//
//   @override
//   Future<List<Register>> getRegisters() async {
//     final db = await database;
//     final result = await db.query('registers');
//     return result.map((map) => Register.fromMap(map)).toList();
//   }
// }


// infrastructure/adapters/register_sqlite_adapter.dart
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../../domain/entities/register_entity.dart';

class RegisterSQLiteAdapter {
  static final RegisterSQLiteAdapter _instance = RegisterSQLiteAdapter._internal();
  Database? _database;

  factory RegisterSQLiteAdapter() {
    return _instance;
  }

  RegisterSQLiteAdapter._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final databasePath = await getDatabasesPath();
    final path = join(databasePath, 'registers.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE registers (
            id TEXT PRIMARY KEY,
            type TEXT,
            amount REAL,
            date TEXT
          )
        ''');
      },
    );
  }

  Future<void> createRegister(Register register) async {
    final db = await database;
    await db.insert('registers', register.toMap());
  }

  Future<void> updateRegister(Register register) async {
    final db = await database;
    await db.update(
      'registers',
      register.toMap(),
      where: 'id = ?',
      whereArgs: [register.id],
    );
  }

  Future<void> deleteRegister(String id) async {
    final db = await database;
    await db.delete(
      'registers',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<List<Register>> getRegisters() async {
    final db = await database;
    final result = await db.query('registers');
    return result.map((map) => Register.fromMap(map)).toList();
  }
}
