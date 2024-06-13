import '../../domain/entities/contact.dart';

abstract class ContactPort {
  Future<List<Contact>> getContacts();
  Future<void> addContact(Contact contact);
}