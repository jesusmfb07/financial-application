import '../../../../domain/entities/contact.dart';

class CreateGroupCommand {
  final String name;
  final List<Contact> members;

  CreateGroupCommand(this.name, this.members);
}