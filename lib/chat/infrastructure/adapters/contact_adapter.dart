import '../../application/ports/contact_port.dart';
import '../../domain/entities/contact.dart';


class ContactAdapter implements ContactPort {
  @override
  Future<List<Contact>> getContacts() async {
    // Implementar lógica para obtener contactos (puede ser una llamada a una API o base de datos)
    return Future.value([]);
  }

  @override
  Future<void> addContact(Contact contact) async {
    // Implementar lógica para agregar contacto (puede ser una llamada a una API o base de datos)
  }
}