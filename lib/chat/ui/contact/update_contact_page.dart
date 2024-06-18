import 'package:flutter/material.dart';
import 'package:exercises_flutter2/chat/application/use_cases/handler/command/contact/update_contact_command.dart';
import '../../domain/entities/contact.entity.dart';
import '../../infrastructure/adapters/database_adapter.dart';
import 'contact_form.dart';
import 'contact_styles.dart';

class UpdateContactPage extends StatefulWidget {
  final Contact contact;

  UpdateContactPage({required this.contact});

  @override
  _UpdateContactPageState createState() => _UpdateContactPageState();
}

class _UpdateContactPageState extends State<UpdateContactPage> {
  late TextEditingController _nameController;
  late TextEditingController _lastNameController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.contact.name);
    _lastNameController = TextEditingController(text: widget.contact.lastName);
  }

  void _updateContact() async {
    final name = _nameController.text;
    final lastName = _lastNameController.text;

    if (name.isNotEmpty && lastName.isNotEmpty) {
      final updatedContact = Contact(widget.contact.id, name, lastName);
      final contactPort = DatabaseAdapter();
      final updateCommand = UpdateContactCommand(contactPort);

      await updateCommand.execute(updatedContact);
      Navigator.pop(context);
    } else {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Error', style: ContactStyles.titleTextStyle),
          content: Text('Por favor, complete todos los campos.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('OK', style: ContactStyles.buttonTextStyle),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Actualizar Contacto', style: ContactStyles.titleTextStyle),
      ),
      body: ContactForm(
        nameController: _nameController,
        lastNameController: _lastNameController,
        onSubmit: _updateContact,
        submitButtonText: 'Actualizar Contacto', // Text specific to update
      ),
    );
  }
}