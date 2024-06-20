// import '../../../../domain/aggregates/register_aggregate.dart';
// import '../../../../domain/entities/register_entity.dart';
// import '../../../ports/register_port.dart';
// import '../../register_use_case.dart';
//
// class DeleteRegisterCommand implements DeleteRegisterUseCase {
//   final RegisterPort registerPort;
//
//   DeleteRegisterCommand(this.registerPort);
//
//   @override
//   Future<void> execute(RegisterAggregate aggregate, Register register) async {
//     aggregate.deleteRegister(register);
//     await registerPort.deleteRegister(register.id);
//   }
// }