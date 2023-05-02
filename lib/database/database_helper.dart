import 'dart:ffi';

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
            "CREATE TABLE ProductsDetails (id INTEGER PRIMARY KEY AUTOINCREMENT,Name TEXT,Price TEXT)");
        await db.execute(
            "CREATE TABLE CartDetail (id INTEGER PRIMARY KEY AUTOINCREMENT,ProductName TEXT,ProductPrice TEXT,Quantity INTEGER,ProductId INTEGER)");
      },
    );
    return database;
  }

  static Future<int> insertProductData(String name, String price) async {
    Database? dbClient = await DataBaseHelper.database;
    String insertQuery =
        "INSERT INTO ProductsDetails(Name,Price) VALUES('$name','$price')";
    return dbClient!.rawInsert(insertQuery);
  }

  static Future<int> insertProductDataInCart(
      String name, String price, int quantity, int productId) async {
    Database? dbClient = await DataBaseHelper.database;
    String insertQuery =
        "INSERT INTO CartDetail(ProductName,ProductPrice,Quantity,ProductId) VALUES('$name','$price','$quantity','$productId')";
    return dbClient!.rawInsert(insertQuery);
  }

  static Future<bool> checkProductAlreadyExist(int productId) async {
    Database? database = await DataBaseHelper.database;
    String checkProductAlreadyExistQuery = "SELECT * FROM CartDetail WHERE id ='$productId'";
    List<Map<String, dynamic>> result = await database!.rawQuery(checkProductAlreadyExistQuery);
    if (result.length == 1) {
      return true;
    } else {
      return false;
    }
  }

  static Future<List<Map<String, dynamic>>> getProductData() async {
    Database? database = await DataBaseHelper.database;
    String getProductDataQuery = "SELECT * FROM ProductsDetails";
    return database!.rawQuery(getProductDataQuery);
  }

  static Future<List<Map<String, dynamic>>> getProductDataFromCart() async {
    Database? database = await DataBaseHelper.database;
    String getProductDataQuery = "SELECT * FROM CartDetail";
    return database!.rawQuery(getProductDataQuery);
  }

  static Future<int>deleteItemFromCart(int id) async {
    Database? database = await DataBaseHelper.database;
    String deleteQuery = "DELETE FROM CartDetail WHERE id='$id'";
  return  database!.rawDelete(deleteQuery);
  }
}
