// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
//
// import '../../../../Provider/domain/entities/provider_entity.dart';
// import '../../../../category/domain/entities/category_entity.dart';
// import '../../application/use_cases/egress_entry_use_case.dart';
// import '../../domain/aggregates/egress_entry_aggregate.dart';
//
// import '../../domain/entities/egress_entry_entity.dart';
// import '../../infrastructure/adapters/egress_entry_adapter.dart';
//
// class EgressPage extends StatefulWidget {
//   final CreateEgressEntryUseCase createEntryUseCase;
//   final UpdateEgressEntryUseCase updateEntryUseCase;
//   final DeleteEgressEntryUseCase deleteEntryUseCase;
//   final GetEgressEntriesUseCase getEntriesUseCase;
//   final EgressEntryAggregate aggregate;
//   final List<Category> categories;
//   final List<Provider> providers;
//
//   EgressPage({
//     required this.createEntryUseCase,
//     required this.updateEntryUseCase,
//     required this.deleteEntryUseCase,
//     required this.getEntriesUseCase,
//     required this.aggregate,
//     required this.categories,
//     required this.providers,
//   });
//
//   @override
//   _EgressPageState createState() => _EgressPageState();
// }
//
// class _EgressPageState extends State<EgressPage> {
//   final TextEditingController _descriptionController = TextEditingController();
//   final TextEditingController _amountController = TextEditingController();
//   final TextEditingController _dateController = TextEditingController();
//   String? _selectedCategory;
//   String? _selectedProvider;
//
//   @override
//   void initState() {
//     super.initState();
//     _loadEntries();
//   }
//
//   Future<void> _loadEntries() async {
//     final entries = await widget.getEntriesUseCase.execute(widget.aggregate);
//     setState(() {
//       widget.aggregate._entries.clear();
//       widget.aggregate._entries.addAll(entries);
//     });
//   }
//
//   Future<void> _addOrUpdateEntry({String? id}) async {
//     if (_descriptionController.text.isEmpty ||
//         _amountController.text.isEmpty ||
//         _selectedCategory == null ||
//         _selectedProvider == null) return;
//
//     final entry = EgressEntry(
//       id: id ?? DateTime.now().toString(),
//       description: _descriptionController.text,
//       amount: double.parse(_amountController.text),
//       date: DateTime.parse(_dateController.text),
//       categoryId: _selectedCategory!,
//       providerId: _selectedProvider!,
//     );
//
//     if (id == null) {
//       await widget.createEntryUseCase.execute(widget.aggregate, entry);
//     } else {
//       await widget.updateEntryUseCase.execute(widget.aggregate, entry);
//     }
//
//     _descriptionController.clear();
//     _amountController.clear();
//     _dateController.clear();
//     _selectedCategory = null;
//     _selectedProvider = null;
//     _loadEntries();
//   }
//
//   Future<void> _deleteEntryById(String id) async {
//     final entry = widget.aggregate.entries.firstWhere((e) => e.id == id);
//     await widget.deleteEntryUseCase.execute(widget.aggregate, entry);
//     _loadEntries();
//   }
//
//   void _showAddEntryDialog({
//     String? id,
//     String? initialDescription,
//     double? initialAmount,
//     DateTime? initialDate,
//     String? initialCategoryId,
//     String? initialProviderId,
//   }) {
//     if (initialDescription != null) {
//       _descriptionController.text = initialDescription;
//     } else {
//       _descriptionController.clear();
//     }
//
//     if (initialAmount != null) {
//       _amountController.text = initialAmount.toString();
//     } else {
//       _amountController.clear();
//     }
//
//     if (initialDate != null) {
//       _dateController.text = initialDate.toIso8601String().split('T')[0];
//     } else {
//       _dateController.clear();
//     }
//
//     _selectedCategory = initialCategoryId;
//     _selectedProvider = initialProviderId;
//
//     showDialog(
//       context: context,
//       builder: (context) {
//         return StatefulBuilder(
//           builder: (context, setState) {
//             return AlertDialog(
//               title: Text(id == null ? 'Nuevo Egreso' : 'Editar Egreso'),
//               content: Container(
//                 width: MediaQuery.of(context).size.width * 0.8,
//                 child: SingleChildScrollView(
//                   child: Column(
//                     mainAxisSize: MainAxisSize.min,
//                     children: [
//                       TextField(
//                         controller: _dateController,
//                         decoration: InputDecoration(
//                           labelText: 'Fecha',
//                           suffixIcon: Icon(Icons.calendar_today),
//                         ),
//                         onTap: () async {
//                           DateTime? pickedDate = await showDatePicker(
//                             context: context,
//                             initialDate: DateTime.now(),
//                             firstDate: DateTime(2000),
//                             lastDate: DateTime(2101),
//                           );
//                           if (pickedDate != null) {
//                             setState(() {
//                               _dateController.text = pickedDate.toString().split(' ')[0];
//                             });
//                           }
//                         },
//                       ),
//                       SizedBox(height: 16.0),
//                       TextField(
//                         controller: _amountController,
//                         keyboardType: TextInputType.numberWithOptions(decimal: true),
//                         decoration: InputDecoration(
//                           labelText: 'Monto',
//                         ),
//                       ),
//                       SizedBox(height: 16.0),
//                       DropdownButtonFormField<String>(
//                         value: _selectedCategory,
//                         items: widget.categories.map((category) {
//                           return DropdownMenuItem<String>(
//                             value: category.id,
//                             child: Text(category.name),
//                           );
//                         }).toList(),
//                         onChanged: (value) {
//                           setState(() {
//                             _selectedCategory = value;
//                           });
//                         },
//                         decoration: InputDecoration(
//                           labelText: 'Categoría',
//                         ),
//                       ),
//                       SizedBox(height: 16.0),
//                       DropdownButtonFormField<String>(
//                         value: _selectedProvider,
//                         items: widget.providers.map((provider) {
//                           return DropdownMenuItem<String>(
//                             value: provider.id,
//                             child: Text(provider.name),
//                           );
//                         }).toList(),
//                         onChanged: (value) {
//                           setState(() {
//                             _selectedProvider = value;
//                           });
//                         },
//                         decoration: InputDecoration(
//                           labelText: 'Proveedor',
//                         ),
//                       ),
//                       SizedBox(height: 16.0),
//                       TextField(
//                         controller: _descriptionController,
//                         decoration: InputDecoration(
//                           labelText: 'Descripción',
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//               actions: [
//                 TextButton(
//                   onPressed: () => Navigator.pop(context),
//                   child: Text('Cancelar'),
//                 ),
//                 TextButton(
//                   onPressed: () {
//                     _addOrUpdateEntry(id: id);
//                     Navigator.pop(context); // Cerrar el diálogo después de agregar/editar
//                   },
//                   child: Text(id == null ? 'Agregar' : 'Actualizar'),
//                 ),
//               ],
//             );
//           },
//         );
//       },
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Egresos'),
//       ),
//       body: StreamBuilder<List<EgressEntry>>(
//         stream: widget.aggregate.entriesStream,
//         builder: (context, snapshot) {
//           if (snapshot.hasData) {
//             final entries = snapshot.data!;
//             return ListView.builder(
//               itemCount: entries.length,
//               itemBuilder: (context, index) {
//                 final entry = entries[index];
//                 return Dismissible(
//                   key: Key(entry.id),
//                   onDismissed: (direction) {
//                     _deleteEntryById(entry.id);
//                   },
//                   background: Container(
//                     color: Colors.red,
//                     child: Icon(Icons.delete, color: Colors.white),
//                     alignment: Alignment.centerRight,
//                     padding: EdgeInsets.only(right: 20.0),
//                   ),
//                   child: ListTile(
//                     title: Text(entry.description),
//                     subtitle: Text(
//                       '${entry.amount.toString()} (${entry.date.toString().split(' ')[0]})',
//                     ),
//                     onTap: () {
//                       _showAddEntryDialog(
//                         id: entry.id,
//                         initialDescription: entry.description,
//                         initialAmount: entry.amount,
//                         initialDate: entry.date,
//                         initialCategoryId: entry.categoryId,
//                         initialProviderId: entry.providerId,
//                       );
//                     },
//                   ),
//                 );
//               },
//             );
//           } else {
//             return Center(child: CircularProgressIndicator());
//           }
//         },
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {
//           _showAddEntryDialog();
//         },
//         child: Icon(Icons.add),
//       ),
//     );
//   }
// }
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../Provider/domain/entities/provider_entity.dart';
import '../../../../category/domain/entities/category_entity.dart';
import '../../application/use_cases/egress_entry_use_case.dart';
import '../../domain/aggregates/egress_entry_aggregate.dart';
import '../../domain/entities/egress_entry_entity.dart';


class EgressPage extends StatefulWidget {
  final CreateEgressEntryUseCase createEntryUseCase;
  final UpdateEgressEntryUseCase updateEntryUseCase;
  final DeleteEgressEntryUseCase deleteEntryUseCase;
  final GetEgressEntriesUseCase getEntriesUseCase;
  final EgressEntryAggregate aggregate;
  final List<Category> categories;
  final List<Provider> providers;

  EgressPage({
    required this.createEntryUseCase,
    required this.updateEntryUseCase,
    required this.deleteEntryUseCase,
    required this.getEntriesUseCase,
    required this.aggregate,
    required this.categories,
    required this.providers,
  });

  @override
  _EgressPageState createState() => _EgressPageState();
}

class _EgressPageState extends State<EgressPage> {
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  String? _selectedCategory;
  String? _selectedProvider;

  @override
  void initState() {
    super.initState();
    _loadEntries();
  }

  Future<void> _loadEntries() async {
    final entries = await widget.getEntriesUseCase.execute(widget.aggregate);
    setState(() {
      widget.aggregate.entries.clear();
      widget.aggregate.entries.addAll(entries);
    });
  }

  Future<void> _addOrUpdateEntry({String? id}) async {
    if (_descriptionController.text.isEmpty ||
        _amountController.text.isEmpty ||
        _selectedCategory == null ||
        _selectedProvider == null) return;

    final entry = EgressEntry(
      id: id ?? DateTime.now().toString(),
      description: _descriptionController.text,
      amount: double.parse(_amountController.text),
      date: DateTime.parse(_dateController.text),
      categoryId: _selectedCategory!,
      providerId: _selectedProvider!,
    );

    if (id == null) {
      await widget.createEntryUseCase.execute(widget.aggregate, entry);
    } else {
      await widget.updateEntryUseCase.execute(widget.aggregate, entry);
    }

    _descriptionController.clear();
    _amountController.clear();
    _dateController.clear();
    _selectedCategory = null;
    _selectedProvider = null;
    _loadEntries();
  }

  Future<void> _deleteEntryById(String id) async {
    final entry = widget.aggregate.entries.firstWhere((e) => e.id == id);
    await widget.deleteEntryUseCase.execute(widget.aggregate, entry);
    _loadEntries();
  }

  void _showAddEntryDialog({
    String? id,
    String? initialDescription,
    double? initialAmount,
    DateTime? initialDate,
    String? initialCategoryId,
    String? initialProviderId,
  }) {
    if (initialDescription != null) {
      _descriptionController.text = initialDescription;
    } else {
      _descriptionController.clear();
    }

    if (initialAmount != null) {
      _amountController.text = initialAmount.toString();
    } else {
      _amountController.clear();
    }

    if (initialDate != null) {
      _dateController.text = initialDate.toIso8601String().split('T')[0];
    } else {
      _dateController.clear();
    }

    _selectedCategory = initialCategoryId;
    _selectedProvider = initialProviderId;

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(id == null ? 'Agregar Egreso' : 'Editar Egreso'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _dateController,
                decoration: InputDecoration(
                  labelText: 'Fecha',
                  suffixIcon: Icon(Icons.calendar_today),
                ),
                onTap: () async {
                  DateTime? pickedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2101),
                  );
                  if (pickedDate != null) {
                    _dateController.text = pickedDate.toIso8601String().split('T')[0];
                  }
                },
              ),
              TextField(
                controller: _amountController,
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                decoration: InputDecoration(labelText: 'Monto'),
              ),
              DropdownButtonFormField<String>(
                value: _selectedCategory,
                items: widget.categories.map((category) {
                  return DropdownMenuItem<String>(
                    value: category.id,
                    child: Text(category.name),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedCategory = value;
                  });
                },
                decoration: InputDecoration(labelText: 'Categoría'),
              ),
              DropdownButtonFormField<String>(
                value: _selectedProvider,
                items: widget.providers.map((provider) {
                  return DropdownMenuItem<String>(
                    value: provider.id,
                    child: Text(provider.name),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedProvider = value;
                  });
                },
                decoration: InputDecoration(labelText: 'Proveedor'),
              ),
              TextField(
                controller: _descriptionController,
                decoration: InputDecoration(labelText: 'Descripción'),
              ),
            ],
          ),
          actions: [
            TextButton(
              child: Text('Cancelar'),
              onPressed: () => Navigator.of(context).pop(),
            ),
            TextButton(
              child: Text('Guardar'),
              onPressed: () {
                _addOrUpdateEntry(id: id);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Egresos'),
      ),
      body: ListView.builder(
        itemCount: widget.aggregate.entries.length,
        itemBuilder: (context, index) {
          final entry = widget.aggregate.entries[index];
          return ListTile(
            title: Text(entry.description),
            subtitle: Text('${entry.amount} (${entry.date.toIso8601String().split('T')[0]})'),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () => _showAddEntryDialog(
                    id: entry.id,
                    initialDescription: entry.description,
                    initialAmount: entry.amount,
                    initialDate: entry.date,
                    initialCategoryId: entry.categoryId,
                    initialProviderId: entry.providerId,
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () => _deleteEntryById(entry.id),
                ),
              ],
            ),
            onTap: () {
              _descriptionController.text = entry.description;
              _amountController.text = entry.amount.toString();
              _dateController.text = entry.date.toIso8601String().split('T')[0];
              _selectedCategory = entry.categoryId;
              _selectedProvider = entry.providerId;
              _showAddEntryDialog(
                id: entry.id,
                initialDescription: entry.description,
                initialAmount: entry.amount,
                initialDate: entry.date,
                initialCategoryId: entry.categoryId,
                initialProviderId: entry.providerId,
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddEntryDialog(),
        tooltip: 'Agregar egreso',
        child: Icon(Icons.add),
      ),
    );
  }
}
