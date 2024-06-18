import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../domain/entities/group.entity.dart';

class GroupTile extends StatelessWidget {
  final Group group;

  GroupTile({required this.group});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        // Implement group avatar
      ),
      title: Text(group.name),
      onTap: () {
        // Implement logic for tapping on a group
      },
    );
  }
}