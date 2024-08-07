// import '../entities/currency_entity.dart';
//
// class CurrencyAggregate {
//   final List<Currency> currencies;
//   String? defaultCurrencyCode;
//
//   CurrencyAggregate({required this.currencies, this.defaultCurrencyCode});
//
//   List<Currency> listCurrencies() {
//     return currencies;
//   }
//
//   void setDefaultCurrency(String currencyCode) {
//     if (currencies.any((currency) => currency.code == currencyCode)) {
//       defaultCurrencyCode = currencyCode;
//     }
//   }
//
//   Currency? getDefaultCurrency() {
//     if (defaultCurrencyCode != null) {
//       return currencies.firstWhere(
//             (currency) => currency.code == defaultCurrencyCode,
//         orElse: () => currencies.first,
//       );
//     }
//     return currencies.isNotEmpty ? currencies.first : null;
//   }
//
//   void addCurrencies(List<Currency> newCurrencies) {
//     currencies.clear();
//     currencies.addAll(newCurrencies);
//   }

//   void addDefaultCurrencies(List<Currency> defaultCurrencies) {
//     final List<Currency> merged = List.from(defaultCurrencies);
//     for (var currency in currencies) {
//       if (!merged.any((c) => c.code == currency.code)) {
//         merged.add(currency);
//       }
//     }
//     currencies.clear();
//     currencies.addAll(merged);
//   }
// }

abstract class CurrencyAggregate {
  String get code;
  String get name;
}