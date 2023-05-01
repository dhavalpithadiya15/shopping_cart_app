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
            "CREATE TABLE ProductsDetails (id INTEGER PRIMARY KEY AUTOINCREMENT,Name TEXT,Price TEXT,Quantity INTEGER)");
      },
    );
    return database;
  }

  static Future<int> insertProductData(
      String name, String price, int quantity) async {
    Database? dbClient = await DataBaseHelper.database;
    String insertQuery =
        " INSERT INTO ProductsDetails(Name,Price,Quantity) VALUES('$name','$price',$quantity)";
    return dbClient!.rawInsert(insertQuery);
  }

  static Future<List<Map<String, dynamic>>> getProductData() async {
    Database? database = await DataBaseHelper.database;
    String getProductDataQuery = "SELECT * FROM ProductsDetails";
    return database!.rawQuery(getProductDataQuery);
  }

  static updateQuantity(int updatedQuantity, int id) async {
    Database? database = await DataBaseHelper.database;
    String updateQuery = "UPDATE ProductsDetails SET Quantity='$updatedQuantity'WHERE id ='$id'";
    database!.rawUpdate(updateQuery);
  }
}
