import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelperImages {
  static DatabaseHelperImages _instance = new DatabaseHelperImages.internal();

  factory DatabaseHelperImages() => _instance;

  final String tableNote = "imagesTable";
  final String columnName = "name";

  static Database? _db;

  DatabaseHelperImages.internal();

  Future<Database?> get db async {
    if (_db != null) {
      return _db;
    }
  }

  initDb() async {
    String databasePath = await getDatabasesPath();
    String path = join(databasePath, "images.db");
    var db = await openDatabase(path, version: 1, onCreate: _onCreate);
    return db;
  }

  _onCreate(Database db, int newVersion) async {
    await db.execute(
      "CREATE TABLE $tableNote("
      "$columnName TEXT PRIMARY KEY)",
    );
  }

  Future<int> saveProducts(String item) async {
    var dbClient = await db;
    var map = new Map<String, dynamic>();
    map[columnName] = item;
    var result = await dbClient!.insert(tableNote, map);
    return result;
  }

  Future<List<String>> getProducts() async {
    var dbClient = await db;
    List<Map> list = (await dbClient?.rawQuery("SELECT * FROM $tableNote"))?? [];
    List<String> products = [];
    for (int i = list.length - 1; i >= 0; i--) {
      var items = list[i][columnName];
      products.add(items);
    }
    return products;
  }

  Future<int> deleteProducts(int id) async {
    var dbClient = await db;
    return await dbClient!
        .delete("$tableNote", where: "$columnName = ?", whereArgs: [id]);
  }

  Future<int> updateProduct(String item) async {
    var dbClient = await db;
    var map = new Map<String, dynamic>();
    map[columnName] = item;
    return dbClient!.update(
      tableNote,
      map,
      where: "$columnName = ?",
      whereArgs: [item],
    );
  }

  Future<void> clear() async {
    var dbClient = await db;
    await dbClient!.rawQuery("DELETE FROM $tableNote");
  }

  Future close() async {
    var dbClient = await db;
    return dbClient!.close();
  }
}
