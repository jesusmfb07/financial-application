import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../../domain/entities/currency_entity.dart';
import '../../application/ports/currency_port.dart';
import '../mappers/currency_mapper.dart';

class CurrencySQLiteAdapter implements CurrencyPort {
  static final CurrencySQLiteAdapter _instance = CurrencySQLiteAdapter._internal();
  Database? _database;

  factory CurrencySQLiteAdapter() {
    return _instance;
  }

  CurrencySQLiteAdapter._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final databasePath = await getDatabasesPath();
    final path = join(databasePath, 'currencies.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE currencies (
            code TEXT PRIMARY KEY,
            name TEXT
          )
        ''');
        await db.execute('''
          CREATE TABLE default_currency (
            code TEXT PRIMARY KEY
          )
        ''');
        print('Database and tables created');
      },
    );
  }

  @override
  Future<List<Currency>> getCurrencies() async {
    final db = await database;
    final result = await db.query('currencies');
    print('Fetched currencies: $result');
    return result.map((map) => CurrencyMapper.fromMap(map)).toList();
  }

  @override
  Future<Currency?> getDefaultCurrency() async {
    final db = await database;
    final result = await db.query('default_currency');
    if (result.isNotEmpty) {
      final defaultCurrencyCode = result.first['code'] as String;
      print('Retrieved default currency code: $defaultCurrencyCode');
      final currencyResult = await db.query(
        'currencies',
        where: 'code = ?',
        whereArgs: [defaultCurrencyCode],
      );
      print('Fetched currency for code $defaultCurrencyCode: $currencyResult');
      if (currencyResult.isNotEmpty) {
        return CurrencyMapper.fromMap(currencyResult.first);
      }
    }
    return null;
  }

  @override
  Future<void> setDefaultCurrency(String currencyCode) async {
    final db = await database;
    await db.delete('default_currency');
    await db.insert('default_currency', {'code': currencyCode});
    print('Set default currency to: $currencyCode');
  }

  Future<void> initializeCurrencies(List<Currency> currencies) async {
    final db = await database;
    await db.transaction((txn) async {
      for (var currency in currencies) {
        await txn.insert(
          'currencies',
          CurrencyMapper.toMap(currency),
          conflictAlgorithm: ConflictAlgorithm.replace,
        );
      }
    });
    print('Initialized currencies: ${currencies.map((e) => e.code).toList()}');
  }
}
