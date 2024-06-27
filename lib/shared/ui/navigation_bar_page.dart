import 'package:flutter/material.dart';
import '../../register/ui/myRegister/register_page.dart';
import '../../chat/ui/pages/expense_manager_page.dart';
import '../../settings/ui/mySettings/settings_page.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  CustomBottomNavigationBar({required this.currentIndex, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      currentIndex: currentIndex,
      onTap: (index) {
        onTap(index);
        if (index == 3) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => SettingsPage()),
          );
        } else if (index == 0) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ExpenseManagerPage()),
          );
        } else if (index == 1) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => RegisterPage()),
          );
        }
      },
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.chat_bubble_outline_rounded),
          label: 'Chats',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.insert_chart),
          label: 'Registro',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.calendar_today),
          label: 'Calendario',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.settings),
          label: 'Ajustes',
        ),
      ],
    );
  }
}
