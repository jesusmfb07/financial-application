// import 'package:flutter/material.dart';
// import '../../application/use_cases/provider_use_case.dart';
// import '../../domain/aggregates/provider_aggregate.dart';
// import '../../domain/entities/provider_entity.dart';
//
// class ProviderPage extends StatefulWidget {
//   final CreateProviderUseCase createProviderUseCase;
//   final UpdateProviderUseCase updateProviderUseCase;
//   final DeleteProviderUseCase deleteProviderUseCase;
//   final GetProvidersUseCase getProvidersUseCase;
//
//   ProviderPage({
//     required this.createProviderUseCase,
//     required this.updateProviderUseCase,
//     required this.deleteProviderUseCase,
//     required this.getProvidersUseCase,
//   });
//
//   @override
//   _ProviderPageState createState() => _ProviderPageState();
// }
//
// class _ProviderPageState extends State<ProviderPage> {
//   final TextEditingController _nameController = TextEditingController();
//   final TextEditingController _phoneNumberController = TextEditingController();
//   final TextEditingController _rucController = TextEditingController();
//   List<ProviderAggregate> _providers = [];
//   @override
//   void initState() {
//     super.initState();
//     _loadProviders();
//   }
//
//   Future<void> _loadProviders() async {
//     final providers = await widget.getProvidersUseCase.execute();
//     setState(() {
//      _providers = providers;
//     });
//   }
//
//   Future<void> _addOrUpdateProvider({String? id}) async {
//     if (_nameController.text.isEmpty) return;
//
//     final provider = Provider(
//       id: id ?? DateTime.now().toString(),
//       name: _nameController.text,
//       phoneNumber: _phoneNumberController.text.isNotEmpty
//           ? _phoneNumberController.text
//           : null,
//       ruc: _rucController.text.isNotEmpty ? _rucController.text : null,
//     );
//
//     if (id == null) {
//       await widget.createProviderUseCase.execute(provider);
//     } else {
//       await widget.updateProviderUseCase.execute(provider);
//     }
//     _nameController.clear();
//     _phoneNumberController.clear();
//     _rucController.clear();
//     _loadProviders();
//   }
//
//   Future<void> _deleteProviderById(String id) async {
//     final provider = _providers.firstWhere((p) => p.id == id);
//     await widget.deleteProviderUseCase.execute(provider);
//     _loadProviders();
//   }
//
//   void _showAddProviderDialog({
//     String? id,
//     String? initialName,
//     String? initialPhoneNumber,
//     String? initialRuc,
//   }) {
//     if (initialName != null) {
//       _nameController.text = initialName;
//     } else {
//       _nameController.clear();
//     }
//
//     if (initialPhoneNumber != null) {
//       _phoneNumberController.text = initialPhoneNumber;
//     } else {
//       _phoneNumberController.clear();
//     }
//
//     if (initialRuc != null) {
//       _rucController.text = initialRuc;
//     } else {
//       _rucController.clear();
//     }
//
//     showDialog(
//       context: context,
//       builder: (context) {
//         return AlertDialog(
//           title: Text(id == null ? 'Agregar Proveedor' : 'Editar Proveedor'),
//           content: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               TextField(
//                 controller: _nameController,
//                 decoration: InputDecoration(labelText: 'Nombre del proveedor'),
//               ),
//               TextField(
//                 controller: _phoneNumberController,
//                 decoration: InputDecoration(labelText: 'Teléfono'),
//               ),
//               TextField(
//                 controller: _rucController,
//                 decoration: InputDecoration(labelText: 'RUC'),
//               ),
//             ],
//           ),
//           actions: [
//             TextButton(
//               child: Text('Cancelar'),
//               onPressed: () => Navigator.of(context).pop(),
//             ),
//             TextButton(
//               child: Text('Guardar'),
//               onPressed: () {
//                 _addOrUpdateProvider(id: id);
//                 Navigator.of(context).pop();
//               },
//             ),
//           ],
//         );
//       },
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Proveedores'),
//       ),
//       body: ListView.builder(
//         itemCount: _providers.length,
//         itemBuilder: (context, index) {
//           final provider = _providers[index];
//           return ListTile(
//             title: Text(provider.name),
//             subtitle: Text(provider.phoneNumber ?? 'N/A'),
//             trailing: Row(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 IconButton(
//                   icon: Icon(Icons.edit),
//                   onPressed: () => _showAddProviderDialog(
//                     id: provider.id,
//                     initialName: provider.name,
//                     initialPhoneNumber: provider.phoneNumber,
//                     initialRuc: provider.ruc,
//                   ),
//                 ),
//                 IconButton(
//                   icon: Icon(Icons.delete),
//                   onPressed: () => _deleteProviderById(provider.id),
//                 ),
//               ],
//             ),
//             onTap: () {
//               _nameController.text = provider.name;
//               _phoneNumberController.text = provider.phoneNumber ?? '';
//               _rucController.text = provider.ruc ?? '';
//               _showAddProviderDialog(
//                 id: provider.id,
//                 initialName: provider.name,
//                 initialPhoneNumber: provider.phoneNumber,
//                 initialRuc: provider.ruc,
//               );
//             },
//           );
//         },
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () => _showAddProviderDialog(),
//         tooltip: 'Agregar proveedor',
//         child: Icon(Icons.add),
//       ),
//     );
//   }
// }


import 'package:flutter/material.dart';
import '../../application/use_cases/create_provider_use_case.dart';
import '../../application/use_cases/update_provider_use_case.dart';
import '../../application/use_cases/delete_provider_use_case.dart';
import '../../application/use_cases/get_providers_use_case.dart';
import '../../domain/aggregates/provider_aggregate.dart';
import '../../domain/entities/provider_entity.dart';

class ProviderPage extends StatefulWidget {
  final CreateProviderUseCase createProviderUseCase;
  final UpdateProviderUseCase updateProviderUseCase;
  final DeleteProviderUseCase deleteProviderUseCase;
  final GetProvidersUseCase getProvidersUseCase;

  ProviderPage({
    required this.createProviderUseCase,
    required this.updateProviderUseCase,
    required this.deleteProviderUseCase,
    required this.getProvidersUseCase,
  });

  @override
  _ProviderPageState createState() => _ProviderPageState();
}

class _ProviderPageState extends State<ProviderPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _rucController = TextEditingController();
  List<ProviderAggregate> _providers = [];

  @override
  void initState() {
    super.initState();
    _loadProviders();
  }

  Future<void> _loadProviders() async {
    final providers = await widget.getProvidersUseCase.execute();
    setState(() {
      _providers = providers;
    });
  }

  Future<void> _addOrUpdateProvider({String? id}) async {
    if (_nameController.text.isEmpty) return;

    final provider = Provider(
      id: id ?? DateTime.now().toString(),
      name: _nameController.text,
      phoneNumber: _phoneNumberController.text.isNotEmpty
          ? _phoneNumberController.text
          : null,
      ruc: _rucController.text.isNotEmpty ? _rucController.text : null,
    );

    if (id == null) {
      await widget.createProviderUseCase.execute(provider);
    } else {
      await widget.updateProviderUseCase.execute(provider);
    }
    _nameController.clear();
    _phoneNumberController.clear();
    _rucController.clear();
    _loadProviders();
  }

  Future<void> _deleteProviderById(String id) async {
    final provider = _providers.firstWhere((p) => p.id == id);
    await widget.deleteProviderUseCase.execute(provider);
    _loadProviders();
  }

  void _showAddProviderDialog({
    String? id,
    String? initialName,
    String? initialPhoneNumber,
    String? initialRuc,
  }) {
    if (initialName != null) {
      _nameController.text = initialName;
    } else {
      _nameController.clear();
    }

    if (initialPhoneNumber != null) {
      _phoneNumberController.text = initialPhoneNumber;
    } else {
      _phoneNumberController.clear();
    }

    if (initialRuc != null) {
      _rucController.text = initialRuc;
    } else {
      _rucController.clear();
    }

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(id == null ? 'Agregar Proveedor' : 'Editar Proveedor'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _nameController,
                decoration: InputDecoration(labelText: 'Nombre del proveedor'),
              ),
              TextField(
                controller: _phoneNumberController,
                decoration: InputDecoration(labelText: 'Teléfono'),
              ),
              TextField(
                controller: _rucController,
                decoration: InputDecoration(labelText: 'RUC'),
              ),
            ],
          ),
          actions: [
            TextButton(
              child: Text('Cancelar'),
              onPressed: () => Navigator.of(context).pop(),
            ),
            TextButton(
              child: Text('Guardar'),
              onPressed: () {
                _addOrUpdateProvider(id: id);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Proveedores'),
      ),
      body: ListView.builder(
        itemCount: _providers.length,
        itemBuilder: (context, index) {
          final provider = _providers[index];
          return ListTile(
            title: Text(provider.name),
            subtitle: Text(provider.phoneNumber ?? 'N/A'),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () => _showAddProviderDialog(
                    id: provider.id,
                    initialName: provider.name,
                    initialPhoneNumber: provider.phoneNumber,
                    initialRuc: provider.ruc,
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () => _deleteProviderById(provider.id),
                ),
              ],
            ),
            onTap: () {
              _nameController.text = provider.name;
              _phoneNumberController.text = provider.phoneNumber ?? '';
              _rucController.text = provider.ruc ?? '';
              _showAddProviderDialog(
                id: provider.id,
                initialName: provider.name,
                initialPhoneNumber: provider.phoneNumber,
                initialRuc: provider.ruc,
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddProviderDialog(),
        tooltip: 'Agregar proveedor',
        child: Icon(Icons.add),
      ),
    );
  }
}

