import '../../../../../domain/aggregates/contact_aggregate.dart';
import '../../../../../domain/entities/contact.entity.dart';
import '../../../../ports/contact/contact_port.dart';
import '../../../contact/contact_use_case.dart';

class DeleteContactCommand implements DeleteContactUseCase {
  final ContactPort contactPort;

  DeleteContactCommand(this.contactPort);

  @override
  Future<void> execute(ContactAggregate aggregate, Contact contact) async {
    // Obtenemos los contactos actuales
    List<Contact> currentContacts = await contactPort.getContacts();

    // Actualizamos el agregado con los contactos actuales
    aggregate.contacts.clear();
    aggregate.contacts.addAll(currentContacts);

    // Eliminamos el contacto del agregado
    aggregate.deleteContact(contact);

    // Guardamos los contactos actualizados en el puerto
    for (Contact contact in aggregate.contacts) {
      await contactPort.createContact(contact);
    }
  }
}