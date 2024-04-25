import 'dart:io';
import 'package:path/path.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

List CreditData = [];
List DebitData = [];
double CreditTotal = 0.0;
double DebitTotal = 0.0;
double savings = 0.0;



class Model{

  static SharedPreferences? prefs;

  Future<Database> createDatabase()
  async {

    // if (Platform.isWindows || Platform.isLinux) {
    //   // Only needed for Windows and Linux (if applicable)
    //   sqfliteFfiInit();
    // }
    // databaseFactory = databaseFactoryFfi;

    // Get a location using getDatabasesPath
    var databasesPath = await getDatabasesPath();
    print("Database Path :- $databasesPath");
    String path = join(databasesPath, 'expense.db');

    // Open the database
    Database database = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
          await db.execute("CREATE TABLE expenses(id INTEGER PRIMARY KEY AUTOINCREMENT, title TEXT, amount TEXT, description TEXT, mode TEXT, img TEXT, name TEXT, dt TEXT)");
          await db.execute("CREATE TABLE notes(id INTEGER PRIMARY KEY AUTOINCREMENT, content TEXT, dt TEXT)");
          await db.execute("CREATE TABLE account(id INTEGER PRIMARY KEY AUTOINCREMENT, img TEXT, name TEXT, profession TEXT, purpose TEXT, contact TEXT, email TEXT, additional TEXT)");
        }
    );

    return database;
  }




  Future<List<Map<String, dynamic>>> dataList(String dt) async {

    CreditTotal = 0.0;
    DebitTotal = 0.0;

    CreditData.clear();
    DebitData.clear();

    savings = 0.0;

    // Open the database connection
    final database = await Model().createDatabase();

    // Define the query to select all data from the "expenses" table
    final String query = "SELECT * FROM expenses";

    // Execute the query and get the results as a list of maps
    final List<Map<String, dynamic>> results = await database.rawQuery(query);

    // Separate data into CreditData and DebitData (optional)
    List CreditData1 = results.where((element) => element["mode"] == "Credit").toList();
    List DebitData1 = results.where((element) => element["mode"] == "Debit").toList();

    for(int i = 0; i < CreditData1.length; i++){
      if(CreditData1[i]["dt"].toString() == dt){
        CreditData.add(CreditData1[i]);
      }
    }

    for(int i = 0; i < DebitData1.length; i++){
      if(DebitData1[i]["dt"].toString() == dt){
        DebitData.add(DebitData1[i]);
      }
    }

    for(int i = 0; i < CreditData.length; i++){
      CreditTotal = CreditTotal + int.parse(CreditData[i]["amount"]);
    }

    for(int i = 0; i < DebitData.length; i++){
      DebitTotal = DebitTotal + int.parse(DebitData[i]["amount"]);
    }

    savings = CreditTotal - DebitTotal;

    // Print the results for debugging purposes
    print("Data: $results");
    print("CreditData: $CreditData");
    print("DebitData: $DebitData");



    // Return the complete list of results
    return results;
  }




}
