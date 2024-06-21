import '../../domain/entities/register_entity.dart';

abstract class RegisterPort {
  Future<List<Register>> getRegisters();
  Future<void> createRegister(Register register);
}