class IncomeEntry {
  final int? id;
  final String description;
  final double amount;
  final DateTime date;
  final String category;

    IncomeEntry({
      this.id,
      required this.description,
      required this.amount,
      required this.date,
      required this.category,
    });
}