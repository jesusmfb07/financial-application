class IncomeEntry {
  final String id;
  final String description;
  final double amount;
  final DateTime date;
  final String category;
  final String? attachmentPath; // Añade el campo attachmentPath

  IncomeEntry({
    this.id = '', // Proporciona un valor predeterminado para id
    required this.description,
    required this.amount,
    required this.date,
    required this.category,
    this.attachmentPath,
  });
}