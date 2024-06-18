// import 'package:exercises_flutter2/chat/infrastructure/adapters/database_adapter.dart';
//
// class GetContactsQuery {
//   GetContactsQuery(DatabaseAdapter databaseAdapter);
// }
import 'package:exercises_flutter2/chat/infrastructure/adapters/database_adapter.dart';
import '../../../../../domain/aggregates/contact_aggregate.dart';
import '../../../../../domain/entities/contact.entity.dart';
import '../../../contact/contact_use_case.dart';

class GetContactsQuery implements GetContactsUseCase {
  final DatabaseAdapter databaseAdapter;

  GetContactsQuery(this.databaseAdapter);

  @override
  Future<List<Contact>> execute(ContactAggregate aggregate) async {
    // Obtener los contactos desde el adaptador de base de datos
    return await databaseAdapter.getContacts();
  }
}