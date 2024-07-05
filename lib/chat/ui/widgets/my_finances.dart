import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../finances/ui/myFinancesPages/my_finance_page.dart';


class MyFinancesTile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(Icons.account_circle_outlined),
      title: Text('Mis finanzas'),
      onTap: () {
        Navigator.pushNamed(context, '/my-finances');
      },
    );
  }
}

