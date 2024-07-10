import '../aggregates/income_aggregate.dart';

class IncomeEntry implements IncomeEntryAggregate {
  @override
  final int? id;

  @override
  final String description;

  @override
  final double amount;

  @override
  final DateTime date;

  @override
  final String? category;

  @override
  final String? attachmentPath;

  @override
  final String currencySymbol;

  IncomeEntry({
    this.id,
    required this.description,
    required this.amount,
    required this.date,
    this.category,
    this.attachmentPath,
    required this.currencySymbol,
  });
}
