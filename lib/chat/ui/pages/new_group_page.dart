import 'package:flutter/material.dart';
import '../../application/use_cases/get_contact.dart';
import '../../application/use_cases/search_contacts.dart';
import '../../application/use_cases/create_group.dart';
import '../../domain/entities/contact.dart';
import '../../infrastructure/adapters/contact_adapter.dart';
import '../../infrastructure/adapters/group_adapter.dart';
import 'create_contact_page.dart'; // Asegúrate de tener esta importación

class NewGroupPage extends StatefulWidget {
  @override
  _NewGroupPageState createState() => _NewGroupPageState();
}

class _NewGroupPageState extends State<NewGroupPage> {
  final _getContacts = GetContacts(ContactAdapter());
  final _searchContacts = SearchContacts();
  final _createGroup = CreateGroup(GroupAdapter());

  List<Contact> _contacts = [];
  List<Contact> _selectedContacts = [];
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    _loadContacts();
  }

  Future<void> _loadContacts() async {
    _contacts = await _getContacts.execute();
    setState(() {});
  }

  void _updateSearch(String searchQuery) {
    setState(() {
      _searchQuery = searchQuery;
    });
  }

  void _selectContact(Contact contact) {
    setState(() {
      _selectedContacts.add(contact);
    });
  }

  void _deselectContact(Contact contact) {
    setState(() {
      _selectedContacts.remove(contact);
    });
  }

  Future<void> _createGroupAction() async {
    await _createGroup.execute('Nuevo Grupo', _selectedContacts);
    // Lógica adicional, como mostrar un mensaje de éxito o navegar a otra página
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final filteredContacts = _searchContacts.execute(_contacts, _searchQuery);

    return Scaffold(
      appBar: AppBar(
        title: Text('Nuevo Grupo'),
        actions: [
          IconButton(
            icon: Icon(Icons.account_circle_rounded),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CreateContactPage()),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 16.0), // Ajusta el valor según tus necesidades
            child: TextField(
              onChanged: _updateSearch,
              decoration: InputDecoration(
                hintText: 'Buscar contacto',
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: filteredContacts.length,
              itemBuilder: (context, index) {
                final contact = filteredContacts[index];
                return CheckboxListTile(
                  title: Text(contact.name),
                  value: _selectedContacts.contains(contact),
                  onChanged: (value) {
                    if (value != null) {
                      if (value) {
                        _selectContact(contact);
                      } else {
                        _deselectContact(contact);
                      }
                    }
                  },
                );
              },
            ),
          ),
          ElevatedButton(
            onPressed: _createGroupAction,
            child: Text('Create Group'),
          ),
        ],
      ),
    );
  }
}
