import '../../../../../domain/aggregates/contact_aggregate.dart';
import '../../../../../domain/entities/contact.entity.dart';
import '../../../../ports/contact/contact_port.dart';
import '../../../contact/contact_use_case.dart';


class UpdateContactCommand {
  final ContactPort contactPort;

  UpdateContactCommand(this.contactPort);

  Future<void> execute(Contact contact) async {
    await contactPort.updateContact(contact);
  }
}