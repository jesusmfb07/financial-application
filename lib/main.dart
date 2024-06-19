// import 'package:exercises_flutter2/shared/ui/navigation_bar_page.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'chat/infrastructure/adapters/contact_adapter.dart';
// import 'chat/ui/pages/expense_manager_page.dart';
// import 'myFinances/infrastructure/adapters/finance_entry_adapter.dart';
// import 'myFinances/ui/myFinancesPages/my_finance_page.dart';
//
// void main() {
//   runApp(MyApp());
// }
//
//
// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MultiProvider(
//       providers: [
//         // Provider(create: (_) => ContactAdapter()),
//         Provider(create: (_) => FinanceEntryAdapter()), // Agregar el proveedor FinanceEntryAdapter
//       ],
//       child: MaterialApp(
//         title: 'Gestor de Gastos',
//         theme: ThemeData(
//           primarySwatch: Colors.blue,
//         ),
//         initialRoute: '/', // Agregamos la ruta inicial
//         routes: {
//           '/': (context) => ExpenseManagerPage(), // Ruta inicial (ExpenseManagerPage)
//             '/my-finances': (context) => MyFinancesPage(), // Ruta para la página MyFinancesPage
//         },
//       ),
//     );
//   }
// }


// import 'package:exercises_flutter2/shared/ui/navigation_logic.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'chat/infrastructure/adapters/contact_adapter.dart';
// import 'myFinances/infrastructure/adapters/finance_entry_adapter.dart';
// import 'package:exercises_flutter2/shared/ui/navigation_bar_page.dart';
// import 'navigation_logic.dart';
//
// void main() {
//   runApp(MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MultiProvider(
//       providers: [
//         // Provider(create: (_) => ContactAdapter()),
//         Provider(create: (_) => FinanceEntryAdapter()), // Agregar el proveedor FinanceEntryAdapter
//       ],
//       child: MaterialApp(
//         title: 'Gestor de Gastos',
//         theme: ThemeData(
//           primarySwatch: Colors.blue,
//         ),
//         home: CustomBottomNavigationBar(), // Usa CustomBottomNavigationBar como el home
//       ),
//     );
//   }
// }
//
// class CustomBottomNavigationBar extends StatefulWidget {
//   @override
//   _CustomBottomNavigationBarState createState() => _CustomBottomNavigationBarState();
// }
//
// class _CustomBottomNavigationBarState extends State<CustomBottomNavigationBar> {
//   int _currentIndex = 0;
//
//   void _onTap(int index) {
//     setState(() {
//       _currentIndex = index;
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: NavigationLogic.getPageForIndex(_currentIndex),
//       bottomNavigationBar: CustomBottomNavigationBar(
//         currentIndex: _currentIndex,
//         onTap: _onTap,
//       ),
//     );
//   }
// }
//
// class CustomBottomNavigationBar extends StatelessWidget {
//   final int currentIndex;
//   final Function(int) onTap;
//
//   CustomBottomNavigationBar({required this.currentIndex, required this.onTap});
//
//   @override
//   Widget build(BuildContext context) {
//     return BottomNavigationBar(
//       type: BottomNavigationBarType.fixed,
//       currentIndex: currentIndex,
//       onTap: onTap,
//       items: const [
//         BottomNavigationBarItem(
//           icon: Icon(Icons.chat_bubble_outline_rounded),
//           label: 'Chats',
//         ),
//         BottomNavigationBarItem(
//           icon: Icon(Icons.insert_chart),
//           label: 'Reportes',
//         ),
//         BottomNavigationBarItem(
//           icon: Icon(Icons.calendar_today),
//           label: 'Calendario',
//         ),
//         BottomNavigationBarItem(
//           icon: Icon(Icons.settings),
//           label: 'Ajustes',
//         ),
//       ],
//     );
//   }
// }



// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'chat/infrastructure/adapters/contact_adapter.dart';
// import 'myFinances/infrastructure/adapters/finance_entry_adapter.dart';
// import 'myFinances/ui/myFinancesPages/my_finance_page.dart';
//
//
// void main() {
//   runApp(MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MultiProvider(
//       providers: [
//         // Provider(create: (_) => ContactAdapter()),
//         Provider(create: (_) => FinanceEntryAdapter()), // Agregar el proveedor FinanceEntryAdapter
//       ],
//       child: MaterialApp(
//         title: 'Gestor de Gastos',
//         theme: ThemeData(
//           primarySwatch: Colors.blue,
//         ),
//         home: CustomBottomNavigationBar(), // Usa CustomBottomNavigationBar como el home
//       ),
//     );
//   }
// }
//
// class CustomBottomNavigationBar extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: CustomBottomNavigationBarPage(), // Usa la lógica de navegación aquí
//       bottomNavigationBar: BottomNavigationBar(
//         type: BottomNavigationBarType.fixed,
//         currentIndex: 0, // Puedes establecer el índice inicial aquí
//         onTap: (index) {
//           // Implementa la lógica para cambiar el índice seleccionado
//         },
//         items: const [
//           BottomNavigationBarItem(
//             icon: Icon(Icons.chat_bubble_outline_rounded),
//             label: 'Chats',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.insert_chart),
//             label: 'Reportes',
//           ),
//         ],
//       ),
//     );
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'chat/infrastructure/adapters/contact_adapter.dart';
// import 'chat/ui/pages/expense_manager_page.dart';
// import 'myFinances/infrastructure/adapters/finance_entry_adapter.dart';
// import 'myFinances/ui/myFinancesPages/my_finance_page.dart';
// // Asegúrate de que la importación sea correcta
//
// void main() {
//   runApp(MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MultiProvider(
//       providers: [
//         // Provider(create: (_) => ContactAdapter()),
//         Provider(create: (_) => FinanceEntryAdapter()), // Agregar el proveedor FinanceEntryAdapter
//       ],
//       child: MaterialApp(
//         title: 'Gestor de Gastos',
//         theme: ThemeData(
//           primarySwatch: Colors.blue,
//         ),
//         home: CustomBottomNavigationBar(), // Usa CustomBottomNavigationBar como el home
//       ),
//     );
//   }
// }
//
// class CustomBottomNavigationBar extends StatefulWidget {
//   final int currentIndex;
//   final Function(int) onTap;
//
//   CustomBottomNavigationBar({
//     required this.currentIndex,
//     required this.onTap,
//   });
//
//   @override
//   _CustomBottomNavigationBarState createState() => _CustomBottomNavigationBarState();
// }
//
// class _CustomBottomNavigationBarState extends State<CustomBottomNavigationBar> {
//   @override
//   Widget build(BuildContext context) {
//     return BottomNavigationBar(
//       currentIndex: widget.currentIndex,
//       onTap: widget.onTap,
//       items: [
//         BottomNavigationBarItem(
//           icon: Icon(Icons.home),
//           label: 'Home',
//         ),
//         BottomNavigationBarItem(
//           icon: Icon(Icons.account_balance_wallet),
//           label: 'Wallet',
//         ),
//         // Agrega más items según sea necesario
//       ],
//     );
//   }
// }



import 'package:flutter/material.dart';
import 'myFinances/ui/myFinancesPages/my_finance_page.dart';
import 'shared/ui/navigation_bar_page.dart'; // Asegúrate de importar correctamente

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Gestor de Gastos',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/', // Agregamos la ruta inicial
      routes: {
        '/': (context) => MyFinancesPage(), // Ruta inicial (MyFinancesPage)
        '/my-finances': (context) => MyFinancesPage(), // Ruta para la página MyFinancesPage
      },
      home: CustomBottomNavigationBar(currentIndex: 0, onTap: (int ) { },), // Usa CustomBottomNavigationBar como el home
    );
  }
}


