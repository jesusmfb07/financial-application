import '../../domain/aggregates/currency_aggregate.dart';

abstract class SetDefaultCurrencyUseCase {
  Future<void> execute(String currencyCode);
}