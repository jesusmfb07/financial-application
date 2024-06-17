// import 'package:flutter/material.dart';
// import '../../application/use_cases/handler/queries/create_contact_query.dart';
// import '../../domain/entities/contact.entity.dart';
// import '../../infrastructure/adapters/database_adapter.dart';
// import '../../domain/aggregates/contact_aggregate.dart';
//
// class CreateContactPage extends StatefulWidget {
//   @override
//   _CreateContactPageState createState() => _CreateContactPageState();
// }
//
// class _CreateContactPageState extends State<CreateContactPage> {
//   final _nameController = TextEditingController();
//   final _lastNameController = TextEditingController();
//
//   void _createContact() async {
//     final name = _nameController.text;
//     final lastName = _lastNameController.text;
//
//     if (name.isNotEmpty && lastName.isNotEmpty) {
//       final contact = Contact(name, lastName);
//       final contactPort = DatabaseAdapter();
//       final createContactUseCase = CreateContactQuery(contactPort);
//
//       final aggregate = ContactAggregate(contacts: [contact]);
//       await createContactUseCase.execute(aggregate,contact);
//       Navigator.pop(context);
//     } else {
//       // Manejar el caso cuando los campos están vacíos
//       showDialog(
//         context: context,
//         builder: (context) => AlertDialog(
//           title: Text('Error'),
//           content: Text('Por favor, complete todos los campos.'),
//           actions: [
//             TextButton(
//               onPressed: () => Navigator.pop(context),
//               child: Text('OK'),
//             ),
//           ],
//         ),
//       );
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Crear Contacto'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             TextField(
//               controller: _nameController,
//               decoration: InputDecoration(labelText: 'Nombre'),
//             ),
//             TextField(
//               controller: _lastNameController,
//               decoration: InputDecoration(labelText: 'Apellido'),
//             ),
//             SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: _createContact,
//               child: Text('Crear Contacto'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
