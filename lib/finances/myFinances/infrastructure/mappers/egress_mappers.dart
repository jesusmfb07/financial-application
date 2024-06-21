

import '../../domain/entities/egress_entry_entity.dart';

class EgressEntryMapper {
  static Map<String, dynamic> toMap(EgressEntry entry) {
    return {
      'id': entry.id,
      'description': entry.description,
      'amount': entry.amount,
      'date': entry.date.toIso8601String(),
      'category': entry.category,
      'provider': entry.provider,
    };
  }

  static EgressEntry fromMap(Map<String, dynamic> map) {
    return EgressEntry(
      id: map['id'],
      description: map['description'],
      amount: map['amount'],
      date: DateTime.parse(map['date']),
      category: map['category'],
      provider: map['provider'],
    );
  }
}