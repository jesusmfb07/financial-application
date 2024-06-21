// import 'package:flutter/material.dart';
// import '../../application/use_cases/finances_entries_usecase.dart';
// import '../../application/use_cases/handler/command/create_finance_entry_command.dart';
// import '../../domain/aggregates/finance_entry.aggregate.dart';
// import '../../domain/entities/finance_entry.entity.dart';
// import '../../infrastructure/adapters/income_adapter.dart';
//
// class IncomePage extends StatefulWidget {
//   @override
//   _IncomePageState createState() => _IncomePageState();
// }
//
// class _IncomePageState extends State<IncomePage> {
//   final _repository = FinanceEntryAdapter();
//   late CreateFinanceEntryUseCase _createEntryUseCase;
//
//   @override
//   void initState() {
//     super.initState();
//     _createEntryUseCase = CreateFinanceEntryCommand();
//   }
//
//   void _showAddEntryDialog() {
//     showDialog(
//       context: context,
//       builder: (context) {
//         String description = '';
//         double amount = 0;
//         String category = '';
//         TextEditingController dateController = TextEditingController();
//
//         return AlertDialog(
//           title: Center(child: Text('Nuevo Ingreso')),
//           content: Container(
//             width: MediaQuery.of(context).size.width * 0.8,
//             child: SingleChildScrollView(
//               child: Column(
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   TextField(
//                     controller: dateController,
//                     decoration: InputDecoration(
//                       labelText: 'Fecha',
//                       suffixIcon: Icon(Icons.calendar_today),
//                     ),
//                     onTap: () async {
//                       DateTime? pickedDate = await showDatePicker(
//                         context: context,
//                         initialDate: DateTime.now(),
//                         firstDate: DateTime(2000),
//                         lastDate: DateTime(2101),
//                       );
//                       if (pickedDate != null) {
//                         dateController.text = pickedDate.toString().split(' ')[0];
//                       }
//                     },
//                   ),
//                   SizedBox(height: 16.0),
//                   TextField(
//                     onChanged: (value) => amount = double.parse(value),
//                     keyboardType: TextInputType.numberWithOptions(decimal: true),
//                     decoration: InputDecoration(
//                       labelText: 'Monto',
//                     ),
//                   ),
//                   SizedBox(height: 16.0),
//                   Stack(
//                     children: [
//                       TextField(
//                         decoration: InputDecoration(
//                           labelText: 'Categoría',
//                           contentPadding: EdgeInsets.only(right: 48),
//                         ),
//                       ),
//                       Positioned(
//                         right: 30,
//                         top: 15,
//                         child: Icon(Icons.search),
//                       ),
//                       Positioned(
//                         right: 0,
//                         top: 15,
//                         child: Icon(Icons.arrow_drop_down),
//                       ),
//                     ],
//                   ),
//                   SizedBox(height: 16.0),
//                   TextField(
//                     onChanged: (value) => description = value,
//                     decoration: InputDecoration(
//                       labelText: 'Descripción',
//                     ),
//                   ),
//                   SizedBox(height: 16.0),
//                   ElevatedButton(
//                     onPressed: () {
//                       // Implementar la lógica de adjuntar documento
//                     },
//                     child: Text('Adjuntar Documento'),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//           actions: [
//             Center(
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                 children: [
//                   TextButton(
//                     onPressed: () => Navigator.pop(context),
//                     child: Text('Cancelar'),
//                   ),
//                   TextButton(
//                     onPressed: () {
//                       final entry = FinanceEntry(
//                         description: description,
//                         amount: amount,
//                         date: DateTime.now(),
//                         type: EntryType.income,
//                       );
//                       final aggregate = FinanceEntryAggregate(entries: []);
//                       _createEntryUseCase.execute(aggregate, entry);
//                       Navigator.pop(context);
//                     },
//                     child: Text('Agregar'),
//                   ),
//                 ],
//               ),
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
//       body: StreamBuilder<List<FinanceEntry>>(
//         stream: _repository.getEntries(),
//         builder: (context, snapshot) {
//           if (snapshot.hasData) {
//             return ListView.builder(
//               itemCount: snapshot.data!.length,
//               itemBuilder: (context, index) {
//                 final entry = snapshot.data![index];
//                 return ListTile(
//                   title: Text(entry.description),
//                   subtitle: Text('${entry.amount} (${entry.type == EntryType.income ? 'Ingreso' : 'Egreso'})'),
//                 );
//               },
//             );
//           } else {
//             return Center(child: CircularProgressIndicator());
//           }
//         },
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () => _showAddEntryDialog(),
//         child: Icon(Icons.add),
//       ),
//     );
//   }
// }


import 'package:flutter/material.dart';
import '../../application/use_cases/income_use_case.dart';
import '../../domain/aggregates/income_aggregate.dart';
import '../../domain/entities/income_entry_entity.dart';

class IncomePage extends StatefulWidget {
  final CreateIncomeEntryUseCase createEntryUseCase;
  final UpdateIncomeEntryUseCase updateEntryUseCase;
  final GetIncomeEntriesUseCase getEntriesUseCase;
  final IncomeEntryAggregate aggregate;
  final List<String> categories; // Cambié a List<String> por simplicidad

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

  void _addEntry() async {
    final description = _descriptionController.text;
    final amount = double.tryParse(_amountController.text) ?? 0.0;
    final category = _categoryController.text;

    if (description.isNotEmpty && amount > 0 && category.isNotEmpty) {
      final entry = IncomeEntry(
        description: description,
        amount: amount,
        date: DateTime.now(),
        category: category,
      );
      await widget.createEntryUseCase.execute(widget.aggregate, entry);
      _loadEntries();
      _clearFields();
    }
  }

  void _clearFields() {
    _descriptionController.clear();
    _amountController.clear();
    _categoryController.clear();
  }

  void _showAddEntryDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Center(child: Text('Nuevo Ingreso')),
          content: Container(
            width: MediaQuery.of(context).size.width * 0.8,
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: _descriptionController,
                    decoration: InputDecoration(labelText: 'Descripción'),
                  ),
                  SizedBox(height: 16.0),
                  TextField(
                    controller: _amountController,
                    keyboardType: TextInputType.numberWithOptions(decimal: true),
                    decoration: InputDecoration(labelText: 'Monto'),
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
                      _addEntry();
                      Navigator.pop(context);
                    },
                    child: Text('Agregar'),
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
                return ListTile(
                  title: Text(entry.description),
                  subtitle: Text('${entry.amount} (${entry.category})'),
                  onTap: () {
                    // Implementar lógica de edición si es necesario
                  },
                );
              },
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddEntryDialog,
        child: Icon(Icons.add),
      ),
    );
  }
}

