import '../../domain/entities/currency_entity.dart';

abstract class CurrencyPort {
  Future<List<Currency>> getCurrencies();
  Future<Currency?> getDefaultCurrency();
  Future<void> setDefaultCurrency(String currencyCode);
}