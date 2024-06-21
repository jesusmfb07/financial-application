// class IncomeEntry {
//   final String id;
//   final String description;
//   final double amount;
//   final DateTime date;
//   final String categoryId;
//
//   IncomeEntry({
//     required this.id,
//     required this.description,
//     required this.amount,
//     required this.date,
//     required this.categoryId,
//   });
//
//   Map<String, dynamic> toMap() {
//     return {
//       'id': id,
//       'description': description,
//       'amount': amount,
//       'date': date.toIso8601String(),
//       'categoryId': categoryId,
//     };
//   }
//
//   factory IncomeEntry.fromMap(Map<String, dynamic> map) {
//     return IncomeEntry(
//       id: map['id'],
//       description: map['description'],
//       amount: map['amount'],
//       date: DateTime.parse(map['date']),
//       categoryId: map['categoryId'],
//     );
//   }
// }