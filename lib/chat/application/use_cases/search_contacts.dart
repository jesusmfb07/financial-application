import '../../domain/entities/contact_entity.dart';

class SearchContacts {
  List<Contact> execute(List<Contact> contacts, String query) {
    return contacts.where((contact) => contact.name.contains(query)).toList();
  }
}