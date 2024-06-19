import 'package:flutter/material.dart';
import '../../application/use_cases/finances_entries_usecase.dart';
import '../../application/use_cases/handler/command/create_finance_entry_command.dart';
import '../../domain/aggregates/finance_entry.aggregate.dart';
import '../../domain/entities/finance_entry.entity.dart';
import '../../infrastructure/adapters/finance_entry_adapter.dart';

class EgressPage extends StatefulWidget {
  @override
  _EgressPageState createState() => _EgressPageState();
}

class _EgressPageState extends State<EgressPage> {
  final _repository = FinanceEntryAdapter();
  late CreateFinanceEntryUseCase _createEntryUseCase;

  @override
  void initState() {
    super.initState();
    _createEntryUseCase = CreateFinanceEntryCommand();
  }

  void _showAddEntryDialog() {
    showDialog(
      context: context,
      builder: (context) {
        String description = '';
        double amount = 0;
        String category = '';
        String provider = '';
        TextEditingController dateController = TextEditingController();

        return AlertDialog(
          title: Center(child: Text('Nuevo Egreso')),
          content: Container(
            width: MediaQuery.of(context).size.width * 0.8,
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: dateController,
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
                        dateController.text = pickedDate.toString().split(' ')[0];
                      }
                    },
                  ),
                  SizedBox(height: 16.0),
                  TextField(
                    onChanged: (value) => amount = double.parse(value),
                    keyboardType: TextInputType.numberWithOptions(decimal: true),
                    decoration: InputDecoration(
                      labelText: 'Monto',
                    ),
                  ),
                  SizedBox(height: 16.0),
                  Stack(
                    children: [
                      TextField(
                        decoration: InputDecoration(
                          labelText: 'Categoría',
                          contentPadding: EdgeInsets.only(right: 48),
                        ),
                      ),
                      Positioned(
                        right: 30,
                        top: 15,
                        child: Icon(Icons.search),
                      ),
                      Positioned(
                        right: 0,
                        top: 15,
                        child: Icon(Icons.arrow_drop_down),
                      ),
                    ],
                  ),
                  SizedBox(height: 16.0),
                  Stack(
                    children: [
                      TextField(
                        decoration: InputDecoration(
                          labelText: 'Proveedor',
                          contentPadding: EdgeInsets.only(right: 48),
                        ),
                      ),
                      Positioned(
                        right: 30,
                        top: 15,
                        child: Icon(Icons.search),
                      ),
                      Positioned(
                        right: 0,
                        top: 15,
                        child: Icon(Icons.arrow_drop_down),
                      ),
                    ],
                  ),
                  SizedBox(height: 16.0),
                  TextField(
                    onChanged: (value) => description = value,
                    decoration: InputDecoration(
                      labelText: 'Descripción',
                    ),
                  ),
                  SizedBox(height: 16.0),
                  ElevatedButton(
                    onPressed: () {
                      // Implementar la lógica de adjuntar documento
                    },
                    child: Text('Adjuntar Documento'),
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
                      final entry = FinanceEntry(
                        description: description,
                        amount: amount,
                        date: DateTime.now(),
                        type: EntryType.expense,
                      );
                      final aggregate = FinanceEntryAggregate(entries: []);
                      _createEntryUseCase.execute(aggregate, entry);
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
      body: StreamBuilder<List<FinanceEntry>>(
        stream: _repository.getEntries(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final entry = snapshot.data![index];
                return ListTile(
                  title: Text(entry.description),
                  subtitle: Text('${entry.amount} (${entry.type == EntryType.expense ? 'Egreso' : 'Ingreso'})'),
                );
              },
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddEntryDialog(),
        child: Icon(Icons.add),
      ),
    );
  }
}
