import '../../../domain/entities/group_entity.dart';

abstract class GroupPort {
  Future<List<Group>> getGroups();
  Future<void> createGroup(Group group);
}