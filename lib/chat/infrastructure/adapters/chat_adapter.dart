import 'package:chat/application/ports/chat_port.dart';
import 'package:chat/domain/entities/contact.dart';
import 'package:chat/domain/entities/group.dart';
import 'package:chat/domain/aggregates/group_aggregate.dart';
import 'package:chat/infrastructure/end_points/chat_end_point.dart';

import '../../application/ports/chat_port.dart';
import '../../domain/aggregates/group_aggregate.dart';
import '../../domain/entities/contact.dart';
import '../../domain/entities/group.dart';
import '../end_points/chat_end_point.dart';

class ChatAdapter implements ChatPort {
  final ChatEndPoint _chatEndPoint;

  ChatAdapter(this._chatEndPoint);

  @override
  Future<void> createContact(Contact contact) async {
    // Implementación para crear un contacto utilizando el ChatEndPoint
  }

  @override
  Future<void> createGroup(Group group) async {
    // Implementación para crear un grupo utilizando el ChatEndPoint
  }

  @override
  Future<List<Contact>> getContacts() async {
    // Implementación para obtener los contactos utilizando el ChatEndPoint
  }

  @override
  Future<List<GroupAggregate>> getGroupsA() async {
    // Lógica para obtener los grupos desde la fuente de datos
    return [
      GroupAggregate(id: '1', name: 'Grupo 1'),
      GroupAggregate(id: '2', name: 'Grupo 2'),
      GroupAggregate(id: '3', name: 'Grupo 3'),
      GroupAggregate(id: '4', name: 'Grupo 4'),
    ];
  }
}