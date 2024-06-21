// import '../../../../domain/aggregates/egress_entry_aggregate.dart';
// import '../../../../domain/entities/egress_entry_entity.dart';
// import '../../../ports/egress_entry_port.dart';
// import '../../egress_entry_use_case.dart';
//
// class DeleteEgressEntryCommand implements DeleteEgressEntryUseCase{
//   final EgressEntryPort egressEntryPort;
//
//   DeleteEgressEntryCommand(this.egressEntryPort);
//
//   Future<void> execute(EgressEntryAggregate aggregate, EgressEntry entry) async {
//     aggregate.deleteEntry(entry);
//     await egressEntryPort.deleteEntry(entry.id);
//   }
// }