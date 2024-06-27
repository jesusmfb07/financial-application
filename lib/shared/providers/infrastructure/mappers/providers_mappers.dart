import '../../domain/entities/provider_entity.dart';

class ProviderMapper {
  static Map<String, dynamic> toMap(Provider provider) {
    return {
      'id': provider.id,
      'name': provider.name,
      'phoneNumber': provider.phoneNumber,
      'ruc': provider.ruc,
    };
  }

  static Provider fromMap(Map<String, dynamic> map) {
    return Provider(
      id: map['id'],
      name: map['name'],
      phoneNumber: map['phoneNumber'],
      ruc: map['ruc'],
    );
  }
}