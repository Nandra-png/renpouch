import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('renpouch.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path,
        version: 2, onCreate: _createDB, onUpgrade: _onUpgrade);
  }

  Future _createDB(Database db, int version) async {
    const idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    const textType = 'TEXT NOT NULL';
    const doubleType = 'REAL NOT NULL';

    // Tabel untuk user profile
    await db.execute('''
    CREATE TABLE user_profile (
      id $idType,
      name $textType
    )
    ''');

    // Tabel untuk transaksi
    await db.execute('''
    CREATE TABLE transactions (
      id $idType,
      type $textType,
      amount $doubleType,
      date $textType,
      message $textType
    )
    ''');

    // Tabel untuk balance
    await db.execute('''
    CREATE TABLE balance (
      id $idType,
      amount $doubleType,
      totalDepositsThisMonth $doubleType,
      totalWithdrawalsThisMonth $doubleType
    )
    ''');

    // Inisialisasi default
    await db.insert('user_profile', {'name': '@none'});
    await db.insert('balance', {
      'amount': 0.0,
      'totalDepositsThisMonth': 0.0,
      'totalWithdrawalsThisMonth': 0.0,
    });
  }

  Future<void> _onUpgrade(Database db, int oldVersion, int newVersion) async {
    if (oldVersion < 2) {
      await db.execute(
          'CREATE TABLE IF NOT EXISTS user_profile (id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT NOT NULL)');
      await db
          .insert('user_profile', {'name': '@none'}); // Initialize with default
    }
  }

  // Fungsi untuk user profile
  Future<String> getUserName() async {
    final db = await instance.database;
    final result = await db.query('user_profile', limit: 1);
    return result.isNotEmpty ? result.first['name'] as String : '@none';
  }

  Future<void> updateUserName(String name) async {
    final db = await instance.database;
    await db.update('user_profile', {'name': name},
        where: 'id = ?', whereArgs: [1]);
  }

  // Fungsi untuk balance
  Future<double> loadBalance() async {
    final db = await instance.database;
    final result = await db.query('balance', where: 'id = ?', whereArgs: [1]);
    return result.isNotEmpty ? result.first['amount'] as double : 0.0;
  }

  Future<void> saveBalance(double newBalance) async {
    final db = await instance.database;
    await db.update('balance', {'amount': newBalance},
        where: 'id = ?', whereArgs: [1]);
  }

  Future<Map<String, double>> loadMonthlyTotals() async {
    final db = await instance.database;
    final result = await db.query('balance', where: 'id = ?', whereArgs: [1]);
    return result.isNotEmpty
        ? {
            'totalDeposits': result.first['totalDepositsThisMonth'] as double,
            'totalWithdrawals':
                result.first['totalWithdrawalsThisMonth'] as double,
          }
        : {'totalDeposits': 0.0, 'totalWithdrawals': 0.0};
  }

  Future<void> saveMonthlyTotals(double deposits, double withdrawals) async {
    final db = await instance.database;
    await db.update(
        'balance',
        {
          'totalDepositsThisMonth': deposits,
          'totalWithdrawalsThisMonth': withdrawals,
        },
        where: 'id = ?',
        whereArgs: [1]);
  }

  // Fungsi untuk transaksi
  Future<int> insertTransaction(Map<String, dynamic> transaction) async {
    final db = await instance.database;
    return await db.insert('transactions', transaction);
  }

  Future<List<Map<String, dynamic>>> getAllTransactions() async {
    final db = await instance.database;
    return await db.query('transactions');
  }

  Future<int> deleteTransaction(int id) async {
    final db = await instance.database;
    return await db.delete('transactions', where: 'id = ?', whereArgs: [id]);
  }

  Future<int> clearTransactions() async {
    final db = await instance.database;
    return await db.delete('transactions');
  }

  Future<void> resetMonthlyTotals() async {
    final db = await instance.database;
    await db.update(
        'balance',
        {
          'totalDepositsThisMonth': 0.0,
          'totalWithdrawalsThisMonth': 0.0,
        },
        where: 'id = ?',
        whereArgs: [1]);
  }
}
