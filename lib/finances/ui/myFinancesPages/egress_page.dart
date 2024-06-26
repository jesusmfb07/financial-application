import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../shared/categories/application/use_cases/category_use_case.dart';
import '../../../../shared/categories/domain/aggregates/category_aggregate.dart';
import '../../../../shared/categories/domain/entities/category_entity.dart';
import '../../../../shared/providers/application/use_cases/provider_use_case.dart';
import '../../../../shared/providers/domain/aggregates/provider_aggregate.dart';
import '../../../../shared/providers/domain/entities/provider_entity.dart';
import '../../application/use_cases/egress_use_case.dart';
import '../../domain/aggregates/egress_aggregate.dart';
import '../../domain/entities/egress_entry_entity.dart';

class EgressPage extends StatefulWidget {
  final CreateEgressEntryUseCase createEntryUseCase;
  final UpdateEgressEntryUseCase updateEntryUseCase;
  final GetEgressEntriesUseCase getEntriesUseCase;
  final GetCategoriesUseCase getCategoriesUseCase;
  final GetProvidersUseCase getProvidersUseCase;
  final EgressEntryAggregate aggregate;
  final CategoryAggregate categoryAggregate;
  final ProviderAggregate providerAggregate;
  final String? attachmentPath;
  bool _isInitialized = false;

  EgressPage({
    required this.createEntryUseCase,
    required this.updateEntryUseCase,
    required this.getEntriesUseCase,
    required this.getCategoriesUseCase,
    required this.getProvidersUseCase,
    required this.aggregate,
    required this.categoryAggregate,
    required this.providerAggregate,
    this.attachmentPath,
  });

  @override
  _EgressPageState createState() => _EgressPageState();
}

class _EgressPageState extends State<EgressPage> {
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _providerController = TextEditingController();
  String? _selectedCategory;
  String? _selectedProvider;
  String? _attachmentPath;

  @override
  void initState() {
    super.initState();
    _dateController.text = DateFormat('yyyy-MM-dd').format(DateTime.now());
    _loadEntries();
    _loadCategories();
    _loadProviders();
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

  Future<void> _loadProviders() async {
    final providers = await widget.getProvidersUseCase.execute(widget.providerAggregate);
    setState(() {
      widget.providerAggregate.providers.clear();
      widget.providerAggregate.providers.addAll(providers);
    });
  }

  void _addEntry() async {
    final description = _descriptionController.text;
    final amount = double.tryParse(_amountController.text) ?? 0.0;
    final category = _selectedCategory;
    final provider = _selectedProvider;
    final date = DateFormat('yyyy-MM-dd').parse(_dateController.text);

    if (description.isNotEmpty && amount > 0 && category != null && category.isNotEmpty && provider != null && provider.isNotEmpty) {
      final entry = EgressEntry(
        description: description,
        amount: amount,
        date: date,
        category: category,
        provider: provider,
        attachmentPath: _attachmentPath,
      );
      await widget.createEntryUseCase.execute(widget.aggregate, entry);
      _loadEntries();
      _clearFields();
    }
  }

  void _updateEntry(EgressEntry entry) async {
    final description = _descriptionController.text;
    final amount = double.tryParse(_amountController.text) ?? 0.0;
    final category = _selectedCategory;
    final provider = _selectedProvider;
    final date = DateFormat('yyyy-MM-dd').parse(_dateController.text);

    if (description.isNotEmpty && amount > 0 && category != null && category.isNotEmpty && provider != null && provider.isNotEmpty) {
      final updatedEntry = EgressEntry(
        id: entry.id,
        description: description,
        amount: amount,
        date: date,
        category: category,
        provider: provider,
        attachmentPath: _attachmentPath,
      );
      await widget.updateEntryUseCase.execute(widget.aggregate, updatedEntry);
      _loadEntries();
      _clearFields();
    }
  }

  void _clearFields() {
    _descriptionController.clear();
    _amountController.clear();
    _selectedCategory = null;
    _selectedProvider = null;
    _dateController.text = DateFormat('yyyy-MM-dd').format(DateTime.now());
    _attachmentPath = null;
  }

  void _showEntryDialog({EgressEntry? entry}) {
    if (entry != null) {
      _descriptionController.text = entry.description;
      _amountController.text = entry.amount.toString();
      _selectedCategory = entry.category;
      _selectedProvider = entry.provider;
      _dateController.text = DateFormat('yyyy-MM-dd').format(entry.date);
      _attachmentPath = entry.attachmentPath;
    } else {
      _clearFields();
    }

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Center(child: Text(entry == null ? 'Nuevo Egreso' : 'Editar Egreso')),
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
                    decoration: InputDecoration(
                      labelText: 'Categoría',
                    ),
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
                  DropdownButtonFormField<String>(
                    value: _selectedProvider,
                    decoration: InputDecoration(
                      labelText: 'Proveedor',
                    ),
                    items: widget.providerAggregate.providers.map((Provider provider) {
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
                      if (entry == null) {
                        _addEntry();
                      } else {
                        _updateEntry(entry);
                      }
                      Navigator.pop(context);
                    },
                    child: Text(entry == null ? 'Agregar' : 'Actualizar'),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<EgressEntry>>(
        future: widget.getEntriesUseCase.execute(widget.aggregate),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No hay egresos'));
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final entry = snapshot.data![index];
                return Container(
                  margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                  padding: EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 4.0,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (entry.attachmentPath != null)
                        Container(
                          width: 60,
                          height: 60,
                          margin: EdgeInsets.only(right: 16.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8.0),
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: FileImage(File(entry.attachmentPath!)),
                            ),
                          ),
                        )
                      else
                        Container(
                          width: 60,
                          height: 60,
                          margin: EdgeInsets.only(right: 16.0),
                          decoration: BoxDecoration(
                            color: Colors.grey[300],
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          child: Icon(Icons.insert_drive_file, color: Colors.grey[600]),
                        ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Fecha: ${DateFormat('yyyy-MM-dd').format(entry.date)}',
                              style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              'Monto: \$${entry.amount.toStringAsFixed(2)}',
                              style: TextStyle(fontSize: 16.0),
                            ),
                            Text(
                              'Descripción: ${entry.description}',
                              style: TextStyle(fontSize: 16.0),
                            ),
                            Text(
                              'Categoría: ${entry.category}',
                              style: TextStyle(fontSize: 16.0),
                            ),
                            Text(
                              'Proveedor: ${entry.provider}',
                              style: TextStyle(fontSize: 16.0),
                            ),
                          ],
                        ),
                      ),
                      IconButton(
                        icon: Icon(Icons.edit),
                        onPressed: () => _showEntryDialog(entry: entry),
                      ),
                    ],
                  ),
                );
              },
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showEntryDialog(),
        child: Icon(Icons.add),
      ),
    );
  }
}

