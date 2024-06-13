import '../../domain/entities/contact.dart';
import '../ports/contact_port.dart';

class AddContact {
  final ContactPort _contactRepository;

  AddContact(this._contactRepository);

  Future<void> execute(Contact contact) async {
    await _contactRepository.addContact(contact);
  }
}