// class EgressEntry {
//   final String id;
//   final String description;
//   final double amount;
//   final DateTime date;
//   final String categoryId;
//   final String providerId;
//
//   EgressEntry({
//     required this.id,
//     required this.description,
//     required this.amount,
//     required this.date,
//     required this.categoryId,
//     required this.providerId,
//   });
//
//   Map<String, dynamic> toMap() {
//     return {
//       'id': id,
//       'description': description,
//       'amount': amount,
//       'date': date.toIso8601String(),
//       'categoryId': categoryId,
//       'providerId': providerId,
//     };
//   }
//
//   factory EgressEntry.fromMap(Map<String, dynamic> map) {
//     return EgressEntry(
//       id: map['id'],
//       description: map['description'],
//       amount: map['amount'],
//       date: DateTime.parse(map['date']),
//       categoryId: map['categoryId'],
//       providerId: map['providerId'],
//     );
//   }
// }
