// import 'dart:io'; // Importa dart:io para usar la clase File
// import 'package:path_provider/path_provider.dart';
// import 'package:file_picker/file_picker.dart';
// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// import 'package:open_file/open_file.dart';
// import 'package:flutter_pdfview/flutter_pdfview.dart';
// import '../../../../shared/categories/application/use_cases/category_use_case.dart';
// import '../../../../shared/categories/domain/aggregates/category_aggregate.dart';
// import '../../../../shared/categories/domain/entities/category_entity.dart';
// import '../../application/use_cases/income_use_case.dart';
// import '../../domain/aggregates/income_aggregate.dart';
// import '../../domain/entities/income_entry_entity.dart';
//
// class IncomePage extends StatefulWidget {
//   final CreateIncomeEntryUseCase createEntryUseCase;
//   final UpdateIncomeEntryUseCase updateEntryUseCase;
//   final GetIncomeEntriesUseCase getEntriesUseCase;
//   final GetCategoriesUseCase getCategoriesUseCase;
//   final IncomeEntryAggregate aggregate;
//   final CategoryAggregate categoryAggregate;
//   final String? attachmentPath;
//
//   IncomePage({
//     required this.createEntryUseCase,
//     required this.updateEntryUseCase,
//     required this.getEntriesUseCase,
//     required this.getCategoriesUseCase,
//     required this.aggregate,
//     required this.categoryAggregate,
//     this.attachmentPath,
//   });
//
//   @override
//   _IncomePageState createState() => _IncomePageState();
// }
//
// class _IncomePageState extends State<IncomePage> {
//   final TextEditingController _descriptionController = TextEditingController();
//   final TextEditingController _amountController = TextEditingController();
//   final TextEditingController _dateController = TextEditingController();
//   String? _selectedCategory;
//   String? _attachmentPath;
//
//   @override
//   void initState() {
//     super.initState();
//     _dateController.text = DateFormat('yyyy-MM-dd').format(DateTime.now());
//     _loadEntries();
//     _loadCategories();
//   }
//
//   Future<void> _loadEntries() async {
//     final entries = await widget.getEntriesUseCase.execute(widget.aggregate);
//     setState(() {
//       widget.aggregate.entries.clear();
//       widget.aggregate.entries.addAll(entries);
//     });
//   }
//
//   Future<void> _loadCategories() async {
//     final categories = await widget.getCategoriesUseCase.execute(widget.categoryAggregate);
//     setState(() {
//       widget.categoryAggregate.categories.clear();
//       widget.categoryAggregate.categories.addAll(categories);
//     });
//   }
//
//   Future<String> _saveFileLocally(String filePath) async {
//     final directory = await getApplicationDocumentsDirectory();
//     final fileName = filePath.split('/').last;
//     final localPath = '${directory.path}/$fileName';
//     final localFile = await File(filePath).copy(localPath);
//     return localFile.path;
//   }
//
//   void _addEntry() async {
//     final description = _descriptionController.text;
//     final amount = double.tryParse(_amountController.text) ?? 0.0;
//     final category = _selectedCategory;
//     final date = DateFormat('yyyy-MM-dd').parse(_dateController.text);
//
//     if (description.isNotEmpty && amount > 0 && category != null && category.isNotEmpty) {
//       final attachmentPath = _attachmentPath != null ? await _saveFileLocally(_attachmentPath!) : null;
//       final entry = IncomeEntry(
//         description: description,
//         amount: amount,
//         date: date,
//         category: category,
//         attachmentPath: attachmentPath,
//       );
//       await widget.createEntryUseCase.execute(widget.aggregate, entry);
//       _loadEntries();
//       _clearFields();
//     }
//   }
//
//   void _updateEntry(IncomeEntry entry) async {
//     final description = _descriptionController.text;
//     final amount = double.tryParse(_amountController.text) ?? 0.0;
//     final category = _selectedCategory;
//     final date = DateFormat('yyyy-MM-dd').parse(_dateController.text);
//
//     if (description.isNotEmpty && amount > 0 && category != null && category.isNotEmpty) {
//       final attachmentPath = _attachmentPath != null ? await _saveFileLocally(_attachmentPath!) : entry.attachmentPath;
//       final updatedEntry = IncomeEntry(
//         id: entry.id,
//         description: description,
//         amount: amount,
//         date: date,
//         category: category,
//         attachmentPath: attachmentPath,
//       );
//       await widget.updateEntryUseCase.execute(widget.aggregate, updatedEntry);
//       _loadEntries();
//       _clearFields();
//     }
//   }
//
//   void _clearFields() {
//     _descriptionController.clear();
//     _amountController.clear();
//     _selectedCategory = null;
//     _dateController.text = DateFormat('yyyy-MM-dd').format(DateTime.now());
//     _attachmentPath = null;
//   }
//
//   void _showEntryDialog({IncomeEntry? entry}) {
//     if (entry != null) {
//       _descriptionController.text = entry.description;
//       _amountController.text = entry.amount.toString();
//       _selectedCategory = entry.category;
//       _dateController.text = DateFormat('yyyy-MM-dd').format(entry.date);
//       _attachmentPath = entry.attachmentPath;
//     } else {
//       _clearFields();
//     }
//
//     showDialog(
//       context: context,
//       builder: (context) {
//         return AlertDialog(
//           title: Center(child: Text(entry == null ? 'Nuevo Ingreso' : 'Editar Ingreso')),
//           content: Container(
//             width: MediaQuery.of(context).size.width * 0.8,
//             child: SingleChildScrollView(
//               child: Column(
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   TextField(
//                     controller: _dateController,
//                     readOnly: true,
//                     decoration: InputDecoration(
//                       labelText: 'Fecha',
//                       suffixIcon: IconButton(
//                         icon: Icon(Icons.calendar_today),
//                         onPressed: () async {
//                           DateTime? pickedDate = await showDatePicker(
//                             context: context,
//                             initialDate: DateTime.now(),
//                             firstDate: DateTime(2000),
//                             lastDate: DateTime(2101),
//                           );
//                           if (pickedDate != null) {
//                             setState(() {
//                               _dateController.text = DateFormat('yyyy-MM-dd').format(pickedDate);
//                             });
//                           }
//                         },
//                       ),
//                     ),
//                   ),
//                   SizedBox(height: 16.0),
//                   TextField(
//                     controller: _amountController,
//                     keyboardType: TextInputType.numberWithOptions(decimal: true),
//                     decoration: InputDecoration(labelText: 'Monto'),
//                   ),
//                   SizedBox(height: 16.0),
//                   TextField(
//                     controller: _descriptionController,
//                     decoration: InputDecoration(labelText: 'Descripción'),
//                   ),
//                   SizedBox(height: 16.0),
//                   DropdownButtonFormField<String>(
//                     value: _selectedCategory,
//                     decoration: InputDecoration(labelText: 'Categoría'),
//                     items: widget.categoryAggregate.categories.map((Category category) {
//                       return DropdownMenuItem<String>(
//                         value: category.name,
//                         child: Text(category.name),
//                       );
//                     }).toList(),
//                     onChanged: (newValue) {
//                       setState(() {
//                         _selectedCategory = newValue;
//                       });
//                     },
//                   ),
//                   SizedBox(height: 16.0),
//                   ElevatedButton(
//                     onPressed: () async {
//                       final result = await FilePicker.platform.pickFiles();
//                       if (result != null) {
//                         setState(() {
//                           _attachmentPath = result.files.single.path!;
//                         });
//                       }
//                     },
//                     child: Text('Adjuntar imagen/documento'),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//           actions: [
//             Center(
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                 children: [
//                   TextButton(
//                     onPressed: () => Navigator.pop(context),
//                     child: Text('Cancelar'),
//                   ),
//                   TextButton(
//                     onPressed: () {
//                       if (entry == null) {
//                         _addEntry();
//                       } else {
//                         _updateEntry(entry);
//                       }
//                       Navigator.pop(context);
//                     },
//                     child: Text(entry == null ? 'Agregar' : 'Actualizar'),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         );
//       },
//     );
//   }
//
//   void _viewAttachment(String path) {
//     if (path.toLowerCase().endsWith('.jpg') ||
//         path.toLowerCase().endsWith('.jpeg') ||
//         path.toLowerCase().endsWith('.png')) {
//       Navigator.push(
//         context,
//         MaterialPageRoute(
//           builder: (context) => ImagePreviewPage(imagePath: path),
//         ),
//       );
//     } else if (path.toLowerCase().endsWith('.pdf')) {
//       Navigator.push(
//         context,
//         MaterialPageRoute(
//           builder: (context) => PDFViewerPage(pdfPath: path),
//         ),
//       );
//     } else {
//       OpenFile.open(path);
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: FutureBuilder<List<IncomeEntry>>(
//         future: widget.getEntriesUseCase.execute(widget.aggregate),
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return Center(child: CircularProgressIndicator());
//           } else if (snapshot.hasError) {
//             return Center(child: Text('Error: ${snapshot.error}'));
//           } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
//             return Center(child: Text('No hay ingresos'));
//           } else {
//             return ListView.builder(
//               itemCount: snapshot.data!.length,
//               itemBuilder: (context, index) {
//                 final entry = snapshot.data![index];
//                 return Container(
//                   margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
//                   padding: EdgeInsets.all(16.0),
//                   decoration: BoxDecoration(
//                     color: Colors.white,
//                     borderRadius: BorderRadius.circular(8.0),
//                     boxShadow: [
//                       BoxShadow(
//                         color: Colors.black12,
//                         blurRadius: 4.0,
//                         offset: Offset(0, 2),
//                       ),
//                     ],
//                   ),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         'Fecha: ${DateFormat('yyyy-MM-dd').format(entry.date)}',
//                         style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
//                       ),
//                       Text(
//                         'Monto: \$${entry.amount.toStringAsFixed(2)}',
//                         style: TextStyle(fontSize: 16.0),
//                       ),
//                       Text(
//                         'Descripción: ${entry.description}',
//                         style: TextStyle(fontSize: 16.0),
//                       ),
//                       Text(
//                         'Categoría: ${entry.category}',
//                         style: TextStyle(fontSize: 16.0),
//                       ),
//                       SizedBox(height: 16.0),
//                       if (entry.attachmentPath != null)
//                         GestureDetector(
//                           onTap: () => _viewAttachment(entry.attachmentPath!),
//                           child: Container(
//                             width: double.infinity,
//                             height: 100,
//                             decoration: BoxDecoration(
//                               borderRadius: BorderRadius.circular(8.0),
//                               image: entry.attachmentPath!.toLowerCase().endsWith('.pdf')
//                                   ? null
//                                   : DecorationImage(
//                                 fit: BoxFit.cover,
//                                 image: FileImage(File(entry.attachmentPath!)),
//                               ),
//                             ),
//                             child: entry.attachmentPath!.toLowerCase().endsWith('.pdf')
//                                 ? Center(
//                               child: Icon(
//                                 Icons.picture_as_pdf,
//                                 size: 50,
//                                 color: Colors.red,
//                               ),
//                             )
//                                 : null,
//                           ),
//                         )
//                       else
//                         Container(
//                           width: double.infinity,
//                           height: 100,
//                           decoration: BoxDecoration(
//                             color: Colors.grey[300],
//                             borderRadius: BorderRadius.circular(8.0),
//                           ),
//                           child: Icon(Icons.insert_drive_file, color: Colors.grey[600]),
//                         ),
//                       Align(
//                         alignment: Alignment.topRight,
//                         child: IconButton(
//                           icon: Icon(Icons.edit),
//                           onPressed: () => _showEntryDialog(entry: entry),
//                         ),
//                       ),
//                     ],
//                   ),
//                 );
//               },
//             );
//           }
//         },
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () => _showEntryDialog(),
//         child: Icon(Icons.add),
//       ),
//     );
//   }
// }
//
// class ImagePreviewPage extends StatelessWidget {
//   final String imagePath;
//
//   ImagePreviewPage({required this.imagePath});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Vista previa de la imagen'),
//       ),
//       body: Center(
//         child: Image.file(File(imagePath)),
//       ),
//     );
//   }
// }
//
// class PDFViewerPage extends StatelessWidget {
//   final String pdfPath;
//
//   PDFViewerPage({required this.pdfPath});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Vista previa del PDF'),
//       ),
//       body: PDFView(
//         filePath: pdfPath,
//       ),
//     );
//   }
// }
