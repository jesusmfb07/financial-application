import 'dart:io';
import 'package:flutter/material.dart';
import 'package:open_file/open_file.dart';
import '../../../../shared/categories/application/use_cases/create_category_use_case.dart';
import '../../../../shared/categories/application/use_cases/get_category_use_case.dart';
import '../../../../shared/categories/domain/aggregates/category_aggregate.dart';
import '../../../../shared/providers/application/use_cases/provider_use_case.dart';
import '../../../../shared/providers/domain/aggregates/provider_aggregate.dart';
import '../../../application/use_cases/egress_use_case.dart';
import '../../../application/use_cases/get_egress_use_case.dart';
import '../../../domain/aggregates/egress_aggregate.dart';
import '../../../domain/entities/egress_entry_entity.dart';
import '../file_storage_service.dart';
import 'egress_entry_list.dart';
import 'form/egress_entry_form.dart';
import 'image_preview_page.dart';
import 'pdf_viewer_page.dart';

class EgressPage extends StatefulWidget {
  final CreateEgressEntryUseCase createEntryUseCase;
  final UpdateEgressEntryUseCase updateEntryUseCase;
  final GetEgressEntriesUseCase getEntriesUseCase;
  final GetCategoriesUseCase getCategoriesUseCase;
  final CreateCategoryUseCase createCategoryUseCase;
  final GetProvidersUseCase getProvidersUseCase;
  final CreateProviderUseCase createProviderUseCase;
  final EgressEntryAggregate aggregate;
  final List<CategoryAggregate> categoryAggregates;
  final List<ProviderAggregate> providerAggregates;
  final String? attachmentPath;
  final String defaultCurrencySymbol;

  EgressPage({
    required this.createEntryUseCase,
    required this.updateEntryUseCase,
    required this.getEntriesUseCase,
    required this.getCategoriesUseCase,
    required this.createCategoryUseCase,
    required this.getProvidersUseCase,
    required this.createProviderUseCase,
    required this.aggregate,
    required this.categoryAggregates,
    required this.providerAggregates,
    this.attachmentPath,
    this.defaultCurrencySymbol = '\$',
  });

  @override
  _EgressPageState createState() => _EgressPageState();
}

class _EgressPageState extends State<EgressPage> {
  final FileStorageService _fileStorageService = FileStorageService();

  @override
  void initState() {
    super.initState();
    _loadEntries();
    _loadCategories();
    _loadProviders();
  }

  Future<void> _loadEntries() async {
    final entries = await widget.getEntriesUseCase.execute(widget.aggregate);
    setState(() {
      widget.aggregate.entries.clear();
      widget.aggregate.entries.addAll(entries);
    });
  }

  Future<void> _loadCategories() async {
    final categories = await widget.getCategoriesUseCase.execute();
    setState(() {
      widget.categoryAggregates.clear();
      widget.categoryAggregates.addAll(categories);
    });
  }


  Future<void> _loadProviders() async {
    final providers = await widget.getProvidersUseCase.execute();
    setState(() {
      widget.providerAggregates.clear();
      widget.providerAggregates.addAll(providers);
    });
  }


  void _viewAttachment(String path) {
    if (path.toLowerCase().endsWith('.jpg') ||
        path.toLowerCase().endsWith('.jpeg') ||
        path.toLowerCase().endsWith('.png')) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ImagePreviewPage(imagePath: path),
        ),
      );
    } else if (path.toLowerCase().endsWith('.pdf')) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => PDFViewerPage(pdfPath: path),
        ),
      );
    } else {
      OpenFile.open(path);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: EgressEntryList(
        getEntriesUseCase: widget.getEntriesUseCase,
        aggregate: widget.aggregate,
        onEdit: (entry) => _showEntryDialog(entry: entry),
        onViewAttachment: _viewAttachment,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showEntryDialog(),
        child: Icon(Icons.add),
      ),
    );
  }

  void _showEntryDialog({EgressEntry? entry}) {
    showDialog(
      context: context,
      builder: (context) {
        return EgressEntryForm(
          createEntryUseCase: widget.createEntryUseCase,
          updateEntryUseCase: widget.updateEntryUseCase,
          aggregate: widget.aggregate,
          categoryAggregates: widget.categoryAggregates,
          getCategoriesUseCase: widget.getCategoriesUseCase,
          createCategoryUseCase: widget.createCategoryUseCase,
          providerAggregate: widget.providerAggregates,
          getProvidersUseCase: widget.getProvidersUseCase,
          createProviderUseCase: widget.createProviderUseCase,
          entry: entry,
          onSave: _loadEntries,
          defaultCurrencySymbol: widget.defaultCurrencySymbol,
        );
      },
    );
  }
}
