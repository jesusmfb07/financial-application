// import '../../../../domain/aggregates/egress_entry_aggregate.dart';
// import '../../../../domain/entities/egress_entry_entity.dart';
// import '../../../ports/egress_entry_port.dart';
// import '../../egress_entry_use_case.dart';
//
// class GetEgressEntriesQuery implements GetEgressEntriesUseCase {
//   final EgressEntryPort egressEntryPort;
//
//   GetEgressEntriesQuery(this.egressEntryPort);
//
//   Future<List<EgressEntry>> execute(EgressEntryAggregate aggregate) async {
//     return await egressEntryPort.getEntries();
//   }
// }