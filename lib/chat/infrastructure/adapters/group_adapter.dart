import '../../domain/entities/group.dart';
import '../../application/ports/group_port.dart';

class GroupAdapter implements GroupPort {
  GroupAdapter(); // Agrega un constructor vacío

  @override
  Future<List<Group>> getGroups() {
    // Implementa la lógica para obtener los datos de los grupos desde una fuente de datos
    return Future.value([
      Group(1, 'Grupo 1'),
      Group(2, 'Grupo 2'),
      Group(3, 'Grupo 3'),
      Group(4, 'Grupo 4')
      // Agrega más grupos de ejemplo si es necesario
    ]);
  }
}