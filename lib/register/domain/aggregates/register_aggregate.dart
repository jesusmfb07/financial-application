import '../entities/register_entity.dart';

class RegisterAggregate {
  final List<Register> registers;

  RegisterAggregate({required this.registers});

  void createRegister(Register register) {
    registers.add(register);
  }

}