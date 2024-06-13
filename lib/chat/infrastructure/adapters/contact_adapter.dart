import '../../application/ports/contact_port.dart';
import '../../domain/entities/contact.dart';


class ContactRepositoryImpl implements ContactPort{
  @override
  Future<void> addContact(Contact contact) async {
    // Implementar lógica para agregar contacto (puede ser una llamada a una API o base de datos)
  }
}