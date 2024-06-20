// import '../../../../domain/aggregates/register_aggregate.dart';
// import '../../../../domain/entities/register_entity.dart';
// import '../../../ports/register_port.dart';
// import '../../register_use_case.dart';


import '../../../../domain/aggregates/register_aggregate.dart';
import '../../../../domain/entities/register_entity.dart';
import '../../../ports/register_port.dart';
import '../../register_use_case.dart';

class GetRegistersQuery implements GetRegistersUseCase {
  final RegisterPort registerPort;

  GetRegistersQuery(this.registerPort);

  @override
  Future<List<Register>> execute(RegisterAggregate aggregate) async {
    return await registerPort.getRegisters();
  }
}

