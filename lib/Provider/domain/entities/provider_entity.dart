class Provider {
  final String id;
  final String name;
  final String phoneNumber;
  final String ruc;

  Provider({
    required this.id,
    required this.name,
    required this.phoneNumber,
    required this.ruc,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'phoneNumber': phoneNumber,
      'ruc': ruc,
    };
  }

  factory Provider.fromMap(Map<String, dynamic> map) {
    return Provider(
      id: map['id'],
      name: map['name'],
      phoneNumber: map['phoneNumber'],
      ruc: map['ruc'],
    );
  }
}