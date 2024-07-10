import '../aggregates/currency_aggregate.dart';

class Currency implements CurrencyAggregate {
  @override
  final String code;

  @override
  final String name;

  Currency({required this.code, required this.name});
}