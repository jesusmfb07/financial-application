import 'dart:convert';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import '../../application/ports/puerto_pesquero.dart';
import '../../domain/entities/category_entity.dart';
import '../adapters/category_sqlite_adapter.dart';

class BackupService implements BackupPort {
  final CategorySQLiteAdapter _categoryAdapter = CategorySQLiteAdapter();

  @override
  Future<void> exportBackup() async {
    final categories = await _categoryAdapter.getCategories();
    final categoriesMap = categories.map((category) => {
      'id': category.id,
      'name': category.name,
    }).toList();

    final backupData = jsonEncode({'categories': categoriesMap});

    final directory = await getApplicationDocumentsDirectory();
    final filePath = join(directory.path, 'backup.json');
    final file = File(filePath);
    await file.writeAsString(backupData);

    // Subir el archivo a un servicio en la nube si es necesario
  }

  @override
  Future<void> importBackup(String backupData) async {
    final Map<String, dynamic> json = jsonDecode(backupData);
    final List<dynamic> categoriesJson = json['categories'];

    final Database db = await _categoryAdapter.database;

    // Eliminar todas las categorías actuales
    await db.delete('categories');

    // Insertar las categorías desde el backup
    for (var categoryJson in categoriesJson) {
      final category = Category(
        id: categoryJson['id'],
        name: categoryJson['name'],
      );
      await _categoryAdapter.createCategory(category);
    }
  }
}
