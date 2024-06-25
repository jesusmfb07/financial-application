// infrastructure/adapters/category_sqlite_adapter.dart
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../../domain/entities/category_entity.dart';
import '../../application/ports/category_port.dart';
import 'mappers.dart';

class CategorySQLiteAdapter implements CategoryPort {
  static final CategorySQLiteAdapter _instance = CategorySQLiteAdapter._internal();
  Database? _database;

  factory CategorySQLiteAdapter() {
    return _instance;
  }

  CategorySQLiteAdapter._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final databasePath = await getDatabasesPath();
    final path = join(databasePath, 'categories.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE categories (
            id TEXT PRIMARY KEY,
            name TEXT
          )
        ''');
      },
    );
  }

  @override
  Future<void> createCategory(Category category) async {
    final db = await database;
    await db.insert('categories', CategoryMapper.toMap(category));
  }

  @override
  Future<void> updateCategory(Category category) async {
    final db = await database;
    await db.update(
      'categories',
      CategoryMapper.toMap(category),
      where: 'id = ?',
      whereArgs: [category.id],
    );
  }

  @override
  Future<void> deleteCategory(String id) async {
    final db = await database;
    await db.delete(
      'categories',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  @override
  Future<List<Category>> getCategories() async {
    final db = await database;
    final result = await db.query('categories');
    return result.map((map) => CategoryMapper.fromMap(map)).toList();
  }
}
