import 'dart:io';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:file_picker/file_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:exercises_flutter2/shared/categories/domain/entities/category_entity.dart';
import 'package:exercises_flutter2/shared/providers/domain/entities/provider_entity.dart';
import '../../../../shared/categories/domain/aggregates/category_aggregate.dart';
import '../../../../shared/providers/domain/aggregates/provider_aggregate.dart';
import '../../../application/use_cases/egress_use_case.dart';
import '../../../domain/aggregates/egress_aggregate.dart';
import '../../../domain/entities/egress_entry_entity.dart';

class EgressEntryForm extends StatefulWidget {
  final CreateEgressEntryUseCase createEntryUseCase;
  final UpdateEgressEntryUseCase updateEntryUseCase;
  final EgressEntryAggregate aggregate;
  final CategoryAggregate categoryAggregate;
  final ProviderAggregate providerAggregate;
  final EgressEntry? entry;
  final VoidCallback onSave;

  // final List<Category> categories;
  // final List<Provider> providers;

  EgressEntryForm({
    this.entry,
    required this.onSave,
    required this.updateEntryUseCase,
    required this.categoryAggregate,
    required this.providerAggregate,
    required this.createEntryUseCase,
    required this.aggregate,
    // // required this.categories,
    // //
    // required this.categories,
    // required this.providers,
  });

  @override
  _EgressEntryFormState createState() => _EgressEntryFormState();
}

class _EgressEntryFormState extends State<EgressEntryForm> {
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  String? _selectedCategory;
  String? _selectedProvider;
  String? _attachmentPath;

  @override
  void initState() {
    super.initState();
    if (widget.entry != null) {
      _descriptionController.text = widget.entry!.description;
      _amountController.text = widget.entry!.amount.toString();
      _selectedCategory = widget.entry!.category;
      _selectedProvider = widget.entry!.provider;
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

  void _saveEntry() async {
    final description = _descriptionController.text;
    final amount = double.tryParse(_amountController.text) ?? 0.0;
    final category = _selectedCategory;
    final provider = _selectedProvider;
    final date = DateFormat('yyyy-MM-dd').parse(_dateController.text);

    if (description.isNotEmpty &&
        amount > 0 &&
        category != null &&
        category.isNotEmpty &&
        provider != null &&
        provider.isNotEmpty) {
      final attachmentPath = _attachmentPath != null
          ? await _saveFileLocally(_attachmentPath!)
          : null;
      final entry = EgressEntry(
        id: widget.entry?.id,
        description: description,
        amount: amount,
        date: date,
        category: category,
        provider: provider,
        attachmentPath: attachmentPath,
      );
      await widget.createEntryUseCase.execute(widget.aggregate, entry);
      widget.onSave();
      Navigator.pop(context);
    }
  }
  void _addEntry() async {
    final description = _descriptionController.text;
    final amount = double.tryParse(_amountController.text) ?? 0.0;
    final category = _selectedCategory;
    final provider = _selectedProvider;
    final date = DateFormat('yyyy-MM-dd').parse(_dateController.text);

    if (description.isNotEmpty && amount > 0 && category != null &&
        category.isNotEmpty && provider != null && provider.isNotEmpty) {
      final attachmentPath = _attachmentPath != null ? await _saveFileLocally(_attachmentPath!) : null;
      final entry = EgressEntry(
        description: description,
        amount: amount,
        date: date,
        category: category,
        provider: provider,
        attachmentPath: attachmentPath,
      );
      await widget.createEntryUseCase.execute(widget.aggregate, entry);
      widget.onSave();
      Navigator.pop(context);
    }
  }
  void _updateEntryE() async {
    final description = _descriptionController.text;
    final amount = double.tryParse(_amountController.text) ?? 0.0;
    final category = _selectedCategory;
    final provider = _selectedProvider;
    final date = DateFormat('yyyy-MM-dd').parse(_dateController.text);

    if (description.isNotEmpty && amount > 0 && category != null &&
        category.isNotEmpty && provider != null && provider.isNotEmpty) {
      final attachmentPath = _attachmentPath != null ? await _saveFileLocally(
          _attachmentPath!) : widget.entry!.attachmentPath;
      final updatedEntry = EgressEntry(
        id: widget.entry!.id,
        description: description,
        amount: amount,
        date: date,
        category: category,
        provider: provider,
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
      title: Center(
          child: Text(widget.entry == null ? 'Nuevo Egreso' : 'Editar Egreso')),
      content: Container(
        width: MediaQuery.of(context).size.width * 0.8,
        child: SingleChildScrollView(
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
                decoration: InputDecoration(
                  labelText: 'Categoría',
                ),
                items: widget.categoryAggregate.categories.map((
                    Category category) {
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
              DropdownButtonFormField<String>(
                value: _selectedProvider,
                decoration: InputDecoration(
                  labelText: 'Proveedor',
                ),
                items: widget.providerAggregate.providers.map((
                    Provider provider) {
                  return DropdownMenuItem<String>(
                    value: provider.name,
                    child: Text(provider.name),
                  );
                }).toList(),
                onChanged: (newValue) {
                  setState(() {
                    _selectedProvider = newValue;
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
                    _updateEntryE();
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
