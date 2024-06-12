import '../../domain/entities/contact.dart';
import '../ports/chat_port.dart';
import 'handler/command/create_contact_command.dart';

class CreateContactHandler {
  final ChatPort chatPort;

  CreateContactHandler(this.chatPort);

  Future<void> handle(CreateContactCommand command) async {
    final contact = Contact(command.name, command.lastName);
    await chatPort.createContact(contact);
  }
}