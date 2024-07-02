import 'package:flutter/material.dart';

import '../../../../../../shared/currencies/domain/entities/currency_entity.dart';

class CurrencySelectionDialog extends StatelessWidget {
  final List<Currency> currencies;
  final Function(String) onSelected;

  CurrencySelectionDialog({
    required this.currencies,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Seleccionar Moneda'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: currencies.map((currency) {
          return ListTile(
            title: Text(currency.name),
            onTap: () {
              onSelected(currency.code);
              Navigator.pop(context);
            },
          );
        }).toList(),
      ),
    );
  }
}