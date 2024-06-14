import '../../../domain/entities/contact.dart';
import '../../../infrastructure/adapters/database_adapter.dart'; // Cambiado a DatabaseAdapter
import 'command/create_contact_command.dart';

class CreateContactHandler {
  final DatabaseAdapter databaseAdapter;

  CreateContactHandler(this.databaseAdapter);

  void handle(CreateContactCommand command) {
    final contact = Contact(command.name, command.lastName);
    databaseAdapter.addContact(contact);
  }
}
