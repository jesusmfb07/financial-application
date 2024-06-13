import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import '../../domain/entities/group.dart';
import '../../application/use_cases/get_groups.dart';
import '../../application/ports/group_port.dart';
import '../../application/use_cases/get_groups.dart';
import '../../infrastructure/adapters/group_adapter.dart';
import '../widgets/group_title.dart';
import '../widgets/my_finances.dart';


class ExpenseManagerPage extends StatefulWidget {
  @override
  _ExpenseManagerPageState createState() => _ExpenseManagerPageState();
}

class _ExpenseManagerPageState extends State<ExpenseManagerPage> {
  final _groupPort = GroupAdapter();
  late final _getGroups = GetGroups(_groupPort);
  List<Group> _groups = [];

  @override
  void initState() {
    super.initState();
    _loadGroups();
  }

  Future<void> _loadGroups() async {
    _groups = await _getGroups.execute();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Gestor de Gastos'),
      ),
      body: Column(
        children: [
          MyFinancesTile(),
          Expanded(
            child: ListView.builder(
              itemCount: _groups.length,
              itemBuilder: (context, index) {
                return GroupTile(group: _groups[index]);
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.chat_bubble_outline_rounded),
            label: 'Chats',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.insert_chart),
            label: 'Reportes',
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
        // Implement bottom navigation bar
      ),
    );
  }
}