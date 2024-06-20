import '../../domain/entities/register_entity.dart';

abstract class RegisterPort {
  Future<List<Register>> getRegisters();
  Future<void> createRegister(Register register);
  Future<void> updateRegister(Register register);
  Future<void> deleteRegister(String id);
}