import '../../../../domain/aggregates/contact_aggregate.dart';
import '../../../../domain/entities/contact.entity.dart';
import '../../../ports/contact_port.dart';
import '../../create_contact_use_case.dart';

class CreateContactQuery implements CreateContactUseCase {
  final ContactPort contactPort;

  CreateContactQuery(this.contactPort);

  @override
  Future<void> execute(ContactAggregate aggregate,Contact contact) async {
    // Obtenemos los contactos actuales
    List<Contact> currentContacts = await contactPort.getContacts();

    // Actualizamos el agregado con los contactos actuales
    aggregate.contacts.addAll(currentContacts);

    // Añadimos el nuevo contacto al agregado
    aggregate.createContact(contact);

    // Guardamos los nuevos contactos en el puerto
    for (Contact contact in aggregate.contacts) {
      await contactPort.createContact(contact);
    }
  }
}