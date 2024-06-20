import '../../domain/aggregates/provider_aggregate.dart';
import '../../domain/entities/provider_entity.dart';

abstract class GetProvidersUseCase {
  Future<List<Provider>> execute(ProviderAggregate aggregate);
}

abstract class CreateProviderUseCase {
  Future<void> execute(ProviderAggregate aggregate, Provider provider);
}

abstract class UpdateProviderUseCase {
  Future<void> execute(ProviderAggregate aggregate, Provider provider);
}

abstract class DeleteProviderUseCase {
  Future<void> execute(ProviderAggregate aggregate, Provider provider);
}

