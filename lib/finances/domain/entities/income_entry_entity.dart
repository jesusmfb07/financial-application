class IncomeEntry {
  final int? id;
  final String description;
  final double amount;
  final DateTime date;
  final String? category;
  final String? attachmentPath;
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
