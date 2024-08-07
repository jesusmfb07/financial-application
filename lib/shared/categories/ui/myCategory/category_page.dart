// import 'package:flutter/material.dart';
// import '../../application/use_cases/create_category_use_case.dart';
// import '../../application/use_cases/delete_category_use_case.dart';
// import '../../application/use_cases/get_category_use_case.dart';
// import '../../application/use_cases/update_category_use_case.dart';
// import '../../domain/aggregates/category_aggregate.dart';
// import '../../domain/entities/category_entity.dart';
//
// class CategoryPage extends StatefulWidget {
//   final CreateCategoryUseCase createCategoryUseCase;
//   final UpdateCategoryUseCase updateCategoryUseCase;
//   final DeleteCategoryUseCase deleteCategoryUseCase;
//   final GetCategoriesUseCase getCategoriesUseCase;
//
//   CategoryPage({
//     required this.createCategoryUseCase,
//     required this.updateCategoryUseCase,
//     required this.deleteCategoryUseCase,
//     required this.getCategoriesUseCase,
//   });
//
//   @override
//   _CategoryPageState createState() => _CategoryPageState();
// }
//
// class _CategoryPageState extends State<CategoryPage> {
//   final TextEditingController _categoryController = TextEditingController();
//   List<CategoryAggregate> _categories = [];
//
//   @override
//   void initState() {
//     super.initState();
//     _loadCategories();
//   }
//
//   Future<void> _loadCategories() async {
//     final categories = await widget.getCategoriesUseCase.execute();
//     setState(() {
//       _categories = categories;
//     });
//   }
//
//   Future<void> _addOrUpdateCategory({String? id}) async {
//     if (_categoryController.text.isEmpty) return;
//
//     final category = Category(
//       id: id ?? DateTime.now().toString(),
//       name: _categoryController.text,
//     );
//
//     if (id == null) {
//       await widget.createCategoryUseCase.execute(category);
//     } else {
//       await widget.updateCategoryUseCase.execute(category);
//     }
//
//     _categoryController.clear();
//     _loadCategories();
//   }
//
//   Future<void> _deleteCategoryById(String id) async {
//     final category = _categories.firstWhere((c) => c.id == id);
//     await widget.deleteCategoryUseCase.execute(category);
//     _loadCategories();
//   }
//
//   void _showAddCategoryDialog({String? id, String? initialName}) {
//     if (initialName != null) {
//       _categoryController.text = initialName;
//     } else {
//       _categoryController.clear();
//     }
//
//     showDialog(
//       context: context,
//       builder: (context) => AlertDialog(
//         title: Text(id == null ? 'Añadir Categoría' : 'Editar Categoría'),
//         content: TextField(
//           controller: _categoryController,
//           decoration: InputDecoration(labelText: 'Nombre de la categoría'),
//         ),
//         actions: [
//           TextButton(
//             onPressed: () => Navigator.pop(context),
//             child: Text('Cancelar'),
//           ),
//           TextButton(
//             onPressed: () {
//               _addOrUpdateCategory(id: id);
//               Navigator.pop(context);
//             },
//             child: Text('Guardar'),
//           ),
//         ],
//       ),
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Categorías'),
//       ),
//       body: ListView.builder(
//         itemCount: _categories.length,
//         itemBuilder: (context, index) {
//           final category = _categories[index];
//           return ListTile(
//             title: Text(category.name),
//             trailing: Row(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 IconButton(
//                   icon: Icon(Icons.edit),
//                   onPressed: () => _showAddCategoryDialog(
//                     id: category.id,
//                     initialName: category.name,
//                   ),
//                 ),
//                 IconButton(
//                   icon: Icon(Icons.delete),
//                   onPressed: () => _deleteCategoryById(category.id),
//                 ),
//               ],
//             ),
//             onTap: () {
//               _categoryController.text = category.name;
//               _showAddCategoryDialog(
//                 id: category.id,
//                 initialName: category.name,
//               );
//             },
//           );
//         },
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () => _showAddCategoryDialog(),
//         child: Icon(Icons.add),
//       ),
//     );
//   }
// }

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import '../../application/ports/puerto_pesquero.dart';
import '../../application/use_cases/create_category_use_case.dart';
import '../../application/use_cases/delete_category_use_case.dart';
import '../../application/use_cases/get_category_use_case.dart';
import '../../application/use_cases/update_category_use_case.dart';
import '../../domain/aggregates/category_aggregate.dart';
import '../../domain/entities/category_entity.dart';
import '../../infrastructure/adapters/adapter_puerto_pesquero.dart';


class CategoryPage extends StatefulWidget {
  final CreateCategoryUseCase createCategoryUseCase;
  final UpdateCategoryUseCase updateCategoryUseCase;
  final DeleteCategoryUseCase deleteCategoryUseCase;
  final GetCategoriesUseCase getCategoriesUseCase;
  final BackupPort backupService = BackupService();

  CategoryPage({
    required this.createCategoryUseCase,
    required this.updateCategoryUseCase,
    required this.deleteCategoryUseCase,
    required this.getCategoriesUseCase,
  });

  @override
  _CategoryPageState createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  final TextEditingController _categoryController = TextEditingController();
  List<CategoryAggregate> _categories = [];

  @override
  void initState() {
    super.initState();
    _loadCategories();
  }

  Future<void> _exportBackup(BuildContext context) async {
    await widget.backupService.exportBackup();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Copia de seguridad exportada con éxito')),
    );
  }
  // Future<void> _exportBackup() async {
  //   try {
  //     // Obtener el directorio de documentos de la aplicación
  //     final directory = await getApplicationDocumentsDirectory();
  //
  //     // Definir la ruta del archivo de copia de seguridad
  //     final filePath = join(directory.path, 'backup.json');
  //
  //     // Obtener las categorías actuales
  //     final categories = await widget.getCategoriesUseCase.execute();
  //
  //     // Convertir las categorías a JSON
  //     final backupData = categories.map((category) => CategoryMapper.toMap(category)).toList();
  //
  //     // Escribir los datos de copia de seguridad en el archivo
  //     final file = File(filePath);
  //     await file.writeAsString(jsonEncode(backupData));
  //
  //     // Mostrar mensaje de éxito
  //     ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Copia de seguridad exportada con éxito')));
  //   } catch (e) {
  //     // Manejar cualquier error que ocurra durante el proceso de exportación
  //     ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error al exportar la copia de seguridad: $e')));
  //   }
  // }

  Future<void> _importBackup(BuildContext context) async {
    final directory = await getApplicationDocumentsDirectory();
    final filePath = join(directory.path, 'backup.json');
    final file = File(filePath);
    if (await file.exists()) {
      final backupData = await file.readAsString();
      await widget.backupService.importBackup(backupData);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Copia de seguridad importada con éxito')),
      );
      _loadCategories();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('No se encontró el archivo de copia de seguridad')),
      );
    }
  }

  Future<void> _loadCategories() async {
    final categories = await widget.getCategoriesUseCase.execute();
    setState(() {
      _categories = categories;
    });
  }

  Future<void> _addOrUpdateCategory({String? id}) async {
    if (_categoryController.text.isEmpty) return;

    final category = Category(
      id: id ?? DateTime.now().toString(),
      name: _categoryController.text,
    );

    if (id == null) {
      await widget.createCategoryUseCase.execute(category);
    } else {
      await widget.updateCategoryUseCase.execute(category);
    }

    _categoryController.clear();
    _loadCategories();
  }

  Future<void> _deleteCategoryById(String id) async {
    final category = _categories.firstWhere((c) => c.id == id);
    await widget.deleteCategoryUseCase.execute(category);
    _loadCategories();
  }

  void _showAddCategoryDialog({String? id, String? initialName}) {
    if (initialName != null) {
      _categoryController.text = initialName;
    } else {
      _categoryController.clear();
    }

    showDialog(
      context: this.context,
      builder: (BuildContext context) => AlertDialog(
        title: Text(id == null ? 'Añadir Categoría' : 'Editar Categoría'),
        content: TextField(
          controller: _categoryController,
          decoration: InputDecoration(labelText: 'Nombre de la categoría'),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancelar'),
          ),
          TextButton(
            onPressed: () {
              _addOrUpdateCategory(id: id);
              Navigator.pop(context);
            },
            child: Text('Guardar'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Categorías'),
        actions: [
          IconButton(
            icon: Icon(Icons.backup),
            onPressed: () => _exportBackup(context),
          ),
          IconButton(
            icon: Icon(Icons.restore),
            onPressed: () => _importBackup(context),
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: _categories.length,
        itemBuilder: (BuildContext context, int index) {
          final category = _categories[index];
          return ListTile(
            title: Text(category.name),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () => _showAddCategoryDialog(
                    id: category.id,
                    initialName: category.name,
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () => _deleteCategoryById(category.id),
                ),
              ],
            ),
            onTap: () {
              _categoryController.text = category.name;
              _showAddCategoryDialog(
                id: category.id,
                initialName: category.name,
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddCategoryDialog(),
        child: Icon(Icons.add),
      ),
    );
  }
}





