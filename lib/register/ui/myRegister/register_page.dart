import 'package:flutter/material.dart';
import '../../../shared/ui/navigation_bar_page.dart';
import '../../application/use_cases/handler/command/create_register_command.dart';
import '../../application/use_cases/handler/queries/get_register_query.dart';
import '../../domain/entities/register_entity.dart';
import '../../domain/aggregates/register_aggregate.dart';
import '../../infrastructure/adapters/register_adapter.dart';

class RegisterPage extends StatelessWidget {
  final RegisterSQLiteAdapter registerAdapter = RegisterSQLiteAdapter();
  late final GetRegistersQuery getRegisters;
  late final CreateRegisterCommand addRegister;
  final RegisterAggregate registerAggregate = RegisterAggregate(registers: []);

  RegisterPage() {
    getRegisters = GetRegistersQuery(registerAdapter);
    addRegister = CreateRegisterCommand(registerAdapter);
  }

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
        future: getRegisters.execute(registerAggregate),
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
          await addRegister.execute(registerAggregate, newRegister);
        },
        child: Icon(Icons.add),
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
        currentIndex: 1, // Assuming this is the index for the RegisterPage
        onTap: (index) {
          // Define your onTap logic here if necessary
        },
      ),
    );
  }
}
