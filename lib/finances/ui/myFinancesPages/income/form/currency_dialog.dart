import 'package:flutter/material.dart';
import '../../../../../shared/currencies/domain/entities/currency_entity.dart';

class CurrencyDialog extends StatelessWidget {
  final List<Currency> availableCurrencies;
  final Function(Currency) onSelected;

  CurrencyDialog({required this.availableCurrencies, required this.onSelected});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Seleccionar Moneda'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: availableCurrencies.map((currency) {
            return ListTile(
              title: Text(currency.name),
              onTap: () {
                onSelected(currency);
              },
            );
          }).toList(),
        ),
      ),
    );
  }
}
