// import 'package:flutter/material.dart';
// import '../../ui/navigation_bar_page.dart';
// import '../application/use_cases/currency_use_case.dart';
// import '../domain/aggregates/currency_aggregate.dart';
// import '../domain/entities/currency_entity.dart';
// import '../infrastructure/adapters/currency_adapter.dart';
//
//
// class CurrencyPage extends StatefulWidget {
//   final GetCurrenciesUseCase getCurrenciesUseCase;
//   final GetDefaultCurrencyUseCase getDefaultCurrencyUseCase;
//   final SetDefaultCurrencyUseCase setDefaultCurrencyUseCase;
//   final CurrencyAggregate aggregate;
//
//   CurrencyPage({
//     required this.getCurrenciesUseCase,
//     required this.getDefaultCurrencyUseCase,
//     required this.setDefaultCurrencyUseCase,
//     required this.aggregate,
//   });
//
//   @override
//   _CurrencyPageState createState() => _CurrencyPageState();
// }
//
// class _CurrencyPageState extends State<CurrencyPage> with WidgetsBindingObserver {
//   // int _selectedIndex = 3;
//   Currency? _defaultCurrency;
//   final CurrencySQLiteAdapter _currencyAdapter = CurrencySQLiteAdapter();
//
//   @override
//   void initState() {
//     super.initState();
//     WidgetsBinding.instance.addObserver(this);
//     _initializeCurrencies().then((_) {
//       _loadCurrencies();
//       _loadDefaultCurrency();
//     });
//   }
//
//   Future<void> _initializeCurrencies() async {
//     final initialCurrencies = [
//       Currency(name: 'Dólar', code: 'USD'),
//       Currency(name: 'Euro', code: 'EUR'),
//       Currency(name: 'Sol', code: 'PEN'),
//       // Currency(name: 'Yen', code: 'JPY'),
//       // Currency(name: 'Libra', code: 'GBP'),
//       // Currency(name: 'Dólar Australiano', code: 'AUD'),
//       // Currency(name: 'Dólar Canadiense', code: 'CAD'),
//       // Currency(name: 'Franco Suizo', code: 'CHF'),
//       // Currency(name: 'Yuan Chino', code: 'CNY'),
//       // Currency(name: 'Rupia India', code: 'INR'),
//     ];
//     await _currencyAdapter.initializeCurrencies(initialCurrencies);
//     print('Initialized currencies: ${initialCurrencies.map((e) => e.code).toList()}');
//   }
//
//   @override
//   void dispose() {
//     WidgetsBinding.instance.removeObserver(this);
//     super.dispose();
//   }
//
//   @override
//   void didChangeAppLifecycleState(AppLifecycleState state) {
//     if (state == AppLifecycleState.resumed) {
//       _loadDefaultCurrency();
//     }
//   }
//
//   Future<void> _loadCurrencies() async {
//     final currencies = await widget.getCurrenciesUseCase.execute(widget.aggregate);
//     setState(() {
//       widget.aggregate.addCurrencies(currencies);
//     });
//     print('Fetched currencies: ${currencies.map((e) => e.code).toList()}');
//   }
//
//   Future<void> _loadDefaultCurrency() async {
//     final defaultCurrency = await widget.getDefaultCurrencyUseCase.execute(widget.aggregate);
//     setState(() {
//       _defaultCurrency = defaultCurrency;
//       print('Loaded default currency: $_defaultCurrency');
//     });
//   }
//
//   Future<void> _setDefaultCurrency(Currency currency) async {
//     await widget.setDefaultCurrencyUseCase.execute(widget.aggregate, currency.code);
//     setState(() {
//       _defaultCurrency = currency;
//     });
//     print('Set default currency to: ${currency.code}');
//   }
//
//   void _showSetDefaultCurrencyDialog(Currency currency) {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: Text('Establecer como predeterminada'),
//           content: Text('¿Deseas establecer ${currency.name} como moneda predeterminada?'),
//           actions: <Widget>[
//             Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 TextButton(
//                   child: Text('Cancelar'),
//                   onPressed: () {
//                     Navigator.of(context).pop();
//                   },
//                 ),
//                 SizedBox(width: 20),
//                 TextButton(
//                   child: Text('Aceptar'),
//                   onPressed: () {
//                     _setDefaultCurrency(currency);
//                     Navigator.of(context).pop();
//                   },
//                 ),
//               ],
//             ),
//           ],
//         );
//       },
//     );
//   }
//
//   // void _onItemTapped(int index) {
//   //   setState(() {
//   //     _selectedIndex = index;
//   //   });
//   // }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Text('Moneda:'),
//             if (_defaultCurrency != null)
//               Text(
//                 _defaultCurrency!.name,
//                 style: TextStyle(fontWeight: FontWeight.bold),
//               ),
//           ],
//         ),
//         centerTitle: true,
//       ),
//       body: ListView.builder(
//         itemCount: widget.aggregate.currencies.length,
//         itemBuilder: (context, index) {
//           final currency = widget.aggregate.currencies[index];
//           final isDefault = currency.code == _defaultCurrency?.code;
//           return ListTile(
//             title: Row(
//               children: [
//                 CircleAvatar(
//                   radius: 20,
//                   child: Text(currency.code),
//                 ),
//                 SizedBox(width: 10),
//                 Text(currency.name),
//               ],
//             ),
//             trailing: GestureDetector(
//               onTap: () => _showSetDefaultCurrencyDialog(currency),
//               child: Container(
//                 width: 24,
//                 height: 24,
//                 decoration: BoxDecoration(
//                   shape: BoxShape.circle,
//                   border: Border.all(
//                     color: isDefault ? Colors.green : Colors.grey,
//                     width: 2,
//                   ),
//                 ),
//                 child: isDefault
//                     ? Center(
//                   child: Container(
//                     width: 12,
//                     height: 12,
//                     decoration: BoxDecoration(
//                       shape: BoxShape.circle,
//                       color: Colors.green,
//                     ),
//                   ),
//                 )
//                     : null,
//               ),
//             ),
//           );
//         },
//       ),
//       // bottomNavigationBar: CustomBottomNavigationBar(
//       //   currentIndex: _selectedIndex,
//       //   onTap: _onItemTapped,
//       // ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import '../application/use_cases/currency_use_case.dart';
import '../domain/aggregates/currency_aggregate.dart';
import '../domain/entities/currency_entity.dart';
import '../global_config.dart';
import '../infrastructure/adapters/currency_adapter.dart';

class CurrencyPage extends StatefulWidget {
  final GetCurrenciesUseCase getCurrenciesUseCase;
  final GetDefaultCurrencyUseCase getDefaultCurrencyUseCase;
  final SetDefaultCurrencyUseCase setDefaultCurrencyUseCase;
  final CurrencyAggregate aggregate;

  CurrencyPage({
    required this.getCurrenciesUseCase,
    required this.getDefaultCurrencyUseCase,
    required this.setDefaultCurrencyUseCase,
    required this.aggregate,
  });

  @override
  _CurrencyPageState createState() => _CurrencyPageState();
}

class _CurrencyPageState extends State<CurrencyPage> with WidgetsBindingObserver {
  Currency? _defaultCurrency;
  final CurrencySQLiteAdapter _currencyAdapter = CurrencySQLiteAdapter();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _initializeCurrencies().then((_) {
      _loadCurrencies();
      _loadDefaultCurrency();
    });
  }

  Future<void> _initializeCurrencies() async {
    final initialCurrencies = [
      Currency(name: 'Sol', code: 'S/'),
      Currency(name: 'Dolar', code: '\$'),
      Currency(name: 'Euro', code: '€'),
    ];
    await _currencyAdapter.initializeCurrencies(initialCurrencies);
    print('Initialized currencies: ${initialCurrencies.map((e) => e.code).toList()}');
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      _loadDefaultCurrency();
    }
  }

  Future<void> _loadCurrencies() async {
    final currencies = await widget.getCurrenciesUseCase.execute(widget.aggregate);
    setState(() {
      widget.aggregate.addCurrencies(currencies);
    });
    print('Fetched currencies: ${currencies.map((e) => e.code).toList()}');
  }

  Future<void> _loadDefaultCurrency() async {
    final defaultCurrency = await widget.getDefaultCurrencyUseCase.execute(widget.aggregate);
    if (defaultCurrency != null) {
      setState(() {
        _defaultCurrency = defaultCurrency;
        GlobalConfig().setDefaultCurrency(defaultCurrency); // Actualiza la configuración global
        print('Loaded default currency: $_defaultCurrency');
      });
    } else {
      print('No default currency found');
    }
  }

  Future<void> _setDefaultCurrency(Currency currency) async {
    await widget.setDefaultCurrencyUseCase.execute(widget.aggregate, currency.code);
    setState(() {
      _defaultCurrency = currency;
      GlobalConfig().setDefaultCurrency(currency); // Actualiza la configuración global
    });
    print('Set default currency to: ${currency.code}');
  }

  void _showSetDefaultCurrencyDialog(Currency currency) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Establecer como predeterminada'),
          content: Text('¿Deseas establecer ${currency.name} como moneda predeterminada?'),
          actions: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                  child: Text('Cancelar'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                SizedBox(width: 20),
                TextButton(
                  child: Text('Aceptar'),
                  onPressed: () {
                    _setDefaultCurrency(currency);
                    Navigator.of(context).pop();
                  },
                ),
              ],
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
        title: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Moneda:'),
            if (_defaultCurrency != null)
              Text(
                _defaultCurrency!.name,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
          ],
        ),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: widget.aggregate.currencies.length,
        itemBuilder: (context, index) {
          final currency = widget.aggregate.currencies[index];
          final isDefault = currency.code == _defaultCurrency?.code;
          return ListTile(
            title: Row(
              children: [
                CircleAvatar(
                  radius: 20,
                  child: Text(currency.code),
                ),
                SizedBox(width: 10),
                Text(currency.name),
              ],
            ),
            trailing: GestureDetector(
              onTap: () => _showSetDefaultCurrencyDialog(currency),
              child: Container(
                width: 24,
                height: 24,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: isDefault ? Colors.green : Colors.grey,
                    width: 2,
                  ),
                ),
                child: isDefault
                    ? Center(
                  child: Container(
                    width: 12,
                    height: 12,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.green,
                    ),
                  ),
                )
                    : null,
              ),
            ),
          );
        },
      ),
    );
  }
}
