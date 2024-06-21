// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
//
// import '../../../../category/domain/entities/category_entity.dart';
// import '../../application/use_cases/income_entry_use_case.dart';
// import '../../domain/aggregates/income_entry_aggregate.dart';
// import '../../domain/entities/income_entry_entity.dart';
//
// class IncomePage extends StatefulWidget {
//   final CreateIncomeEntryUseCase createEntryUseCase;
//   final UpdateIncomeEntryUseCase updateEntryUseCase;
//   final DeleteIncomeEntryUseCase deleteEntryUseCase;
//   final GetIncomeEntriesUseCase getEntriesUseCase;
//   final IncomeEntryAggregate aggregate;
//   final List<Category> categories;
//
//   IncomePage({
//     required this.createEntryUseCase,
//     required this.updateEntryUseCase,
//     required this.deleteEntryUseCase,
//     required this.getEntriesUseCase,
//     required this.aggregate,
//     required this.categories,
//   });
//
//   @override
//   _IncomePageState createState() => _IncomePageState();
// }
//
// class _IncomePageState extends State<IncomePage> {
//   final TextEditingController _descriptionController = TextEditingController();
//   final TextEditingController _amountController = TextEditingController();
//   final TextEditingController _dateController = TextEditingController();
//   String? _selectedCategory;
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
//       widget.aggregate.entries.clear();
//       widget.aggregate.entries.addAll(entries);
//     });
//   }
//
//   Future<void> _addOrUpdateEntry({String? id}) async {
//     if (_descriptionController.text.isEmpty || _amountController.text.isEmpty || _selectedCategory == null) return;
//
//     final entry = IncomeEntry(
//       id: id ?? DateTime.now().toString(),
//       description: _descriptionController.text,
//       amount: double.parse(_amountController.text),
//       date: DateTime.parse(_dateController.text),
//       categoryId: _selectedCategory!,
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
//
//     showDialog(
//       context: context,
//       builder: (context) {
//         return AlertDialog(
//           title: Text(id == null ? 'Agregar Ingreso' : 'Editar Ingreso'),
//           content: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               TextField(
//                 controller: _dateController,
//                 decoration: InputDecoration(
//                   labelText: 'Fecha',
//                   suffixIcon: Icon(Icons.calendar_today),
//                 ),
//                 onTap: () async {
//                   DateTime? pickedDate = await showDatePicker(
//                     context: context,
//                     initialDate: DateTime.now(),
//                     firstDate: DateTime(2000),
//                     lastDate: DateTime(2101),
//                   );
//                   if (pickedDate != null) {
//                     _dateController.text = pickedDate.toIso8601String().split('T')[0];
//                   }
//                 },
//               ),
//               TextField(
//                 controller: _amountController,
//                 keyboardType: TextInputType.numberWithOptions(decimal: true),
//                 decoration: InputDecoration(labelText: 'Monto'),
//               ),
//               DropdownButtonFormField<String>(
//                 value: _selectedCategory,
//                 items: widget.categories.map((category) {
//                   return DropdownMenuItem<String>(
//                     value: category.id,
//                     child: Text(category.name),
//                   );
//                 }).toList(),
//                 onChanged: (value) {
//                   setState(() {
//                     _selectedCategory = value;
//                   });
//                 },
//                 decoration: InputDecoration(labelText: 'Categoría'),
//               ),
//               TextField(
//                 controller: _descriptionController,
//                 decoration: InputDecoration(labelText: 'Descripción'),
//               ),
//             ],
//           ),
//           actions: [
//             TextButton(
//               child: Text('Cancelar'),
//               onPressed: () => Navigator.of(context).pop(),
//             ),
//             TextButton(
//               child: Text('Guardar'),
//               onPressed: () {
//                 _addOrUpdateEntry(id: id);
//                 Navigator.of(context).pop();
//               },
//             ),
//           ],
//         );
//       },
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Ingresos'),
//       ),
//       body: ListView.builder(
//         itemCount: widget.aggregate.entries.length,
//         itemBuilder: (context, index) {
//           final entry = widget.aggregate.entries[index];
//           return ListTile(
//             title: Text(entry.description),
//             subtitle: Text('${entry.amount} (${entry.date.toIso8601String().split('T')[0]})'),
//             trailing: Row(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 IconButton(
//                   icon: Icon(Icons.edit),
//                   onPressed: () => _showAddEntryDialog(
//                     id: entry.id,
//                     initialDescription: entry.description,
//                     initialAmount: entry.amount,
//                     initialDate: entry.date,
//                     initialCategoryId: entry.categoryId,
//                   ),
//                 ),
//                 IconButton(
//                   icon: Icon(Icons.delete),
//                   onPressed: () => _deleteEntryById(entry.id),
//                 ),
//               ],
//             ),
//             onTap: () {
//               _descriptionController.text = entry.description;
//               _amountController.text = entry.amount.toString();
//               _dateController.text = entry.date.toIso8601String().split('T')[0];
//               _selectedCategory = entry.categoryId;
//               _showAddEntryDialog(
//                 id: entry.id,
//                 initialDescription: entry.description,
//                 initialAmount: entry.amount,
//                 initialDate: entry.date,
//                 initialCategoryId: entry.categoryId,
//               );
//             },
//           );
//         },
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () => _showAddEntryDialog(),
//         tooltip: 'Agregar ingreso',
//         child: Icon(Icons.add),
//       ),
//     );
//   }
// }
