import 'dart:convert';
import 'dart:math';

import 'package:daytoday/global/Model.dart';
import 'package:daytoday/global/categoryList.dart';
import 'package:daytoday/global/globals.dart';
import 'package:daytoday/global/haptic.dart';
import 'package:daytoday/pages/getDataPages/daily.dart';
import 'package:daytoday/pages/getDataPages/monthly.dart';
import 'package:daytoday/pages/getDataPages/notes.dart';
import 'package:daytoday/pages/getDataPages/yearly.dart';
import 'package:daytoday/pages/searchPages/search.dart';
import 'package:daytoday/pages/settings.dart';
import 'package:daytoday/widgets/text.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:path/path.dart';
import 'package:pull_down_button/pull_down_button.dart';
import 'package:sqflite/sqflite.dart';

import '../global/variables.dart';
import '../widgets/frostedGlass.dart';

import 'package:http/http.dart' as http;

class home extends StatefulWidget {
  const home({super.key});

  @override
  State<home> createState() => _homeState();
}

class _homeState extends State<home> {


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    go();
  }

  go() async {
    await Future.delayed(Duration(milliseconds: 600));
    setState(() {

    });
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(homeController());

    return DefaultTabController(
      length: 4,
      child: Scaffold(
        backgroundColor: kHomeBG,

        appBar: AppBar(
          title: textWidget(
              msg: "Day to Day Expenses",
              txtColor: kWhite,
              txtFontSize: h * 0.016,
              txtFontWeight: FontWeight.w500),
          backgroundColor: kDarkBlue3,
          actions: [
            GestureDetector(
              onTap: () async {

                Get.bottomSheet(
                  isDismissible: false,
                  Container(
                    height: h * 0.08,
                    width: w,
                    decoration: BoxDecoration(
                        color: kWhite,
                        borderRadius: BorderRadius.only(topLeft: Radius.circular(40), topRight: Radius.circular(40))
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            CupertinoActivityIndicator(color: kDarkBlue3,),
                            textWidget(msg: "All Data Uploading Process is Running", txtColor: kDarkBlue3, txtFontSize: h  * 0.018, txtFontWeight: FontWeight.w600)
                          ],
                        ),
                      ],
                    ),
                  ),
                );

                String url = 'https://flutteranadh.000webhostapp.com/DayToDay/deleteAll.php';

                String completeUrl = '$url?uid=$id'; // Construct complete URL with query parameter

                final response = await http.get(
                  Uri.parse(completeUrl),
                );

                if (response.statusCode == 200) {
                  print(response.body);

                }
                else {
                  print(response.reasonPhrase);
                }


                //Expense Backup

                // Open the database connection
                final database = await Model().createDatabase();

                // Define the query to select all data from the "expenses" table
                final String query = "SELECT * FROM expenses";

                // Execute the query and get the results as a list of maps
                final List<Map<String, dynamic>> results = await database.rawQuery(query);

                print("RESULT == $results");

                if(results.isEmpty){
                  Get.snackbar("Error", "You having no Any Data to Backup...",
                      backgroundColor: kError,
                      colorText: kWhite,
                      duration: Duration(seconds: 2));
                }
                else{
                  for(int i = 0; i < results.length; i++){

                    String url = 'https://flutteranadh.000webhostapp.com/DayToDay/insertExpenseData.php';

                    Map<String, dynamic> data = {
                      'title': results[i]["title"],
                      'amount': results[i]["amount"],
                      'description': results[i]["description"],
                      'mode': results[i]["mode"],
                      'img': results[i]["img"],
                      'name': results[i]["name"],
                      'dt': results[i]["dt"],
                      'uid': id,
                    };

                    final response = await http.post(
                      Uri.parse(url),
                      body: data,
                    );

// Check response status and handle data
                    if (response.statusCode == 201 || response.statusCode == 200) {
                      // Data inserted successfully!
                      print('Data inserted successfully!');
                    } else {
                      // Handle error
                      print('Error inserting data: ${response.body}');
                    }

                  }


                  Get.snackbar("Success", "Data Backup Successfully ...",
                      backgroundColor: kGreen,
                      colorText: kWhite,
                      duration: Duration(seconds: 2));

                  Get.back();
                }

                //notes Backup


                // Define the query to select all data from the "expenses" table
                final String query1 = "SELECT * FROM notes";

                // Execute the query and get the results as a list of maps
                final results1 = await database.rawQuery(query1);

                print("RESULT == $results1");

                if(results1.isEmpty){
                  Get.back();
                  Get.snackbar("Error", "You having no Any Data to Backup...",
                      backgroundColor: kError,
                      colorText: kWhite,
                      duration: Duration(seconds: 2));
                }
                else{
                  for(int i = 0; i < results1.length; i++){

                    final Uri url = Uri.parse('https://flutteranadh.000webhostapp.com/DayToDay/insertNotes.php');
                    final Map<String, dynamic> data = {
                      'content': results1[i]["content"],
                      'dt': results1[i]["dt"],
                      'uid': id,
                    };
                    final response = await http.post(url, body: data);

                    if (response.statusCode == 200) {
                      print(response.body);
                    }
                    else {
                      print(response.reasonPhrase);
                    }

                  }

                  Navigator.pop(context);

                  Get.snackbar("Success", "Data Backup Successfully ...",
                      backgroundColor: kGreen,
                      colorText: kWhite,
                      duration: Duration(seconds: 2));

                  Get.offAll(() => home(), transition: Transition.fade, duration:  Duration(seconds: 1));

                }

              },
              child: Image.asset(
                "assets/images/trafic.png",
                color: kWhite,
                width: w * 0.06,
              ),
            ),
            SizedBox(
              width: w * 0.03,
            ),
            GestureDetector(
              onTap: () {
                Get.to(
                    () => search(),
                  transition: Transition.fade,
                  duration: Duration(seconds: 1)
                );
              },
              child: Image.asset(
                "assets/images/search.png",
                color: kWhite,
                width: w * 0.06,
              ),
            ),
            PullDownButton(
              itemBuilder: (context) => [

                PullDownMenuItem(
                  title: 'Settings',
                  onTap: () {
                    Get.to(
                        () => settings(),
                      transition: Transition.fade,
                      duration: Duration(seconds: 1)
                    );
                  },
                ),
              ],
              buttonBuilder: (context, showMenu) => CupertinoButton(
                onPressed: showMenu,
                padding: EdgeInsets.zero,
                child: const Icon(
                  CupertinoIcons.ellipsis_circle,
                  color: kWhite,
                ),
              ),
            ),
          ],
          bottom: TabBar(
              enableFeedback: true,
              indicatorColor: kWhite,
              indicatorSize: TabBarIndicatorSize.label,
              indicatorPadding: EdgeInsets.only(bottom: h * 0.005),
              tabs: [
                Tab(
                  child: textWidget(
                      msg: "Daily",
                      txtColor: kWhite,
                      txtFontSize: h * 0.016,
                      txtFontWeight: FontWeight.w500),
                ),
                Tab(
                  child: textWidget(
                      msg: "Monthly",
                      txtColor: kWhite,
                      txtFontSize: h * 0.016,
                      txtFontWeight: FontWeight.w500),
                ),
                Tab(
                  child: textWidget(
                      msg: "Yearly",
                      txtColor: kWhite,
                      txtFontSize: h * 0.016,
                      txtFontWeight: FontWeight.w500),
                ),
                Tab(
                  child: textWidget(
                      msg: "Notes",
                      txtColor: kWhite,
                      txtFontSize: h * 0.016,
                      txtFontWeight: FontWeight.w500),
                ),
              ]),
        ),
        body: TabBarView(
          children: [
            daily(),
            monthly(),
            yearly(),
            notes()
          ],
        ),
      ),
    );
  }
}

 class homeController extends GetxController{

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getData();
    getCategory();
  }

  getData() async {

    id = Model.prefs!.getString('uid') ?? "";
    img = Model.prefs!.getString('img') ?? "";
    name = Model.prefs!.getString('name') ?? "";
    profession = Model.prefs!.getString('profession') ?? "";
    purpose = Model.prefs!.getString('purpose') ?? "";
    contact = Model.prefs!.getString('contact') ?? "";
    email = Model.prefs!.getString('email') ?? "";
    additional = Model.prefs!.getString('additional') ?? "";

print("IMAGE == $img");

    final database = await Model().createDatabase();

    // Define the query to select all data from the "expenses" table
    final String query = "SELECT * FROM account";

    // Execute the query and get the results as a list of maps
    final results = await database.rawQuery(query);

    for(int i = 0; i < results.length; i++){
      if(results[i]["contact"].toString() == contact && results[i]["email"].toString() == email){
        id = results[i]["id"].toString();
        break;
      }
    }

  }



  getCategory() async {

    cat.clear();
    //get All Data
    String api = 'https://flutteranadh.000webhostapp.com/DayToDay/categoryGet.php';

    var response = await Dio().get(api);
    print("response :- $response");

    if(response.statusCode == 200 || response.statusCode == 201){
      final data = jsonDecode(response.data);
      cat.addAll(data);
    }
  }
}
