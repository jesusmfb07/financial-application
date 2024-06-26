import 'package:flutter/material.dart';
import '../../../ui/navigation_bar_page.dart';
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
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _rucController = TextEditingController();
  int _selectedIndex = 3; // Set the initial index to 3 (Settings)

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
    if (_nameController.text.isEmpty) return;

    final provider = Provider(
      id: id ?? DateTime.now().toString(),
      name: _nameController.text,
      phoneNumber: _phoneNumberController.text.isNotEmpty
          ? int.tryParse(_phoneNumberController.text)
          : null,
      ruc: _rucController.text.isNotEmpty ? int.tryParse(_rucController.text) : null,
    );

    if (id == null) {
      await widget.createProviderUseCase.execute(widget.aggregate, provider);
    } else {
      await widget.updateProviderUseCase.execute(widget.aggregate, provider);
    }

    _nameController.clear();
    _phoneNumberController.clear();
    _rucController.clear();
    await _loadProviders(); // Ensure the providers list is updated
  }

  Future<void> _deleteProviderById(String id) async {
    final provider = widget.aggregate.providers.firstWhere((p) => p.id == id);
    await widget.deleteProviderUseCase.execute(widget.aggregate, provider);
    await _loadProviders(); // Ensure the providers list is updated
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
              onPressed: () async {
                await _addOrUpdateProvider(id: id);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    // Aquí puedes agregar la lógica para cambiar de página o actualizar el contenido según el índice seleccionado
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Proveedores'),
      ),
      body: ListView.builder(
        itemCount: widget.aggregate.providers.length,
        itemBuilder: (context, index) {
          final provider = widget.aggregate.providers[index];
          return ListTile(
            title: Text(provider.name),
            subtitle: Text(provider.phoneNumber?.toString() ?? 'N/A'),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () => _showAddProviderDialog(
                    id: provider.id,
                    initialName: provider.name,
                    initialPhoneNumber: provider.phoneNumber?.toString(),
                    initialRuc: provider.ruc?.toString(),
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
              _phoneNumberController.text = provider.phoneNumber?.toString() ?? '';
              _rucController.text = provider.ruc?.toString() ?? '';
              _showAddProviderDialog(
                id: provider.id,
                initialName: provider.name,
                initialPhoneNumber: provider.phoneNumber?.toString(),
                initialRuc: provider.ruc?.toString(),
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
      bottomNavigationBar: CustomBottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
