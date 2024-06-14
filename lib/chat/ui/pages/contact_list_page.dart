import 'package:flutter/material.dart';
import '../../application/use_cases/get_contact.dart';
import '../../domain/entities/contact.dart';
import '../../infrastructure/adapters/database_adapter.dart';
import 'create_contact_page.dart';

class ContactListPage extends StatefulWidget {
  @override
  _ContactListPageState createState() => _ContactListPageState();
}

class _ContactListPageState extends State<ContactListPage> {
  late Future<List<Contact>> _contactsFuture;

  @override
  void initState() {
    super.initState();
    final getContactsUseCase = GetContacts(DatabaseAdapter());
    _contactsFuture = getContactsUseCase.execute();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Contactos'),
      ),
      body: FutureBuilder<List<Contact>>(
        future: _contactsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No hay contactos'));
          } else {
            final contacts = snapshot.data!;
            return ListView.builder(
              itemCount: contacts.length,
              itemBuilder: (context, index) {
                final contact = contacts[index];
                return ListTile(
                  title: Text(contact.name),
                  subtitle: Text(contact.lastName),
                );
              },
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => CreateContactPage()),
          ).then((_) {
            setState(() {
              final getContactsUseCase = GetContacts(DatabaseAdapter());
              _contactsFuture = getContactsUseCase.execute();
            });
          });
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
