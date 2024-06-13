import '../../domain/entities/contact.dart';

abstract class ContactPort {
  Future<void> addContact(Contact contact);
}