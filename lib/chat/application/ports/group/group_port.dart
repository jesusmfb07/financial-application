import '../../../domain/entities/group.entity.dart';

abstract class GroupPort {
  Future<List<Group>> getGroups();
  Future<void> createGroup(Group group);
}