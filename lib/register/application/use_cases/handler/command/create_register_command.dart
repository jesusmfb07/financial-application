import '../../../../domain/aggregates/register_aggregate.dart';
import '../../../../domain/entities/register_entity.dart';
import '../../../ports/register_port.dart';
import '../../register_use_case.dart';

class CreateRegisterCommand implements CreateRegisterUseCase {
  final RegisterPort registerPort;

  CreateRegisterCommand(this.registerPort);

  @override
  Future<void> execute(RegisterAggregate aggregate, Register register) async {
    aggregate.createRegister(register);
    await registerPort.createRegister(register);
  }
}
//
// import '../../../../domain/entities/register_entity.dart';
// import '../../../../infrastructure/adapters/register_adapter.dart';
//
// class CreateRegisterCommand{
//   final RegisterSQLiteAdapter registerAdapter = RegisterSQLiteAdapter();
//
//   Future<void> call(Register register) async {
//     await registerAdapter.createRegister(register);
//   }
// }