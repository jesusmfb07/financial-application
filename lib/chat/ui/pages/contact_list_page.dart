import 'package:flutter/material.dart';
import '../../application/use_cases/handler/command/contact/delete_contact_command.dart';
import '../../application/use_cases/handler/queries/contact/get_contacts_query.dart';
import '../../domain/aggregates/contact_aggregate.dart';
import '../../domain/entities/contact.entity.dart';
import '../../infrastructure/adapters/database_adapter.dart';
import '../contact/create_contact_page.dart';
import '../contact/update_contact_page.dart';



class ContactListPage extends StatefulWidget {
  @override
  _ContactListPageState createState() => _ContactListPageState();
}

class _ContactListPageState extends State<ContactListPage> {
  late Future<List<Contact>> _contactsFuture;

  @override
  void initState() {
    super.initState();
    _loadContacts();
  }

  void _loadContacts() {
    final getContactsUseCase = GetContactsQuery(DatabaseAdapter());
    setState(() {
      _contactsFuture = getContactsUseCase.execute(ContactAggregate(contacts: [])); // Pasa un ContactAggregate vacío
    });
  }

  void _deleteContact(Contact contact) async {
    final deleteContactUseCase = DeleteContactCommand(DatabaseAdapter());
    final aggregate = ContactAggregate(contacts: []); // Crea un ContactAggregate vacío
    await deleteContactUseCase.execute(aggregate, contact);
    _loadContacts();
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
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(Icons.edit),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => UpdateContactPage(contact: contact),
                            ),
                          ).then((_) => _loadContacts());
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () => _deleteContact(contact),
                      ),
                    ],
                  ),
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
          ).then((_) => _loadContacts());
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
