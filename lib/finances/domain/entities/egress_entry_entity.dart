import '../aggregates/egress_aggregate.dart';

class EgressEntry implements EgressEntryAggregate {
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
  final String? provider;
  @override
  final String? attachmentPath;
  @override
  final String currencySymbol;

  EgressEntry({
    this.id,
    required this.description,
    required this.amount,
    required this.date,
    this.category,
    this.provider,
    this.attachmentPath,
    required this.currencySymbol,
  });
}
