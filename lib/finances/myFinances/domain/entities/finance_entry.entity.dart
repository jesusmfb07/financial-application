class FinanceEntry {
  final String description;
  final double amount;
  final DateTime date;
  final EntryType type;

  FinanceEntry({
    required this.description,
    required this.amount,
    required this.date,
    required this.type,
  });
}

enum EntryType { income, expense }