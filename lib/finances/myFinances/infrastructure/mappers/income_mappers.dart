import '../../domain/entities/income_entry_entity.dart';

class IncomeEntryMapper {
  static Map<String, dynamic> toMap(IncomeEntry entry) {
    return {
      'id': entry.id,
      'description': entry.description,
      'amount': entry.amount,
      'date': entry.date.toIso8601String(),
      'category': entry.category,
      'attachmentPath': entry.attachmentPath,
    };
  }

  static IncomeEntry fromMap(Map<String, dynamic> map) {
    return IncomeEntry(
      id: map['id'],
      description: map['description'],
      amount: map['amount'],
      date: DateTime.parse(map['date']),
      category: map['category'],
      attachmentPath: map['attachmentPath'],
    );
  }
}