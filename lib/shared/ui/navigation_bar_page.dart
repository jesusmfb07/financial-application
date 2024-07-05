// import 'package:flutter/material.dart';
// import '../../chat/ui/widgets/my_finances.dart';
// import '../../finances/ui/myFinancesPages/my_finance_page.dart';
// import '../../register/ui/myRegister/register_page.dart';
// import '../../chat/ui/pages/expense_manager_page.dart';
// import '../../settings/ui/mySettings/settings_page.dart';
//
// class HomePage extends StatefulWidget {
//   HomePage();
//
//   @override
//   _HomePageState createState() => _HomePageState();
// }
//
// class _HomePageState extends State<HomePage> {
//   int _currentIndex = 0;
//   final PageController _pageController = PageController();
//
//   void _onItemTapped(int index) {
//     setState(() {
//       _currentIndex = index;
//     });
//     _pageController.jumpToPage(index);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: PageView(
//         controller: _pageController,
//         onPageChanged: (index) {
//           setState(() {
//             _currentIndex = index;
//           });
//         },
//         children: [
//           ExpenseManagerPage(),
//           RegisterPage(),
//           Center(child: Text('Calendario')), // Reemplaza con tu página de Calendario
//           SettingsPage(), // Asegúrate de que SettingsPage está correctamente definida
//         ],
//       ),
//       bottomNavigationBar: BottomNavigationBar(
//         type: BottomNavigationBarType.fixed,
//         currentIndex: _currentIndex,
//         onTap: _onItemTapped,
//         items: const [
//           BottomNavigationBarItem(
//             icon: Icon(Icons.chat_bubble_outline_rounded),
//             label: 'Chats',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.insert_chart),
//             label: 'Registro',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.calendar_today),
//             label: 'Calendario',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.settings),
//             label: 'Ajustes',
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../chat/ui/pages/expense_manager_page.dart';
import '../../finances/ui/myFinancesPages/my_finance_page.dart';
import '../../register/ui/myRegister/register_page.dart';
import '../../settings/ui/mySettings/settings_page.dart';

class HomePage extends StatefulWidget {
  HomePage();

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;
  final PageController _pageController = PageController();

  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
    _pageController.jumpToPage(index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        onPageChanged: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        children: [
          Navigator(
            onGenerateRoute: (settings) {
              Widget page;
              switch (settings.name) {
                case '/my-finances':
                  page = MyFinancesPage();
                  break;
                default:
                  page = ExpenseManagerPage();
              }
              return MaterialPageRoute(builder: (_) => page);
            },
          ),
          RegisterPage(),
          Center(child: Text('Calendario')),
          SettingsPage(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _currentIndex,
        onTap: _onItemTapped,
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
      ),
    );
  }
}
