// import 'package:flutter/material.dart';
// import '../../../main.dart';
// import '../../../shared/ui/navigation_bar_page.dart';
// import 'income_page.dart';
// import 'egress_page.dart';
//
// class MyFinancesPage extends StatefulWidget {
//   @override
//   _MyFinancesPageState createState() => _MyFinancesPageState();
// }
//
// class _MyFinancesPageState extends State<MyFinancesPage> {
//   int _selectedIndex = 0;
//
//   void _onItemTapped(int index) {
//     setState(() {
//       _selectedIndex = index;
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Mis Finanzas'),
//         bottom: PreferredSize(
//           preferredSize: Size.fromHeight(48.0),
//           child: Padding(
//             padding: const EdgeInsets.symmetric(vertical: 8.0),
//             child: ToggleButtons(
//               borderRadius: BorderRadius.circular(8.0),
//               selectedBorderColor: Theme.of(context).colorScheme.primary,
//               selectedColor: Colors.white,
//               fillColor: Theme.of(context).colorScheme.primary,
//               children: [
//                 Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 50.0),
//                   child: Text('Ingreso'),
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 50.0),
//                   child: Text('Egreso'),
//                 ),
//               ],
//               isSelected: [
//                 _selectedIndex == 0,
//                 _selectedIndex == 1,
//               ],
//               onPressed: (index) {
//                 _onItemTapped(index);
//               },
//             ),
//           ),
//         ),
//       ),
//       body: _selectedIndex == 0 ? IncomePage() : EgressPage(),
//       bottomNavigationBar: CustomBottomNavigationBar(
//         currentIndex: _selectedIndex,
//         onTap: _onItemTapped,
//       ),
//     );
//   }
// }
//
import 'package:flutter/material.dart';
import '../../../shared/ui/navigation_bar_page.dart'; // Ajusta la ruta según sea necesario
import 'income_page.dart'; // Ajusta las importaciones según sea necesario
import 'egress_page.dart'; // Ajusta las importaciones según sea necesario
import '../../../main.dart'; // Ajusta la ruta según sea necesario

class MyFinancesPage extends StatefulWidget {
  @override
  _MyFinancesPageState createState() => _MyFinancesPageState();
}

class _MyFinancesPageState extends State<MyFinancesPage> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mis Finanzas'),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(48.0),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: ToggleButtons(
              borderRadius: BorderRadius.circular(8.0),
              selectedBorderColor: Theme.of(context).colorScheme.primary,
              selectedColor: Colors.white,
              fillColor: Theme.of(context).colorScheme.primary,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 50.0),
                  child: Text('Ingreso'),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 50.0),
                  child: Text('Egreso'),
                ),
              ],
              isSelected: [
                _selectedIndex == 0,
                _selectedIndex == 1,
              ],
              onPressed: (index) {
                _onItemTapped(index);
              },
            ),
          ),
        ),
      ),
      body: _selectedIndex == 0 ? IncomePage() : EgressPage(), // Mostrar IncomePage o EgressPage según _selectedIndex
      bottomNavigationBar: CustomBottomNavigationBar( // Utilizar CustomBottomNavigationBar para la navegación inferior
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
