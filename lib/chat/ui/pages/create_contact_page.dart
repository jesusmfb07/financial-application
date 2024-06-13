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
