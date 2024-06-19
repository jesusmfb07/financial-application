// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
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
//           label: 'Reportes', // Puedes cambiar el label a algo diferente como 'Estadísticas'
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
//
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
//
// class CustomBottomNavigationBar extends StatelessWidget {
//   final int currentIndex;
//   final Function(int) onTap;
//   final List<int> additionalIndexesToShowIcons; // Nuevos índices que deben mostrar íconos adicionales
//
//   CustomBottomNavigationBar({
//     required this.currentIndex,
//     required this.onTap,
//     this.additionalIndexesToShowIcons = const [], // Por defecto, no se muestran íconos adicionales
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return BottomNavigationBar(
//       type: BottomNavigationBarType.fixed,
//       currentIndex: currentIndex,
//       onTap: onTap,
//       items: _buildBottomNavBarItems(),
//     );
//   }
//
//   List<BottomNavigationBarItem> _buildBottomNavBarItems() {
//     return [
//       BottomNavigationBarItem(
//         icon: Icon(Icons.chat_bubble_outline_rounded),
//         label: 'Chats',
//       ),
//       if (additionalIndexesToShowIcons.contains(1)) // Mostrar 'Reportes' si está en la lista de índices
//         BottomNavigationBarItem(
//           icon: Icon(Icons.insert_chart),
//           label: 'Reportes',
//         ),
//       if (additionalIndexesToShowIcons.contains(2)) // Mostrar 'Calendario' si está en la lista de índices
//         BottomNavigationBarItem(
//           icon: Icon(Icons.calendar_today),
//           label: 'Calendario',
//         ),
//       if (additionalIndexesToShowIcons.contains(3)) // Mostrar 'Ajustes' si está en la lista de índices
//         BottomNavigationBarItem(
//           icon: Icon(Icons.settings),
//           label: 'Ajustes',
//         ),
//     ];
//   }
// }


// import 'package:flutter/material.dart';
//
// class CustomBottomNavigationBar extends StatefulWidget {
//   final int currentIndex;
//
//   CustomBottomNavigationBar({
//     required this.currentIndex,
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
//       onTap: (index) {
//         // Implementa lógica según sea necesario
//       },
//     );
//   }
// }


import 'package:flutter/material.dart';

class CustomBottomNavigationBar extends StatefulWidget {
  final int currentIndex;
  final Function(int) onTap; // Nuevo parámetro para manejar onTap

  CustomBottomNavigationBar({
    required this.currentIndex,
    required this.onTap, // Agrega required para el parámetro onTap
  });

  @override
  _CustomBottomNavigationBarState createState() => _CustomBottomNavigationBarState();
}

class _CustomBottomNavigationBarState extends State<CustomBottomNavigationBar> {
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: widget.currentIndex,
      onTap: widget.onTap, // Asigna onTap al widget.onTap
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.account_balance_wallet),
          label: 'Wallet',
        ),
        // Agrega más items según sea necesario
      ],
    );
  }
}

