import '../entities/contact.entity.dart';

class ContactAggregate {
  final List<Contact> contacts;

  ContactAggregate({required this.contacts});

  void createContact(Contact contact) {
      contacts.add(contact);
  }
}