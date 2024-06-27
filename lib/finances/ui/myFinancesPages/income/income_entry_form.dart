import 'dart:io';
import 'dart:ui';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';

import '../../../../shared/categories/domain/aggregates/category_aggregate.dart';
import '../../../../shared/categories/domain/entities/category_entity.dart';
import '../../../application/use_cases/income_use_case.dart';
import '../../../domain/aggregates/income_aggregate.dart';
import '../../../domain/entities/income_entry_entity.dart';

class IncomeEntryForm extends StatefulWidget {
  final CreateIncomeEntryUseCase createEntryUseCase;
  final UpdateIncomeEntryUseCase updateEntryUseCase;
  final IncomeEntryAggregate aggregate;
  final CategoryAggregate categoryAggregate;
  final IncomeEntry? entry;
  final VoidCallback onSave;

  IncomeEntryForm({
    required this.createEntryUseCase,
    required this.updateEntryUseCase,
    required this.aggregate,
    required this.categoryAggregate,
    this.entry,
    required this.onSave,
  });

  @override
  _IncomeEntryFormState createState() => _IncomeEntryFormState();
}

class _IncomeEntryFormState extends State<IncomeEntryForm> {
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  String? _selectedCategory;
  String? _attachmentPath;

  @override
  void initState() {
    super.initState();
    _dateController.text = DateFormat('yyyy-MM-dd').format(DateTime.now());
    if (widget.entry != null) {
      _descriptionController.text = widget.entry!.description;
      _amountController.text = widget.entry!.amount.toString();
      _selectedCategory = widget.entry!.category;
      _dateController.text = DateFormat('yyyy-MM-dd').format(widget.entry!.date);
      _attachmentPath = widget.entry!.attachmentPath;
    }else {
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
    final category = _selectedCategory;
    final date = DateFormat('yyyy-MM-dd').parse(_dateController.text);

    if (description.isNotEmpty && amount > 0 && category != null && category.isNotEmpty) {
      final attachmentPath = _attachmentPath != null ? await _saveFileLocally(_attachmentPath!) : null;
      final entry = IncomeEntry(
        description: description,
        amount: amount,
        date: date,
        category: category,
        attachmentPath: attachmentPath,
      );
      await widget.createEntryUseCase.execute(widget.aggregate, entry);
      widget.onSave();
      Navigator.pop(context);
    }
  }

  void _updateEntry() async {
    final description = _descriptionController.text;
    final amount = double.tryParse(_amountController.text) ?? 0.0;
    final category = _selectedCategory;
    final date = DateFormat('yyyy-MM-dd').parse(_dateController.text);

    if (description.isNotEmpty && amount > 0 && category != null && category.isNotEmpty) {
      final attachmentPath = _attachmentPath != null ? await _saveFileLocally(_attachmentPath!) : widget.entry!.attachmentPath;
      final updatedEntry = IncomeEntry(
        id: widget.entry!.id,
        description: description,
        amount: amount,
        date: date,
        category: category,
        attachmentPath: attachmentPath,
      );
      await widget.updateEntryUseCase.execute(widget.aggregate, updatedEntry);
      widget.onSave();
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Center(child: Text(widget.entry == null ? 'Nuevo Ingreso' : 'Editar Ingreso')),
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
                        _dateController.text = DateFormat('yyyy-MM-dd').format(pickedDate);
                      });
                    }
                  },
                ),
              ),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: _amountController,
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              decoration: InputDecoration(labelText: 'Monto'),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: _descriptionController,
              decoration: InputDecoration(labelText: 'Descripción'),
            ),
            SizedBox(height: 16.0),
            DropdownButtonFormField<String>(
              value: _selectedCategory,
              decoration: InputDecoration(labelText: 'Categoría'),
              items: widget.categoryAggregate.categories.map((Category category) {
                return DropdownMenuItem<String>(
                  value: category.name,
                  child: Text(category.name),
                );
              }).toList(),
              onChanged: (newValue) {
                setState(() {
                  _selectedCategory = newValue;
                });
              },
            ),
            SizedBox(height: 16.0),
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
            ),
          ],
        ),
      ),
      actions: [
        Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text('Cancelar'),
              ),
              TextButton(
                onPressed: () {
                  if (widget.entry == null) {
                    _addEntry();
                  } else {
                    _updateEntry();
                  }
                },
                child: Text(widget.entry == null ? 'Agregar' : 'Actualizar'),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
