import '../../application/ports/group_port.dart';
import '../../domain/entities/group.dart';

class GroupAdapter implements GroupPort {
  @override
  Future<List<Group>> getGroups() async {
    // Implementar lógica para obtener grupos (puede ser una llamada a una API o base de datos)
    return Future.value([]);
  }

  @override
  Future<void> createGroup(Group group) async {
    // Implementar lógica para crear un grupo (puede ser una llamada a una API o base de datos)
  }
}
