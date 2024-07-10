// import 'package:flutter/material.dart';
// import '../../../chat/ui/pages/expense_manager_page.dart';
// import '../../../settings/ui/mySettings/settings_page.dart';
// import '../../../shared/providers/application/use_cases/create_provider_use_case.dart';
// import '../../../shared/providers/application/use_cases/delete_provider_use_case.dart';
// import '../../../shared/providers/application/use_cases/get_providers_use_case.dart';
// import '../../../shared/providers/application/use_cases/provider_use_case.dart';
// import '../../../shared/providers/application/use_cases/update_provider_use_case.dart';
// import '../../../shared/providers/domain/aggregates/provider_aggregate.dart';
// import '../../../shared/ui/navigation_bar_page.dart';
// import '../../application/use_cases/handler/command/create_register_command.dart';
// import '../../application/use_cases/handler/queries/get_register_query.dart';
// import '../../domain/aggregates/register_aggregate.dart';
// import '../../domain/entities/register_entity.dart';
// import '../../infrastructure/adapters/register_adapter.dart'; // Asegúrate de importar el archivo adecuado si se requiere
//
// // Importa otros archivos necesarios según sea necesario
//
// class RegisterPage extends StatelessWidget {
//   // final RegisterSQLiteAdapter registerAdapter = RegisterSQLiteAdapter();
//   late final GetRegistersQuery getRegisters;
//   late final CreateRegisterCommand addRegister;
//   // final RegisterAggregate registerAggregate = RegisterAggregate(registers: []);
//
//   RegisterPage() {
//     // getRegisters = GetRegistersQuery(registerAdapter);
//     // addRegister = CreateRegisterCommand(registerAdapter);
//   }
//
//   int _selectedIndex = 1; // Asumiendo que este es el índice para RegisterPage en el BottomNavigationBar
//
//   // void _onItemTapped(
//   //     int index,
//   //     BuildContext context,
//   //     CreateProviderUseCase createProviderUseCase,
//   //     UpdateProviderUseCase updateProviderUseCase,
//   //     DeleteProviderUseCase deleteProviderUseCase,
//   //     GetProvidersUseCase getProvidersUseCase,
//   //     ProviderAggregate aggregate) {
//   //   if (index == 0) {
//   //     // Navegación a la página de Chats o la página deseada
//   //     Navigator.push(
//   //       context,
//   //       MaterialPageRoute(builder: (context) => ExpenseManagerPage()),
//   //     );
//   //   } else if (index == 2) {
//   //     // Navegación a la página de Ajustes o la página deseada
//   //     Navigator.push(
//   //       context,
//   //       MaterialPageRoute(
//   //         builder: (context) => SettingsPage(
//   //           // createProviderUseCase: createProviderUseCase,
//   //           // updateProviderUseCase: updateProviderUseCase,
//   //           // deleteProviderUseCase: deleteProviderUseCase,
//   //           // getProvidersUseCase: getProvidersUseCase,
//   //           // aggregate: aggregate,
//   //         ),
//   //       ),
//   //     );
//   //   }
//   //   // Puedes agregar más condiciones según tus necesidades para otros ítems del BottomNavigationBar
//   // }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Graficos'),
//         backgroundColor: Colors.teal,
//         actions: [
//           IconButton(icon: Icon(Icons.calendar_today), onPressed: () {}),
//           IconButton(icon: Icon(Icons.camera_alt), onPressed: () {}),
//         ],
//       ),
//       body: FutureBuilder<List<Register>>(
//         future: getRegisters.execute(registerAggregate),
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return Center(child: CircularProgressIndicator());
//           } else if (snapshot.hasError) {
//             return Center(child: Text('Error: ${snapshot.error}'));
//           } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
//             return Center(child: Text('No registers found.'));
//           } else {
//             return ListView.builder(
//               itemCount: snapshot.data!.length,
//               itemBuilder: (context, index) {
//                 final register = snapshot.data![index];
//                 return ListTile(
//                   title: Text(register.type),
//                   subtitle: Text(register.amount.toString()),
//                   trailing: Text(register.date.toIso8601String()),
//                 );
//               },
//             );
//           }
//         },
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () async {
//           final newRegister = Register(
//             id: 'some-unique-id',
//             type: 'Ingreso',
//             amount: 100.0,
//             date: DateTime.now(),
//           );
//           await addRegister.execute(registerAggregate, newRegister);
//         },
//         child: Icon(Icons.add),
//       ),
//     );
//   }
// }
//
//

import 'package:flutter/material.dart';

class RegisterPage extends StatelessWidget {
  // int _selectedIndex = 1; // Assuming this is the index for RegisterPage in the BottomNavigationBar
  //
  // void _onItemTapped(int index, BuildContext context) {
  //   if (index == 0) {
  //     // Navigation to the desired page
  //     Navigator.push(
  //       context,
  //       MaterialPageRoute(builder: (context) => ExpenseManagerPage()),
  //     );
  //   } else if (index == 2) {
  //     // Navigation to the desired page
  //     Navigator.push(
  //       context,
  //       MaterialPageRoute(builder: (context) => SettingsPage()),
  //     );
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Graficos'),
        backgroundColor: Colors.teal,
        actions: [
          IconButton(icon: Icon(Icons.calendar_today), onPressed: () {}),
          IconButton(icon: Icon(Icons.camera_alt), onPressed: () {}),
        ],
      ),
      body: Center(
        child: Text('No registers found.'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Action for the add button
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
