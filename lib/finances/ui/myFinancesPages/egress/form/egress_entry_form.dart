import 'dart:ui';

import 'package:exercises_flutter2/finances/ui/myFinancesPages/egress/form/provider_dialog.dart';
import 'package:exercises_flutter2/finances/ui/myFinancesPages/egress/form/save_file_locally.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

import '../../../../../shared/categories/application/use_cases/create_category_use_case.dart';
import '../../../../../shared/categories/application/use_cases/get_category_use_case.dart';
import '../../../../../shared/categories/domain/aggregates/category_aggregate.dart';
import '../../../../../shared/categories/domain/entities/category_entity.dart';
import '../../../../../shared/currencies/domain/entities/currency_entity.dart';
import '../../../../../shared/currencies/global_config.dart';
import '../../../../../shared/providers/application/use_cases/provider_use_case.dart';
import '../../../../../shared/providers/domain/aggregates/provider_aggregate.dart';
import '../../../../../shared/providers/domain/entities/provider_entity.dart';
import '../../../../application/use_cases/egress_use_case.dart';
import '../../../../domain/aggregates/egress_aggregate.dart';
import '../../../../domain/entities/egress_entry_entity.dart';
import 'category_dialog.dart';
import 'currency_dialog.dart';
import 'file_picker_button.dart';

class EgressEntryForm extends StatefulWidget {
  final CreateEgressEntryUseCase createEntryUseCase;
  final UpdateEgressEntryUseCase updateEntryUseCase;
  final EgressEntryAggregate aggregate;
  final List<CategoryAggregate> categoryAggregates;
  final ProviderAggregate providerAggregate;
  final CreateCategoryUseCase createCategoryUseCase;
  final GetCategoriesUseCase getCategoriesUseCase;
  final CreateProviderUseCase createProviderUseCase;
  final GetProvidersUseCase getProvidersUseCase;
  final EgressEntry? entry;
  final VoidCallback onSave;
  final String defaultCurrencySymbol;

  EgressEntryForm({
    required this.createEntryUseCase,
    required this.updateEntryUseCase,
    required this.aggregate,
    required this.categoryAggregates,
    required this.providerAggregate,
    required this.createCategoryUseCase,
    required this.getCategoriesUseCase,
    required this.getProvidersUseCase,
    required this.createProviderUseCase,
    this.entry,
    required this.onSave,
    required this.defaultCurrencySymbol,
  });

  @override
  _EgressEntryFormState createState() => _EgressEntryFormState();
}

class _EgressEntryFormState extends State<EgressEntryForm> {
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _categoryController = TextEditingController();
  final TextEditingController _providerController = TextEditingController();
  String? _attachmentPath;
  String _selectedCurrencySymbol = 'S/';
  final List<Currency> _availableCurrencies = [
    Currency(name: 'Sol', code: 'S/'),
    Currency(name: 'Dolar', code: '\$'),
    Currency(name: 'Euro', code: '€'),
  ];
  List<CategoryAggregate> localCategories = [];
  List<ProviderAggregate> localProviders = [];

  @override
  void initState() {
    super.initState();
    _selectedCurrencySymbol = GlobalConfig().defaultCurrency?.code ?? 'S/';
    _dateController.text = DateFormat('yyyy-MM-dd').format(DateTime.now());
    if (widget.entry != null) {
      _descriptionController.text = widget.entry!.description;
      _amountController.text = widget.entry!.amount.toString();
      _categoryController.text = widget.entry!.category ?? '';
      _providerController.text = widget.entry!.provider ?? '';
      _dateController.text =
          DateFormat('yyyy-MM-dd').format(widget.entry!.date);
      _attachmentPath = widget.entry!.attachmentPath;
    } else {
      _dateController.text = DateFormat('yyyy-MM-dd').format(DateTime.now());
    }
    _descriptionController.addListener(_updateButtonState);
    _amountController.addListener(_updateButtonState);
    _categoryController.addListener(_updateButtonState);

    _loadCategories();
  }
  void _loadCategories() async {
    localCategories = await widget.getCategoriesUseCase.execute();
    setState(() {});
  }
  void _updateButtonState() {
    setState(() {});
  }

  Future<String> _saveEgressLocally(String filePath) async {
    return saveEgressLocally(filePath);
  }

  void _addEntry() async {
    final description = _descriptionController.text;
    final amount = double.tryParse(_amountController.text) ?? 0.0;
    final category =
    _categoryController.text.isNotEmpty ? _categoryController.text : null;
    final provider =
    _providerController.text.isNotEmpty ? _providerController.text : null;
    final date = DateFormat('yyyy-MM-dd').parse(_dateController.text);

    if (description.isNotEmpty && amount > 0) {
      final attachmentPath = _attachmentPath != null
          ? await _saveEgressLocally(_attachmentPath!)
          : null;
      final entry = EgressEntry(
        description: description,
        amount: amount,
        date: date,
        category: category,
        provider: provider,
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
    final category =
    _categoryController.text.isNotEmpty ? _categoryController.text : null;
    final provider =
    _providerController.text.isNotEmpty ? _providerController.text : null;
    final date = DateFormat('yyyy-MM-dd').parse(_dateController.text);

    if (description.isNotEmpty && amount > 0) {
      final attachmentPath = _attachmentPath != null
          ? await _saveEgressLocally(_attachmentPath!)
          : widget.entry!.attachmentPath;
      final updatedEntry = EgressEntry(
        id: widget.entry!.id,
        description: description,
        amount: amount,
        date: date,
        category: category,
        provider: provider,
        attachmentPath: attachmentPath,
        currencySymbol: _selectedCurrencySymbol,
      );
      await widget.updateEntryUseCase.execute(widget.aggregate, updatedEntry);
      widget.onSave();
      Navigator.pop(context);
    }
  }

  void _createCategory(String name) async {
    final existingCategory = localCategories.firstWhere(
          (category) => category.name == name,
      orElse: () => Category(id: '', name: ''),
    );

    if (existingCategory.id.isEmpty) {
      final newCategory = Category(
        id: Uuid().v4(),
        name: name,
      );
      await widget.createCategoryUseCase.execute(newCategory);

      setState(() {
        localCategories.add(newCategory);
        _categoryController.text = newCategory.name;
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('La categoría ya existe.')),
      );
    }
  }

  void _createProvider(String name, {String? phoneNumber, String? ruc}) async {
    final existingProvider = localProviders.firstWhere(
          (provider) => provider.name == name,
      orElse: () => Provider(id: '', name: '', phoneNumber: null, ruc: null),
    );

    if (existingProvider.id.isEmpty) {
      final newProvider = Provider(
        id: Uuid().v4(),
        name: name,
        phoneNumber: phoneNumber,
        ruc: ruc,
      );
      await widget.createProviderUseCase
          .execute(widget.providerAggregate, newProvider);

      setState(() {
        localProviders.add(newProvider);
        _providerController.text = newProvider.name;
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('El proveedor ya existe.')),
      );
    }
  }

  void _showCreateCategoryDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return CategoryDialogEgress(
          onCreate: (name) {
            _createCategory(name);
          },
        );
      },
    );
  }

  void _showCreateProviderDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return ProviderDialogCreate(
          onCreate: (name, phoneNumber, ruc) {
            _createProvider(
              name,
              phoneNumber: phoneNumber,
              ruc: ruc,
            );
          },
        );
      },
    );
  }

  void _showCurrencySelectionDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return CurrencyDialogEgress(
          availableCurrencies: _availableCurrencies,
          onSelected: (currency) {
            setState(() {
              _selectedCurrencySymbol = currency.code;
            });
            Navigator.pop(context);
          },
        );
      },
    );
  }
  bool _areRequiredFieldsFilled() {
    return _descriptionController.text.isNotEmpty &&
        _amountController.text.isNotEmpty &&
        _categoryController.text.isNotEmpty;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Center(
          child: Text(widget.entry == null ? 'Nuevo Egreso' : 'Editar Egreso')),
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
                  child: Container(
                    color: Colors.transparent, // Asegura que el contenedor no bloquee la detección de toques
                    padding: EdgeInsets.symmetric(horizontal: 16.0), // Amplía el área de toque
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          _selectedCurrencySymbol,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 24,
                          ),
                        ),
                      ],
                    ),
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
                return localCategories
                    .where((category) => category.name
                    .toLowerCase()
                    .contains(textEditingValue.text.toLowerCase()))
                    .map((category) => category.name);
              },
              onSelected: (String selectedCategory) {
                _categoryController.text = selectedCategory;
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
            SizedBox(height: 16.0),
            Autocomplete<String>(
              optionsBuilder: (TextEditingValue textEditingValue) {
                if (textEditingValue.text.isEmpty) {
                  return const Iterable<String>.empty();
                }
                return localProviders
                    .where((provider) => provider.name
                    .toLowerCase()
                    .contains(textEditingValue.text.toLowerCase()))
                    .map((provider) => provider.name);
              },
              onSelected: (String selection) {
                _providerController.text = selection;
              },
              fieldViewBuilder: (BuildContext context,
                  TextEditingController textEditingController,
                  FocusNode focusNode,
                  VoidCallback onFieldSubmitted) {
                _providerController.text = textEditingController.text;
                return TextField(
                  controller: textEditingController,
                  focusNode: focusNode,
                  decoration: InputDecoration(
                    labelText: 'Proveedor',
                    suffixIcon: IconButton(
                      icon: Icon(Icons.add),
                      onPressed: _showCreateProviderDialog,
                    ),
                  ),
                );
              },
            ),
            SizedBox(height: 16.0),
            FilePickerButtonEgress(
              onFileSelected: (path) {
                setState(() {
                  _attachmentPath = path;
                });
              },
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
        Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text('Cancelar'),
                style: TextButton.styleFrom(
                  foregroundColor: Colors.indigo, // Cambia el color del texto a índigo
                ),
              ),
              TextButton(
                onPressed: _areRequiredFieldsFilled()
                    ? () {
                  if (widget.entry == null) {
                    _addEntry();
                  } else {
                    _updateEntry();
                  }
                }
                    : null,
                child: Text(widget.entry == null ? 'Agregar' : 'Actualizar'),
                style: TextButton.styleFrom(
                  foregroundColor: _areRequiredFieldsFilled() ? Colors.indigo : Colors.red,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

}