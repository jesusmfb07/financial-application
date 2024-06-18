import '../../application/ports/group/group_port.dart';
import '../../domain/entities/group.entity.dart';

class GroupEndpoint {
  final GroupPort _groupPort;

  GroupEndpoint(this._groupPort);

  Future<List<Group>> getGroups() {
    return _groupPort.getGroups();
  }
}