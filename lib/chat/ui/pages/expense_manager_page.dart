import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import '../../domain/entities/group.dart';
import '../../application/use_cases/get_groups.dart';
import '../../infrastructure/adapters/group_adapter.dart';
import '../widgets/group_title.dart';
import '../widgets/my_finances.dart';
import 'create_contact_page.dart';
import 'new_group_page.dart';
import 'contact_list_page.dart'; // Importa la nueva página

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

  void _onMenuSelected(String value) {
    switch (value) {
      case 'addGroup':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => NewGroupPage()),
        );
        break;
      case 'addContact':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ContactListPage()),
        );
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Gestor de Gastos'),
        actions: [
          PopupMenuButton<String>(
            onSelected: _onMenuSelected,
            itemBuilder: (BuildContext context) {
              return [
                PopupMenuItem<String>(
                  value: 'addGroup',
                  child: Text('Añadir grupo'),
                ),
                PopupMenuItem<String>(
                  value: 'addContact',
                  child: Text('Añadir contacto'),
                ),
              ];
            },
          ),
        ],
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
      ),
    );
  }
}
