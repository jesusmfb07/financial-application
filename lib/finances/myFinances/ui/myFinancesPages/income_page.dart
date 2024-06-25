import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../application/use_cases/income_use_case.dart';
import '../../domain/aggregates/income_aggregate.dart';
import '../../domain/entities/income_entry_entity.dart';

class IncomePage extends StatefulWidget {
  final CreateIncomeEntryUseCase createEntryUseCase;
  final UpdateIncomeEntryUseCase updateEntryUseCase;
  final GetIncomeEntriesUseCase getEntriesUseCase;
  final IncomeEntryAggregate aggregate;
  final List<String> categories;

  IncomePage({
    required this.createEntryUseCase,
    required this.updateEntryUseCase,
    required this.getEntriesUseCase,
    required this.aggregate,
    required this.categories,
  });

  @override
  _IncomePageState createState() => _IncomePageState();
}

class _IncomePageState extends State<IncomePage> {
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _categoryController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _dateController.text = DateFormat('yyyy-MM-dd').format(DateTime.now());
    _loadEntries();
  }

  Future<void> _loadEntries() async {
    final entries = await widget.getEntriesUseCase.execute(widget.aggregate);
    setState(() {
      widget.aggregate.entries.clear();
      widget.aggregate.entries.addAll(entries);
    });
  }

  void _addEntry() async {
    final description = _descriptionController.text;
    final amount = double.tryParse(_amountController.text) ?? 0.0;
    final category = _categoryController.text;
    final date = DateFormat('yyyy-MM-dd').parse(_dateController.text);

    if (description.isNotEmpty && amount > 0 && category.isNotEmpty) {
      final entry = IncomeEntry(
        description: description,
        amount: amount,
        date: date,
        category: category,
      );
      await widget.createEntryUseCase.execute(widget.aggregate, entry);
      _loadEntries();
      _clearFields();
    }
  }

  void _updateEntry(IncomeEntry entry) async {
    final description = _descriptionController.text;
    final amount = double.tryParse(_amountController.text) ?? 0.0;
    final category = _categoryController.text;
    final date = DateFormat('yyyy-MM-dd').parse(_dateController.text);

    if (description.isNotEmpty && amount > 0 && category.isNotEmpty) {
      final updatedEntry = IncomeEntry(
        id: entry.id, // Assuming you have an id to identify the entry
        description: description,
        amount: amount,
        date: date,
        category: category,
      );
      await widget.updateEntryUseCase.execute(widget.aggregate, updatedEntry);
      _loadEntries();
      _clearFields();
    }
  }

  void _clearFields() {
    _descriptionController.clear();
    _amountController.clear();
    _categoryController.clear();
    _dateController.text = DateFormat('yyyy-MM-dd').format(DateTime.now());
  }

  void _showEntryDialog({IncomeEntry? entry}) {
    if (entry != null) {
      _descriptionController.text = entry.description;
      _amountController.text = entry.amount.toString();
      _categoryController.text = entry.category;
      _dateController.text = DateFormat('yyyy-MM-dd').format(entry.date);
    } else {
      _clearFields();
    }

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Center(child: Text(entry == null ? 'Nuevo Ingreso' : 'Editar Ingreso')),
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
                  TextField(
                    controller: _categoryController,
                    decoration: InputDecoration(labelText: 'Categoría'),
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
      body: FutureBuilder<List<IncomeEntry>>(
        future: widget.getEntriesUseCase.execute(widget.aggregate),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No hay entradas'));
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
                        offset: Offset(0, 4),
                      ),
                    ],
                  ),
                  child: ListTile(
                    title: Text(entry.description),
                    subtitle: Text('${entry.amount} (${entry.category})'),
                    trailing: IconButton(
                      icon: Icon(Icons.edit),
                      onPressed: () {
                        _showEntryDialog(entry: entry);
                      },
                    ),
                    onTap: () {
                      _showEntryDialog(entry: entry);
                    },
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
