// import '../../../../domain/aggregates/register_aggregate.dart';
// import '../../../../domain/entities/register_entity.dart';
// import '../../../ports/register_port.dart';
// import '../../register_use_case.dart';
//
// class UpdateRegisterCommand implements UpdateRegisterUseCase {
//   final RegisterPort registerPort;
//
//   UpdateRegisterCommand(this.registerPort);
//
//   @override
//   Future<void> execute(RegisterAggregate aggregate, Register register) async {
//     aggregate.updateRegister(register);
//     await registerPort.updateRegister(register);
//   }
// }