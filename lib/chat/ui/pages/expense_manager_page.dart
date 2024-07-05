import 'package:flutter/material.dart';
import '../../domain/entities/group_entity.dart';
import '../../application/use_cases/get_groups.dart';
import '../../infrastructure/adapters/group_adapter.dart';
import '../widgets/group_title.dart';
import '../widgets/my_finances.dart';
import 'new_group_page.dart';
import 'contact_list_page.dart';

class ExpenseManagerPage extends StatefulWidget {
  @override
  _ExpenseManagerPageState createState() => _ExpenseManagerPageState();
}

class _ExpenseManagerPageState extends State<ExpenseManagerPage> {
  final _groupPort = GroupAdapter();
  late final _getGroups = GetGroups(_groupPort);
  List<Group> _groups = [];
  int _selectedIndex = 0;

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

  void _onItemTapped(int index) {
    if (index == 0) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => ExpenseManagerPage()),
      );
    } else {
      setState(() {
        _selectedIndex = index;
      });
    }
  }

    @override
    Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.teal,
          title: Text(
            'Gestor de Gastos',
            style: TextStyle(color: Colors.white), // Texto en color blanco
          ),
          automaticallyImplyLeading: false, // Eliminar la flecha
          actions: [
            PopupMenuButton<String>(
              icon: Icon(Icons.more_vert, color: Colors.white),
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
    );
  }
}
