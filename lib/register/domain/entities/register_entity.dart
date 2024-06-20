// class Register {
//   final String id;
//   final String type;
//   final double amount;
//   final String date;
//   final String description;
//
//   Register({
//     required this.id,
//     required this.type,
//     required this.amount,
//     required this.date,
//     required this.description,
//   });
//
//   Map<String, dynamic> toMap() {
//     return {
//       'id': id,
//       'type': type,
//       'amount': amount,
//       'date': date,
//       'description': description,
//     };
//   }
//
//   factory Register.fromMap(Map<String, dynamic> map) {
//     return Register(
//       id: map['id'],
//       type: map['type'],
//       amount: map['amount'],
//       date: map['date'],
//       description: map['description'],
//     );
//   }
// }
class Register {
  final String id;
  final String type; // 'Egreso' o 'Ingreso'
  final double amount;
  final DateTime date;

  Register({
    required this.id,
    required this.type,
    required this.amount,
    required this.date,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'type': type,
      'amount': amount,
      'date': date.toIso8601String(),
    };
  }

  static Register fromMap(Map<String, dynamic> map) {
    return Register(
      id: map['id'],
      type: map['type'],
      amount: map['amount'],
      date: DateTime.parse(map['date']),
    );
  }
}