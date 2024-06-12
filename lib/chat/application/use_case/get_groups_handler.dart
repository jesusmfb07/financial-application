import '../../domain/aggregates/group_aggregate.dart';
import '../ports/chat_port.dart';

class GetGroupsHandler {
  final ChatPort _chatPort;

  GetGroupsHandler(this._chatPort);

  Future<List<GroupAggregate>> execute() {
    return _chatPort.getGroupsA();
  }
}