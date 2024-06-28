import '../../domain/entities/currency_entity.dart';

class CurrencyMapper {
  static Map<String, dynamic> toMap(Currency currency) {
    return {
      'code': currency.code,
      'name': currency.name,
    };
  }

  static Currency fromMap(Map<String, dynamic> map) {
    return Currency(
      code: map['code'],
      name: map['name'],
    );
  }
}