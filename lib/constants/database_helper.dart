import 'package:sqflite/sqflite.dart';
import 'dart:io' as io;
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';

import '../models/carts_model.dart';
import '../models/plants_model.dart';

class DBHelper {
  static Database? _db;

  Future<Database?> get db async {
    if (_db != null) {
      return _db!;
    }
    _db = await initDatabase();
  }

  initDatabase() async {
    io.Directory documentDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentDirectory.path, 'cc.db');
    var db = await openDatabase(path, version: 1, onCreate: _onCreate);
    return db;
  }

  _onCreate(Database db, int version) async {
    await db.execute(
        'CREATE TABLE ccc (id INTEGER PRIMARY KEY , productId VARCHAR UNIQUE , productName TEXT , initialPrice INTEGER , productPrice INTEGER , quantity INTEGER , image TEXT)');
  }

  Future<CartModel> insert(CartModel cart) async {
    var dbClient = await db;
    await dbClient!.insert('ccc', cart.productToMap());
    return cart;
  }

  Future<List<CartModel>> getCartList() async {
    var dbClient = await db;
    final List<Map<String, Object?>> queryResult =
        await dbClient!.query('ccc');
    return queryResult.map((e) => CartModel.fromJson(e)).toList();
  }

  Future<int> delete(int id) async {
    var dbClient = await db;
    return await dbClient!.delete(
      'ccc',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<int> updateQuantity(CartModel cart) async {
    var dbClient = await db;
    return await dbClient!.update(
      'ccc',
      cart.productToMap(),
      where: 'id = ?',
      whereArgs: [cart.id],
    );
  }

  
}
