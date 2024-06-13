import '../../domain/entities/contact.dart';
import '../ports/contact_port.dart';

class GetContacts {
  final ContactPort contactPort;

  GetContacts(this.contactPort);

  Future<List<Contact>> execute() async {
    return await contactPort.getContacts();
  }
}
