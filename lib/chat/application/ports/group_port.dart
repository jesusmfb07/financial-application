import '../../domain/entities/group.dart';

abstract class GroupPort {
  Future<List<Group>> getGroups();
}