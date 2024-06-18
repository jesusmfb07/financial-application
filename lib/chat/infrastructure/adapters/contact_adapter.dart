import '../../application/ports/contact/contact_port.dart';
import '../../domain/entities/contact.entity.dart';


class ContactAdapter implements ContactPort {
  List<Contact> _contacts = [];

  @override
  Future<void> updateContact(Contact contact) async {
    // Lógica para actualizar el contacto en la base de datos
  }
  @override
  Future<void> deleteContact(Contact contact) async {
    // Lógica para eliminar el contacto de la base de datos
    // Aquí puedes acceder a la propiedad 'id' de 'contact' si la necesitas
    // para eliminar el contacto de la base de datos
  }

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