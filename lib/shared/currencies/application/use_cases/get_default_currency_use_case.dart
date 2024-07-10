import '../../domain/entities/currency_entity.dart';

abstract class GetDefaultCurrencyUseCase {
  Future<Currency?> execute();
}