import 'contact_entity.dart'; // Asegúrate de importar la entidad Contacto correcta desde domain

class Group {
  final String name;
  final List<Contact> members;

  Group(this.name, this.members);
}
