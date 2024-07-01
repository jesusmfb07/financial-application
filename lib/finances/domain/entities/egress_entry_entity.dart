class EgressEntry {
  final int? id;
  final String description;
  final double amount;
  final DateTime date;
  final String? category;
  final String? provider;
  final String? attachmentPath;
  final String currencySymbol;

  EgressEntry({
    this.id,
    required this.description,
    required this.amount,
    required this.date,
    required this.category,
    required this.provider,
    this.attachmentPath,
    required this.currencySymbol,
  });
}