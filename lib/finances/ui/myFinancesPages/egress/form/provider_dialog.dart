import 'package:flutter/material.dart';

class ProviderDialogCreate extends StatelessWidget {
  final Function(String, String, String) onCreate;

  ProviderDialogCreate({required this.onCreate});

  @override
  Widget build(BuildContext context) {
    TextEditingController newProviderController = TextEditingController();
    TextEditingController phoneNumberController = TextEditingController();
    TextEditingController rucController = TextEditingController();

    return AlertDialog(
      title: Text('Crear Proveedor'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: newProviderController,
              decoration: InputDecoration(labelText: 'Nombre del proveedor'),
            ),
            TextField(
              controller: phoneNumberController,
              decoration: InputDecoration(labelText: 'Teléfono'),
            ),
            TextField(
              controller: rucController,
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
              newProviderController.text,
              phoneNumberController.text,
              rucController.text,
            );
            Navigator.pop(context);
          },
          child: Text('Crear'),
        ),
      ],
    );
  }
}