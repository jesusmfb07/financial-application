import 'dart:io';
import 'package:flutter/material.dart';
import 'package:open_file/open_file.dart';
import 'package:uuid/uuid.dart';
import '../../../application/use_cases/income_use_case.dart';
import '../../../domain/aggregates/income_aggregate.dart';
import '../../../domain/entities/income_entry_entity.dart';
import '../egress/image_preview_page.dart';
import '../egress/pdf_viewer_page.dart';
import '../file_storage_service.dart';
import 'income_entry_form.dart';
import 'income_entry_list.dart';
import '../../../../shared/categories/application/use_cases/category_use_case.dart';
import '../../../../shared/categories/domain/aggregates/category_aggregate.dart';
import '../../../../shared/categories/domain/entities/category_entity.dart';

class IncomePage extends StatefulWidget {
  final CreateIncomeEntryUseCase createEntryUseCase;
  final UpdateIncomeEntryUseCase updateEntryUseCase;
  final GetIncomeEntriesUseCase getEntriesUseCase;
  final GetCategoriesUseCase getCategoriesUseCase;
  final CreateCategoryUseCase createCategoryUseCase;
  final IncomeEntryAggregate aggregate;
  final CategoryAggregate categoryAggregate;
  final String? attachmentPath;

  IncomePage({
    required this.createEntryUseCase,
    required this.updateEntryUseCase,
    required this.getEntriesUseCase,
    required this.getCategoriesUseCase,
    required this.createCategoryUseCase,
    required this.aggregate,
    required this.categoryAggregate,
    this.attachmentPath,
  });

  @override
  _IncomePageState createState() => _IncomePageState();
}

class _IncomePageState extends State<IncomePage> {
  final FileStorageService _fileStorageService = FileStorageService();

  @override
  void initState() {
    super.initState();
    _loadEntries();
    _loadCategories();
  }

  Future<void> _loadEntries() async {
    final entries = await widget.getEntriesUseCase.execute(widget.aggregate);
    setState(() {
      widget.aggregate.entries.clear();
      widget.aggregate.entries.addAll(entries);
    });
  }

  Future<void> _loadCategories() async {
    final categories = await widget.getCategoriesUseCase.execute(widget.categoryAggregate);
    setState(() {
      widget.categoryAggregate.categories.clear();
      widget.categoryAggregate.categories.addAll(categories);
    });
  }

  Future<void> _saveAttachment(File file) async {
    final savedFile = await _fileStorageService.saveFile(file);
    // Actualiza tu lógica para usar la ruta del archivo guardado.
  }

  void _viewAttachment(String path) {
    if (path.toLowerCase().endsWith('.jpg') ||
        path.toLowerCase().endsWith('.jpeg') ||
        path.toLowerCase().endsWith('.png')) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ImagePreviewPage(imagePath: path),
        ),
      );
    } else if (path.toLowerCase().endsWith('.pdf')) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => PDFViewerPage(pdfPath: path),
        ),
      );
    } else {
      OpenFile.open(path);
    }
  }

  void _createCategory(String name) async {
    final newCategory = Category(
      id: Uuid().v4(), // Genera un ID único para la nueva categoría
      name: name,
    );
    await widget.createCategoryUseCase.execute(widget.categoryAggregate, newCategory);
    setState(() {
      widget.categoryAggregate.categories.add(newCategory);
    });
  }

  void _showCreateCategoryDialog() {
    TextEditingController _newCategoryController = TextEditingController();
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Crear Categoría'),
          content: TextField(
            controller: _newCategoryController,
            decoration: InputDecoration(labelText: 'Nombre de la categoría'),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Cancelar'),
            ),
            TextButton(
              onPressed: () {
                _createCategory(_newCategoryController.text);
                Navigator.pop(context);
              },
              child: Text('Crear'),
            ),
          ],
        );
      },
    );
  }

  void _showEntryDialog({IncomeEntry? entry}) {
    showDialog(
      context: context,
      builder: (context) {
        return IncomeEntryForm(
          createEntryUseCase: widget.createEntryUseCase,
          updateEntryUseCase: widget.updateEntryUseCase,
          aggregate: widget.aggregate,
          categoryAggregate: widget.categoryAggregate,
          createCategoryUseCase: widget.createCategoryUseCase, // Añadir esto
          entry: entry,
          onSave: _loadEntries,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IncomeEntryList(
        getEntriesUseCase: widget.getEntriesUseCase,
        aggregate: widget.aggregate,
        onEdit: (entry) => _showEntryDialog(entry: entry),
        onViewAttachment: _viewAttachment,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showEntryDialog(),
        child: Icon(Icons.add),
      ),
    );
  }
}
