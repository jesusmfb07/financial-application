import '../../../../../domain/entities/contact.entity.dart';

class CreateGroupCommand {
  final String name;
  final List<Contact> members;

  CreateGroupCommand(this.name, this.members);
}