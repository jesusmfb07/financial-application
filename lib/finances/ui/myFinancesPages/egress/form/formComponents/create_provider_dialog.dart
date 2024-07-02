import 'package:flutter/material.dart';

class CreateProviderDialog extends StatelessWidget {
  final Function(String, String?, String?) onCreate;

  CreateProviderDialog({required this.onCreate});

  @override
  Widget build(BuildContext context) {
    TextEditingController _newProviderController = TextEditingController();
    TextEditingController _phoneNumberController = TextEditingController();
    TextEditingController _rucController = TextEditingController();

    return AlertDialog(
      title: Text('Crear Proveedor'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _newProviderController,
              decoration: InputDecoration(labelText: 'Nombre del proveedor'),
            ),
            TextField(
              controller: _phoneNumberController,
              decoration: InputDecoration(labelText: 'Teléfono'),
            ),
            TextField(
              controller: _rucController,
              decoration: InputDecoration(labelText: 'RUC'),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text('Cancelar'),
        ),
        TextButton(
          onPressed: () {
            onCreate(
              _newProviderController.text,
              _phoneNumberController.text,
              _rucController.text,
            );
            Navigator.pop(context);
          },
          child: Text('Crear'),
        ),
      ],
    );
  }
}
