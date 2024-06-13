import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyFinancesTile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(Icons.account_circle_outlined),
      title: Text('Mis finanzas'),
      onTap: () {
        // Implement logic for tapping on "My Finances"
      },
    );
  }
}
