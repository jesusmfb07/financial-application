import '../../domain/entities/group.entity.dart';
import '../ports/group/group_port.dart';

class GetGroups {
  final GroupPort _groupPort;
  GetGroups(this._groupPort);
  Future<List<Group>> execute() async {
    return await _groupPort.getGroups();
  }
}
