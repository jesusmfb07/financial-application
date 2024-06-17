// import '../../domain/entities/contact.entity.dart';
// import '../../infrastructure/adapters/database_adapter.dart'; // Cambiado a DatabaseAdapter
// import 'handler/command/create_contact_command.dart';
//
// class CreateContactHandler {
//   final DatabaseAdapter databaseAdapter;
//
//   CreateContactHandler(this.databaseAdapter);
//
//   void handle(CreateContactCommand command) {
//     final contact = Contact(command.name, command.lastName);
//     databaseAdapter.addContact(contact);
//   }Contact contact
// }


import 'package:exercises_flutter2/chat/domain/aggregates/contact_aggregate.dart';
import '../../domain/entities/contact.entity.dart';

abstract class CreateContactUseCase {
  Future<void> execute(ContactAggregate aggregate,Contact contact);
}

