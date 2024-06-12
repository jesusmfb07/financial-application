import '../../application/ports/chat_port.dart';
import '../../domain/aggregates/group_aggregate.dart';
import '../adapters/chat_adapter.dart';

class ChatEndPoint implements ChatPort {
  final ChatAdapter _chatAdapter;

  ChatEndPoint(this._chatAdapter);

  @override
  Future<List<GroupAggregate>> getGroups() {
    return _chatAdapter.getGroups);
  }
}