// import 'package:flutter/material.dart';
//
// class GroupListItem extends StatelessWidget {
//   final String groupName;
//   final VoidCallback onTap;
//
//   GroupListItem({required this.groupName, required this.onTap});
//
//   @override
//   Widget build(BuildContext context) {
//     return ListTile(
//       leading: CircleAvatar(
//         child: Text(groupName.substring(0, 2).toUpperCase()),
//       ),
//       title: Text(groupName),
//       trailing: Icon(Icons.arrow_forward_ios),
//       onTap: onTap,
//     );
//   }
// }