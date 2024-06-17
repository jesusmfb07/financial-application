// lib/ui/contact/contact_page.dart
import 'package:flutter/material.dart';
import 'contact_form.dart';
import '../../application/use_cases/handler/queries/create_contact_query.dart';
import '../../domain/entities/contact.entity.dart';
import '../../infrastructure/adapters/database_adapter.dart';
import '../../domain/aggregates/contact_aggregate.dart';
import 'contact_styles.dart';

class CreateContactPage extends StatefulWidget {
  @override
  _CreateContactPageState createState() => _CreateContactPageState();
}

class _CreateContactPageState extends State<CreateContactPage> {
  final _nameController = TextEditingController();
  final _lastNameController = TextEditingController();

  void _createContact() async {
    final name = _nameController.text;
    final lastName = _lastNameController.text;

    if (name.isNotEmpty && lastName.isNotEmpty) {
      final contact = Contact(name, lastName);
      final contactPort = DatabaseAdapter();
      final createContactUseCase = CreateContactQuery(contactPort);

      final aggregate = ContactAggregate(contacts: [contact]);
      await createContactUseCase.execute(aggregate, contact);
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
        title: Text('Crear Contacto', style: ContactStyles.titleTextStyle),
      ),
      body: ContactForm(
        nameController: _nameController,
        lastNameController: _lastNameController,
        onSubmit: _createContact,
      ),
    );
  }
}
