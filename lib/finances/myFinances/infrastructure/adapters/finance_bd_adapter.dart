import '../../application/ports/finance_entry_port.dart';
import '../../domain/entities/finance_entry.entity.dart';

class FinanceEntryAdapter implements FinanceEntryPort {
  final _entries = <FinanceEntry>[];

  @override
  Future<void> createEntry(FinanceEntry entry) async {
    _entries.add(entry);
  }

  @override
  Stream<List<FinanceEntry>> getEntries() async* {
    yield _entries;
  }
}


//
// class FinanceEntryAdapter implements FinanceEntryPort {
//   static final CategorySQLiteAdapter _instance = CategorySQLiteAdapter._internal();
//   Database? _database;
//
//   factory CategorySQLiteAdapter() {
//     return _instance;
//   }
//
//   CategorySQLiteAdapter._internal();
//
//   Future<Database> get database async {
//     if (_database != null) return _database!;
//     _database = await _initDatabase();
//     return _database!;
//   }
//
//   Future<Database> _initDatabase() async {
//     final databasePath = await getDatabasesPath();
//     final path = join(databasePath, 'categories.db');
//
//     return await openDatabase(
//       path,
//       version: 1,
//       onCreate: (db, version) async {
//         await db.execute('''
//           CREATE TABLE categories (
//             id TEXT PRIMARY KEY,
//             name TEXT
//           )
//         ''');
//       },
//     );
//   }
//
//   @override
//   Future<void> createCategory(Category category) async {
//     final db = await database;
//     await db.insert('categories', category.toMap());
//   }
//
//   @override
//   Future<void> updateCategory(Category category) async {
//     final db = await database;
//     await db.update(
//       'categories',
//       category.toMap(),
//       where: 'id = ?',
//       whereArgs: [category.id],
//     );
//   }
//
//   @override
//   Future<void> deleteCategory(String id) async {
//     final db = await database;
//     await db.delete(
//       'categories',
//       where: 'id = ?',
//       whereArgs: [id],
//     );
//   }
//
//   @override
//   Future<List<Category>> getCategories() async {
//     final db = await database;
//     final result = await db.query('categories');
//     return result.map((map) => Category.fromMap(map)).toList();
//   }
// }