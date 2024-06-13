// import 'package:flutter/material.dart';
// import '../../application/use_case/get_groups.dart';
// import '../../domain/aggregates/group_aggregate.dart';
// import '../../infrastructure/end_points/chat_end_point.dart';
// import '../widgets/group_list_item.dart';
//
// class ChatPage extends StatefulWidget {
//   final ChatEndPoint endPoint;
//
//   ChatPage({required this.endPoint});
//
//   @override
//   _ChatPageState createState() => _ChatPageState();
// }
//
// class _ChatPageState extends State<ChatPage> {
//   late GetGroupsHandler _getGroupsHandler;
//
//   @override
//   void initState() {
//     super.initState();
//     _getGroupsHandler = GetGroupsHandler(widget.endPoint);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.blue,
//         title: Text('Gestor de gastos'),
//         centerTitle: true,
//       ),
//       body: Column(
//         children: [
//           ListTile(
//             leading: Icon(Icons.attach_money),
//             title: Text('Mis finanzas'),
//             trailing: Icon(Icons.arrow_forward_ios, color: Colors.white),
//             onTap: () {
//               // Lógica para abrir "Mis finanzas"
//             },
//           ),
//           Expanded(
//             child: FutureBuilder<List<GroupAggregate>>(
//               future: _getGroupsHandler.execute(),
//               builder: (context, snapshot) {
//                 if (snapshot.hasData) {
//                   return ListView.builder(
//                     itemCount: snapshot.data!.length,
//                     itemBuilder: (context, index) {
//                       final group = snapshot.data![index];
//                       return GroupListItem(
//                         groupName: group.name,
//                         onTap: () {
//                           // Lógica para abrir el grupo
//                         },
//                       );
//                     },
//                   );
//                 } else {
//                   return Center(child: CircularProgressIndicator());
//                 }
//               },
//             ),
//           ),
//         ],
//       ),
//       bottomNavigationBar: BottomNavigationBar(
//         type: BottomNavigationBarType.fixed,
//         items: const [
//           BottomNavigationBarItem(
//             icon: Icon(Icons.chat_bubble_outline_rounded),
//             label: 'Chats',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.insert_chart),
//             label: 'Reportes',
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
