import '../../domain/aggregates/register_aggregate.dart';
import '../../domain/entities/register_entity.dart';

abstract class GetRegistersUseCase {
  Future<List<Register>> execute(RegisterAggregate aggregate);
}

abstract class CreateRegisterUseCase {
  Future<void> execute(RegisterAggregate aggregate, Register register);
}
