import '../../domain/aggregates/currency_aggregate.dart';
import '../../domain/entities/currency_entity.dart';

abstract class GetCurrenciesUseCase {
  Future<List<Currency>> execute();
}