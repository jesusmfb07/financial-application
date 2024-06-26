class EgressEntry {
  final int? id;
  final String description;
  final double amount;
  final DateTime date;
  final String category;
  final String provider;
  final String? attachmentPath;

  EgressEntry({
    this.id,
    required this.description,
    required this.amount,
    required this.date,
    required this.category,
    required this.provider,
    this.attachmentPath,
  });
}