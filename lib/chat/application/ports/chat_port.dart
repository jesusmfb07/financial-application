import '../../domain/aggregates/group_aggregate.dart';
import '../../domain/entities/contact.dart';
import '../../domain/entities/group.dart';

abstract class ChatPort{
  Future<void> createContact(Contact contact);
  Future<void> createGroup(Group group);
  Future<List<Contact>> getContacts();
  Future<List<Group>> getGroups();
  Future<List<GroupAggregate>> getGroupsA();
}