class Provider {
  final String id;
  final String name;
  final String? phoneNumber;
  final String? ruc;

  Provider({
    required this.id,
    required this.name,
    this.phoneNumber,
    this.ruc,
  });
}