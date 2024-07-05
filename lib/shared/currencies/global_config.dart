import 'domain/entities/currency_entity.dart';

class GlobalConfig {
  static final GlobalConfig _singleton = GlobalConfig._internal();

  factory GlobalConfig() {
    return _singleton;
  }

  GlobalConfig._internal();

  Currency? _defaultCurrency;

  Currency? get defaultCurrency => _defaultCurrency;

  void setDefaultCurrency(Currency currency) {
    _defaultCurrency = currency;
  }
}