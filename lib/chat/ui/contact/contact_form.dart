

// lib/ui/contact/contact_form.dart
import 'package:flutter/material.dart';
import 'contact_styles.dart';

class ContactForm extends StatelessWidget {
  final TextEditingController nameController;
  final TextEditingController lastNameController;
  final VoidCallback onSubmit;

  ContactForm({
    required this.nameController,
    required this.lastNameController,
    required this.onSubmit,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: ContactStyles.formPadding,
      child: Column(
        children: [
          TextField(
            controller: nameController,
            decoration: ContactStyles.inputDecoration.copyWith(labelText: 'Nombre'),
          ),
          SizedBox(height: 10),
          TextField(
            controller: lastNameController,
            decoration: ContactStyles.inputDecoration.copyWith(labelText: 'Apellido'),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: onSubmit,
            child: Text('Crear Contacto', style: ContactStyles.buttonTextStyle),
          ),
        ],
      ),
    );
  }
}
