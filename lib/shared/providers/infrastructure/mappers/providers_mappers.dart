import '../../domain/entities/provider_entity.dart';

class ProviderMapper {
  static Map<String, dynamic> toMap(Provider provider) {
    return {
      'id': provider.id,
      'name': provider.name,
      'phoneNumber': provider.phoneNumber?.toString(),
      'ruc': provider.ruc?.toString(),
    };
  }

  static Provider fromMap(Map<String, dynamic> map) {
    return Provider(
      id: map['id'],
      name: map['name'],
      phoneNumber: map['phoneNumber'] != null ? int.tryParse(map['phoneNumber']) : null,
      ruc: map['ruc'] != null ? int.tryParse(map['ruc']) : null,
    );
  }
}
