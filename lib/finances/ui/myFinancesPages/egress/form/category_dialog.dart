import 'package:flutter/material.dart';

class CategoryDialogEgress extends StatelessWidget {
  final Function(String) onCreate;

  CategoryDialogEgress({required this.onCreate});

  @override
  Widget build(BuildContext context) {
    TextEditingController _newCategoryController = TextEditingController();

    return AlertDialog(
      title: Text('Crear Categoría'),
      content: TextField(
        controller: _newCategoryController,
        decoration: InputDecoration(labelText: 'Nombre de la categoría'),
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
            onCreate(_newCategoryController.text);
            Navigator.pop(context);
          },
          child: Text('Crear'),
        ),
      ],
    );
  }
}
