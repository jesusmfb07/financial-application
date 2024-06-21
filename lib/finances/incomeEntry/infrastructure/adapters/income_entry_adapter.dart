// import 'package:sqflite/sqflite.dart';
// import 'package:path/path.dart';
//
// import '../../application/ports/income_entry_port.dart';
// import '../../domain/entities/income_entry_entity.dart';
//
//
// class IncomeEntrySQLiteAdapter implements IncomeEntryPort {
//   static final IncomeEntrySQLiteAdapter _instance = IncomeEntrySQLiteAdapter._internal();
//   Database? _database;
//
//   factory IncomeEntrySQLiteAdapter() {
//     return _instance;
//   }
//
//   IncomeEntrySQLiteAdapter._internal();
//
//   Future<Database> get database async {
//     if (_database != null) return _database!;
//     _database = await _initDatabase();
//     return _database!;
//   }
//
//   Future<Database> _initDatabase() async {
//     final databasePath = await getDatabasesPath();
//     final path = join(databasePath, 'income_entries.db');
//
//     return await openDatabase(
//       path,
//       version: 1,
//       onCreate: (db, version) async {
//         await db.execute('''
//           CREATE TABLE income_entries (
//             id TEXT PRIMARY KEY,
//             description TEXT,
//             amount REAL,
//             date TEXT,
//             categoryId TEXT
//           )
//         ''');
//       },
//     );
//   }
//
//   @override
//   Future<void> createEntry(IncomeEntry entry) async {
//     final db = await database;
//     await db.insert('income_entries', entry.toMap());
//   }
//
//   @override
//   Future<void> updateEntry(IncomeEntry entry) async {
//     final db = await database;
//     await db.update(
//       'income_entries',
//       entry.toMap(),
//       where: 'id = ?',
//       whereArgs: [entry.id],
//     );
//   }
//
//   @override
//   Future<void> deleteEntry(String id) async {
//     final db = await database;
//     await db.delete(
//       'income_entries',
//       where: 'id = ?',
//       whereArgs: [id],
//     );
//   }
//
//   @override
//   Future<List<IncomeEntry>> getEntries() async {
//     final db = await database;
//     final result = await db.query('income_entries');
//     return result.map((map) => IncomeEntry.fromMap(map)).toList();
//   }
// }
