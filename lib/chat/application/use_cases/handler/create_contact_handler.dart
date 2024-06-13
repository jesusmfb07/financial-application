// lib/application/use_cases/create_contact_handler.dart
import '../../../domain/entities/contact.dart';
import '../../../infrastructure/adapters/chat_adapter.dart';
import 'command/create_contact_command.dart';


class CreateContactHandler {
  final ChatAdapter chatAdapter;

  CreateContactHandler(this.chatAdapter);

  void handle(CreateContactCommand command) {
    final contact = Contact( command.name, command.lastName);
    chatAdapter.addContact(contact);
  }
}