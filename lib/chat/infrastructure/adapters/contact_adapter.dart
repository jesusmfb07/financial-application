import '../../application/ports/contact_port.dart';
import '../../domain/entities/contact.entity.dart';


class ContactAdapter implements ContactPort {
  List<Contact> _contacts = [];
  @override
  Future<List<Contact>> getContacts() async {
    // Implementar lógica para obtener contactos (puede ser una llamada a una API o base de datos)
    return Future.value(_contacts);
  }

  @override
  Future<void> createContact(Contact contact) async {
    // Implementar lógica para agregar contacto (puede ser una llamada a una API o base de datos)
    _contacts.add(contact);
    return Future.value();
  }
}