// import 'package:flutter/material.dart';
// import '../../application/use_case/create_contact_handler.dart';
// import '../../application/use_case/handler/command/create_contact_command.dart';
// import '../../infrastructure/adapters/chat_adapter.dart';
// import 'package:provider/provider.dart';
//
// class CreateContactPage extends StatefulWidget {
//   @override
//   _CreateContactPageState createState() => _CreateContactPageState();
// }
//
// class _CreateContactPageState extends State<CreateContactPage> {
//   final _formKey = GlobalKey<FormState>();
//   final _nameController = TextEditingController();
//   final _lastNameController = TextEditingController();
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//           title: Text('Nuevo Contacto'),
//         ),
//         body: Padding(
//         padding: EdgeInsets.all(16.0),
//     child: Form(
//     key: _formKey,
//     child: Column(
//     children: [
//     TextFormField(
//     controller: _nameController,
//     decoration: InputDecoration(
//     labelText: 'Nombre',
//     ),
//     ),
//     SizedBox(height: 16.0),
//     TextFormField(
//     controller: _lastNameController,
//     decoration: InputDecoration(
//     labelText: 'Apellido',
//     ),
//     ),
//     SizedBox(height: 32.0),
//       ElevatedButton(
//         onPressed: () {
//           if (_formKey.currentState!.validate()) {
//             final name = _nameController.text;
//             final lastName = _lastNameController.text;
//             final createContactCommand = CreateContactCommand(name, lastName);
//             final createContactHandler = CreateContactHandler(
//               context.read<ChatAdapter>(),
//             );
//             createContactHandler.handle(createContactCommand);
//             Navigator.pop(context);
//           }
//         },
//         child: Text('Crear Contacto'),
//       ),
//     ],
//     ),
//     ),
//         ),
//
//     );
//   }
// }

// import 'package:flutter/material.dart';
// import '../../domain/entities/contact.dart';
// import '../../application/use_cases/add_contact.dart';
// import '../../infrastructure/adapters/contact_adapter.dart';
//
// class CreateContactPage extends StatefulWidget {
//   @override
//   _CreateContactPageState createState() => _CreateContactPageState();
// }
//
// class _CreateContactPageState extends State<CreateContactPage> {
//   final _formKey = GlobalKey<FormState>();
//   final _contactRepository = ContactRepositoryImpl();
//   late final _addContact = AddContact(_contactRepository);
//   String? name;
//   String? last_name;
//
//   void _saveContact() {
//     if (_formKey.currentState?.validate() ?? false) {
//       _formKey.currentState?.save();
//       final newContact = Contact(0, name!, last_name!);
//       _addContact.execute(newContact);
//       Navigator.of(context).pop();
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Añadir Contacto'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Form(
//           key: _formKey,
//           child: Column(
//             children: [
//               TextFormField(
//                 decoration: InputDecoration(labelText: 'Nombre'),
//                 onSaved: (value) => name = value,
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Por favor ingrese un nombre';
//                   }
//                   return null;
//                 },
//               ),
//               TextFormField(
//                 decoration: InputDecoration(labelText: 'Apellidos'),
//                 onSaved: (value) => last_name = value,
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Por favor ingrese un email';
//                   }
//                   return null;
//                 },
//               ),
//               SizedBox(height: 20),
//               ElevatedButton(
//                 onPressed: _saveContact,
//                 child: Text('Añadir'),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// lib/ui/pages/create_contact_page.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../application/use_cases/handler/command/create_contact_command.dart';
import '../../application/use_cases/handler/create_contact_handler.dart';
import '../../infrastructure/adapters/chat_adapter.dart';

class CreateContactPage extends StatefulWidget {
  @override
  _CreateContactPageState createState() => _CreateContactPageState();
}

class _CreateContactPageState extends State<CreateContactPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _lastNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Nuevo Contacto'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: 'Nombre',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese un nombre';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16.0),
              TextFormField(
                controller: _lastNameController,
                decoration: InputDecoration(
                  labelText: 'Apellido',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese un apellido';
                  }
                  return null;
                },
              ),
              SizedBox(height: 32.0),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    final name = _nameController.text;
                    final lastName = _lastNameController.text;
                    final createContactCommand = CreateContactCommand(name, lastName);
                    final createContactHandler = CreateContactHandler(
                      context.read<ChatAdapter>(),
                    );
                    createContactHandler.handle(createContactCommand);
                    Navigator.pop(context);
                  }
                },
                child: Text('Crear Contacto'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
