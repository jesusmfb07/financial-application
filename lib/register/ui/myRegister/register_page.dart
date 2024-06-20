// ui/pages/register_page.dart
import 'package:flutter/material.dart';
import '../../application/use_cases/handler/command/create_register_command.dart';
import '../../application/use_cases/handler/queries/get_register_query.dart';
import '../../domain/entities/register_entity.dart';

class RegisterPage extends StatelessWidget {
  final GetRegistersQuery getRegisters = GetRegistersQuery(aggregate);
  final CreateRegisterCommand addRegister = CreateRegisterCommand();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Graficos'),
        backgroundColor: Color(0xFF20B2AA),
        actions: [
          IconButton(icon: Icon(Icons.calendar_today), onPressed: () {}),
          IconButton(icon: Icon(Icons.camera_alt), onPressed: () {}),
        ],
      ),
      body: FutureBuilder<List<Register>>(
        future: getRegisters.call(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No registers found.'));
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final register = snapshot.data![index];
                return ListTile(
                  title: Text(register.type),
                  subtitle: Text(register.amount.toString()),
                  trailing: Text(register.date.toIso8601String()),
                );
              },
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final newRegister = Register(
            id: 'some-unique-id',
            type: 'Ingreso',
            amount: 100.0,
            date: DateTime.now(),
          );
          await addRegister.call(newRegister);
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
