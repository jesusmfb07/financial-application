import 'package:flutter/material.dart';
import 'package:open_file/open_file.dart';
import '../../../../shared/categories/application/use_cases/create_category_use_case.dart';
import '../../../../shared/categories/domain/aggregates/category_aggregate.dart';
import '../../../application/use_cases/create_income_use_case.dart';
import '../../../application/use_cases/get_income_use_case.dart';
import '../../../application/use_cases/update_income_use_case.dart';
import '../../../domain/aggregates/income_aggregate.dart';
import '../../../domain/entities/income_entry_entity.dart';
import '../egress/image_preview_page.dart';
import '../egress/pdf_viewer_page.dart';
import '../file_storage_service.dart';
import 'form/income_entry_form.dart';
import 'income_entry_list.dart';
import '../../../../shared/categories/application/use_cases/get_category_use_case.dart';


  class IncomePage extends StatefulWidget {
    final CreateIncomeEntryUseCase createEntryUseCase;
    final UpdateIncomeEntryUseCase updateEntryUseCase;
    final GetIncomeEntriesUseCase getEntriesUseCase;
    final GetCategoriesUseCase getCategoriesUseCase;
    final CreateCategoryUseCase createCategoryUseCase;
    // final IncomeEntryAggregate aggregate;
    final List<CategoryAggregate> categoryAggregates;
    final String? attachmentPath;
    final String defaultCurrencySymbol; // Añadir propiedad para el símbolo de moneda

    IncomePage({
      required this.createEntryUseCase,
      required this.updateEntryUseCase,
      required this.getEntriesUseCase,
      required this.getCategoriesUseCase,
      required this.createCategoryUseCase,
      // required this.aggregate,
      required this.categoryAggregates,
      this.attachmentPath,
      this.defaultCurrencySymbol = '\$', // Valor predeterminado o especificar el símbolo adecuado
    });

    @override
    _IncomePageState createState() => _IncomePageState();
  }

  class _IncomePageState extends State<IncomePage> {
    final FileStorageService _fileStorageService = FileStorageService();
    List<IncomeEntryAggregate> _incomeEntry =[];
    @override
    void initState() {
      super.initState();
      _loadEntries();
      _loadCategories();
    }

    Future<void> _loadEntries() async {
      final incomeEntries = await widget.getEntriesUseCase.execute();
      setState(() {
        _incomeEntry = incomeEntries;
        // widget.aggregate.entries.clear();
        // widget.aggregate.entries.addAll(entries);
      });
    }

    Future<void> _loadCategories() async {
      final categories = await widget.getCategoriesUseCase.execute();
      setState(() {
        widget.categoryAggregates.clear();
        widget.categoryAggregates.addAll(categories);
      });
    }

    // Future<void> _saveAttachment(File file) async {
    //   final savedFile = await _fileStorageService.saveFile(file);
    //   // Actualiza tu lógica para usar la ruta del archivo guardado.
    // }

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

    void _showEntryDialog({IncomeEntry? entry}) {
      showDialog(
        context: context,
        builder: (context) {
          return IncomeEntryForm(
            createEntryUseCase: widget.createEntryUseCase,
            updateEntryUseCase: widget.updateEntryUseCase,
            // aggregate: widget.aggregate,
            categoryAggregates: widget.categoryAggregates,
            createCategoryUseCase: widget.createCategoryUseCase,
            getCategoriesUseCase: widget.getCategoriesUseCase,
            entry: entry,
            onSave: _loadEntries,
            defaultCurrencySymbol: widget.defaultCurrencySymbol, // Añadir este argumento
          );
        },
      );
    }

    @override
    Widget build(BuildContext context) {
      return Scaffold(
        body: IncomeEntryList(
          getEntriesUseCase: widget.getEntriesUseCase,
          // aggregate: widget.aggregate,
          onEdit: (entry) => _showEntryDialog(entry: entry),
          onViewAttachment: _viewAttachment,
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => _showEntryDialog(),
          child: Icon(Icons.add),
        ),
      );
    }
  }
