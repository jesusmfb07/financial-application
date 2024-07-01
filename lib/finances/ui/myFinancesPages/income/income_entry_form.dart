import 'dart:io';
import 'dart:ui';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:uuid/uuid.dart';

import '../../../../shared/categories/application/use_cases/category_use_case.dart';
import '../../../../shared/categories/domain/aggregates/category_aggregate.dart';
import '../../../../shared/categories/domain/entities/category_entity.dart';
import '../../../../shared/currencies/domain/entities/currency_entity.dart';
import '../../../application/use_cases/income_use_case.dart';
import '../../../domain/aggregates/income_aggregate.dart';
import '../../../domain/entities/income_entry_entity.dart';

class IncomeEntryForm extends StatefulWidget {
  final CreateIncomeEntryUseCase createEntryUseCase;
  final UpdateIncomeEntryUseCase updateEntryUseCase;
  final IncomeEntryAggregate aggregate;
  final CategoryAggregate categoryAggregate;
  final CreateCategoryUseCase createCategoryUseCase;
  final IncomeEntry? entry;
  final VoidCallback onSave;
  final String defaultCurrencySymbol;

  IncomeEntryForm({
    required this.createEntryUseCase,
    required this.updateEntryUseCase,
    required this.aggregate,
    required this.categoryAggregate,
    required this.createCategoryUseCase,
    this.entry,
    required this.onSave,
    required this.defaultCurrencySymbol,
  });

  @override
  _IncomeEntryFormState createState() => _IncomeEntryFormState();
}

class _IncomeEntryFormState extends State<IncomeEntryForm> {
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _categoryController = TextEditingController();
  String? _attachmentPath;
  String _selectedCurrencySymbol = '';
  final List<Currency> _availableCurrencies = [
    Currency(name: 'Dolar', code: '\$'),
    Currency(name: 'Euro', code: '€'),
    Currency(name: 'Sol', code: 'S/'),
  ];

  @override
  void initState() {
    super.initState();
    _selectedCurrencySymbol = widget.defaultCurrencySymbol;
    _dateController.text = DateFormat('yyyy-MM-dd').format(DateTime.now());
    if (widget.entry != null) {
      _descriptionController.text = widget.entry!.description;
      _amountController.text = widget.entry!.amount.toString();
      _categoryController.text = widget.entry!.category ?? '';
      _dateController.text =
          DateFormat('yyyy-MM-dd').format(widget.entry!.date);
      _attachmentPath = widget.entry!.attachmentPath;
    } else {
      _dateController.text = DateFormat('yyyy-MM-dd').format(DateTime.now());
    }
  }

  Future<String> _saveFileLocally(String filePath) async {
    final directory = await getApplicationDocumentsDirectory();
    final fileName = filePath.split('/').last;
    final localPath = '${directory.path}/$fileName';
    final localFile = await File(filePath).copy(localPath);
    return localFile.path;
  }

  void _addEntry() async {
    final description = _descriptionController.text;
    final amount = double.tryParse(_amountController.text) ?? 0.0;
    final category = _categoryController.text.isNotEmpty ? _categoryController.text : null;
    final date = DateFormat('yyyy-MM-dd').parse(_dateController.text);

    if (description.isNotEmpty && amount > 0) {
      final attachmentPath = _attachmentPath != null ? await _saveFileLocally(_attachmentPath!) : null;
      final entry = IncomeEntry(
        description: description,
        amount: amount,
        date: date,
        category: category,
        attachmentPath: attachmentPath,
        currencySymbol: _selectedCurrencySymbol,
      );
      await widget.createEntryUseCase.execute(widget.aggregate, entry);
      widget.onSave();
      Navigator.pop(context);
    }
  }

  void _updateEntry() async {
    final description = _descriptionController.text;
    final amount = double.tryParse(_amountController.text) ?? 0.0;
    final category = _categoryController.text.isNotEmpty ? _categoryController.text : null;
    final date = DateFormat('yyyy-MM-dd').parse(_dateController.text);

    if (description.isNotEmpty && amount > 0) {
      final attachmentPath = _attachmentPath != null ? await _saveFileLocally(_attachmentPath!) : widget.entry!.attachmentPath;
      final updatedEntry = IncomeEntry(
        id: widget.entry!.id,
        description: description,
        amount: amount,
        date: date,
        category: category,
        attachmentPath: attachmentPath,
        currencySymbol: _selectedCurrencySymbol,
      );
      await widget.updateEntryUseCase.execute(widget.aggregate, updatedEntry);
      widget.onSave();
      Navigator.pop(context);
    }
  }

  void _createCategory(String name) async {
    final existingCategory = widget.categoryAggregate.categories.firstWhere(
            (category) => category.name == name,
        orElse: () => Category(id: '', name: ''));

    if (existingCategory.id.isEmpty) {
      final newCategory = Category(
        id: Uuid().v4(),
        name: name,
      );
      await widget.createCategoryUseCase
          .execute(widget.categoryAggregate, newCategory);

      setState(() {
        widget.categoryAggregate.categories.add(newCategory);
        _categoryController.text = newCategory.name;
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('La categoría ya existe.')),
      );
    }
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

  void _showCurrencySelectionDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Seleccionar Moneda'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: _availableCurrencies.map((currency) {
              return ListTile(
                title: Text(currency.name),
                onTap: () {
                  setState(() {
                    _selectedCurrencySymbol = currency.code;
                  });
                  Navigator.pop(context);
                },
              );
            }).toList(),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Center(
          child:
          Text(widget.entry == null ? 'Nuevo Ingreso' : 'Editar Ingreso')),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _dateController,
              readOnly: true,
              decoration: InputDecoration(
                labelText: 'Fecha',
                suffixIcon: IconButton(
                  icon: Icon(Icons.calendar_today),
                  onPressed: () async {
                    DateTime? pickedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2101),
                    );
                    if (pickedDate != null) {
                      setState(() {
                        _dateController.text =
                            DateFormat('yyyy-MM-dd').format(pickedDate);
                      });
                    }
                  },
                ),
              ),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: _amountController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Monto',
                suffixIcon: GestureDetector(
                  onTap: _showCurrencySelectionDialog,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(right: 16.0),
                        child: Text(
                          _selectedCurrencySymbol,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 24,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: _descriptionController,
              decoration: InputDecoration(labelText: 'Descripción'),
            ),
            SizedBox(height: 16.0),
            Autocomplete<String>(
              optionsBuilder: (TextEditingValue textEditingValue) {
                if (textEditingValue.text.isEmpty) {
                  return const Iterable<String>.empty();
                }
                return widget.categoryAggregate.categories
                    .where((Category category) => category.name
                    .toLowerCase()
                    .contains(textEditingValue.text.toLowerCase()))
                    .map((Category category) => category.name);
              },
              onSelected: (String selection) {
                _categoryController.text = selection;
              },
              fieldViewBuilder: (BuildContext context,
                  TextEditingController textEditingController,
                  FocusNode focusNode,
                  VoidCallback onFieldSubmitted) {
                textEditingController.text = _categoryController.text;
                return TextField(
                  controller: textEditingController,
                  focusNode: focusNode,
                  decoration: InputDecoration(
                    labelText: 'Categoría',
                    suffixIcon: IconButton(
                      icon: Icon(Icons.add),
                      onPressed: _showCreateCategoryDialog,
                    ),
                  ),
                );
              },
            ),
            SizedBox(height: 16.0), // Espacio agregado aquí
            ElevatedButton(
              onPressed: () async {
                final result = await FilePicker.platform.pickFiles();
                if (result != null) {
                  setState(() {
                    _attachmentPath = result.files.single.path!;
                  });
                }
              },
              child: Text('Adjuntar imagen/documento'),
              style: ElevatedButton.styleFrom(
                side: BorderSide(color: Colors.grey, width: 1.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
            ),
            if (_attachmentPath != null)
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Text(
                  'Archivo adjunto: ${_attachmentPath!.split('/').last}',
                  style: TextStyle(fontSize: 12.0, fontStyle: FontStyle.italic),
                ),
              ),
          ],
        ),
      ),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Cancelar'),
            ),
            TextButton(
              onPressed: widget.entry == null ? _addEntry : _updateEntry,
              child: Text(widget.entry == null ? 'Añadir' : 'Actualizar'),
            ),
          ],
        ),
      ],
    );
  }
}
