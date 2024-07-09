import '../../domain/aggregates/provider_aggregate.dart';

abstract class GetProvidersUseCase {
  Future<List<ProviderAggregate>> execute();
}