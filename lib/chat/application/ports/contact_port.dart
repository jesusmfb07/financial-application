import '../../domain/entities/contact.entity.dart';

abstract class ContactPort {
  Future<List<Contact>> getContacts();
  Future<void> createContact(Contact contact);
}