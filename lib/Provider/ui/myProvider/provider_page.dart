// ui/pages/provider_page.dart
import 'package:flutter/material.dart';
import '../../application/use_cases/provider_use_case.dart';
import '../../domain/aggregates/provider_aggregate.dart';
import '../../domain/entities/provider_entity.dart';


class ProviderPage extends StatefulWidget {
  final CreateProviderUseCase createProviderUseCase;
  final UpdateProviderUseCase updateProviderUseCase;
  final DeleteProviderUseCase deleteProviderUseCase;
  final GetProvidersUseCase getProvidersUseCase;
  final ProviderAggregate aggregate;

  ProviderPage({
    required this.createProviderUseCase,
    required this.updateProviderUseCase,
    required this.deleteProviderUseCase,
    required this.getProvidersUseCase,
    required this.aggregate,
  });

  @override
  _ProviderPageState createState() => _ProviderPageState();
}

class _ProviderPageState extends State<ProviderPage> {
  final TextEditingController _providerNameController = TextEditingController();
  final TextEditingController _providerContactInfoController = TextEditingController();
  final TextEditingController _providerContactNumberController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadProviders();
  }

  Future<void> _loadProviders() async {
    final providers = await widget.getProvidersUseCase.execute(widget.aggregate);
    setState(() {
      widget.aggregate.providers.clear();
      widget.aggregate.providers.addAll(providers);
    });
  }

  Future<void> _addOrUpdateProvider({String? id}) async {
    if (_providerNameController.text.isEmpty || _providerContactInfoController.text.isEmpty||_providerContactNumberController.text.isEmpty) return;

    final provider = Provider(
      id: id ?? DateTime.now().toString(),
      name: _providerNameController.text,
      contactInfo: _providerContactInfoController.text,
      contactNumber: _providerContactNumberController.text,
    );
    if (id == null) {
      await widget.createProviderUseCase.execute(widget.aggregate, provider);
    } else {
      await widget.updateProviderUseCase.execute(widget.aggregate, provider);
    }
    _providerNameController.clear();
    _providerContactInfoController.clear();
    _providerContactNumberController.clear();
    _loadProviders();
  }

  Future<void> _deleteProviderById(String id) async {
    final provider = widget.aggregate.providers.firstWhere((p) => p.id == id);
    await widget.deleteProviderUseCase.execute(widget.aggregate, provider);
    _loadProviders();
  }

  void _showAddProviderDialog({String? id, String? initialName, String? initialContactInfo}) {
    if (initialName != null && initialContactInfo != null) {
      _providerNameController.text = initialName;
      _providerContactInfoController.text = initialContactInfo;
    } else {
      _providerNameController.clear();
      _providerContactInfoController.clear();
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
                controller: _providerNameController,
                decoration: InputDecoration(labelText: 'Nombre del proveedor'),
              ),
              TextField(
                controller: _providerContactInfoController,
                decoration: InputDecoration(labelText: 'RUC'),
              ),
              TextField(
                controller: _providerContactNumberController,
                decoration: InputDecoration(labelText: 'Telefono'),
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
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: widget.aggregate.providers.length,
              itemBuilder: (context, index) {
                final provider = widget.aggregate.providers[index];
                return ListTile(
                  title: Text(provider.name),
                  subtitle: Text(provider.contactInfo),
                  trailing: IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () => _deleteProviderById(provider.id),
                  ),
                  onTap: () => _showAddProviderDialog(
                    id: provider.id,
                    initialName: provider.name,
                    initialContactInfo: provider.contactInfo,
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => _showAddProviderDialog(),
      ),
    );
  }
}
