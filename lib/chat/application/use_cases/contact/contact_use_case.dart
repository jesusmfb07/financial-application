import 'package:exercises_flutter2/chat/domain/aggregates/contact_aggregate.dart';
import '../../../domain/entities/contact_entity.dart';

abstract class GetContactsUseCase {
  Future<List<Contact>> execute(ContactAggregate aggregate);
}

abstract class CreateContactUseCase {
  Future<void> execute(ContactAggregate aggregate,Contact contact);
}

abstract class UpdateContactUseCase {
  Future<void> execute(ContactAggregate aggregate, Contact contact);
}

abstract class DeleteContactUseCase {
  Future<void> execute(ContactAggregate aggregate, Contact contact);
}