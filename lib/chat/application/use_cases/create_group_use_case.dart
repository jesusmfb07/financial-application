import '../ports/group/group_port.dart';
import '../../domain/entities/group.entity.dart';
import '../../domain/entities/contact.entity.dart';

class CreateGroup {
  final GroupPort _groupPort;

  CreateGroup(this._groupPort);

  Future<void> execute(String groupName, List<Contact> members) async {
    final group = Group(groupName, members);
    await _groupPort.createGroup(group);
  }
}