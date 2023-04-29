import 'dart:io';

import 'package:new_shopping_cart/modals/add_product_modal.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DataBaseHelper {
  static Database? _database;

  static Future<Database?> get database async {
    if (_database != null) {
      return _database;
    } else {
      _database = await initDataBase();
      return _database;
    }
  }

  static Future<Database> initDataBase() async {
    String databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'shopping_cart.db');
    Database database = await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute(
            "CREATE TABLE ProductsDetails (id INTEGER PRIMARY KEY AUTOINCREMENT,Name TEXT,Price TEXT,Quantity TEXT)");
      },
    );
    return database;
  }

  static Future<int> insertProductData(ProductsModal productsModal) async {
    Database? dbClient = await DataBaseHelper.database;
    return await dbClient!.insert('ProductsDetails', productsModal.toJson());
  }

  Future<List<ProductsModal>> getProductData() async {
    Database? database = await DataBaseHelper.database;
    List<Map<String, Object?>> queryResult =
        await database!.query('ProductsDetails');
    return queryResult.map((e) => ProductsModal.fromJson(e)).toList();
  }
}
