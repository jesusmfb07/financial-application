import '../entities/contact_entity.dart';

class ContactAggregate {
  final List<Contact> contacts;

  ContactAggregate({required this.contacts});

  void createContact(Contact contact) {
    contacts.add(contact);
  }

  void updateContact(Contact contact) {
    final index = contacts.indexWhere((c) => c.id == contact.id);
    if (index != -1) {
      contacts[index] = contact;
    }
  }

  void deleteContact(Contact contact) {
    contacts.removeWhere((c) => c.id == contact.id);
  }
}