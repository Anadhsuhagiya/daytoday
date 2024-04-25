import 'dart:io';

import 'package:daytoday/global/excelCreating.dart';
import 'package:daytoday/global/globals.dart';
import 'package:daytoday/global/haptic.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:intl/intl.dart';
import 'package:path/path.dart';
// import 'package:open_file/open_file.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:syncfusion_flutter_xlsio/xlsio.dart';

import '../../global/Model.dart';
import '../../global/variables.dart';
import '../../widgets/text.dart';

class saveAsExcel extends StatefulWidget {
  const saveAsExcel({super.key});

  @override
  State<saveAsExcel> createState() => _saveAsExcelState();
}

class _saveAsExcelState extends State<saveAsExcel> {
  @override
  Widget build(BuildContext context) {

    final controller = Get.put(saveAsExcelController());

    return Scaffold(

      backgroundColor: kHomeBG,
      appBar: AppBar(
        backgroundColor: kDarkBlue3,
        leading: IconButton(onPressed: () {
          Get.back();
        }, icon: Icon(CupertinoIcons.left_chevron, color: kWhite,)),

        centerTitle: true,
        title: textWidget(msg: "Save As Excel", txtColor: kWhite, txtFontSize: h * 0.02, txtFontWeight: FontWeight.w600),

      ),
      
      body: Column(
        children: [

          SizedBox(height: h * 0.015,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InkWell(
                onTap: () async {
                  lightImpact();
                  controller.dataListAllLists(context);
                },
                child: Container(
                  height: h * 0.1,
                  width: w * 0.95,
                  decoration: BoxDecoration(
                    color: kWhite,
                    borderRadius: BorderRadius.circular(20)
                  ),
                  child: Row(
                    children: [
                      SizedBox(width: w * 0.05,),
                      Image.asset("assets/images/all.png", width: w * 0.2,),
                      SizedBox(width: w * 0.05,),

                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          textWidget(msg: "All Time", txtColor: kDarkBlue3, txtFontSize: h * 0.018, txtFontWeight: FontWeight.w600),
                          SizedBox(height: h * 0.005,),
                          textWidget(msg: "All Time Records are Download as \nExcel Sheet",ovrflw: TextOverflow.fade, txaln: TextAlign.justify , txtColor: kDarkBlue3, txtFontSize: h * 0.014, txtFontWeight: FontWeight.w500),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),

          SizedBox(height: h * 0.015,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InkWell(
                onTap: () {
                  lightImpact();

                  DateTime? _chosenDateTime;
                  Get.bottomSheet(
                    isDismissible: false,
                      Container(
                        height: 500,
                        decoration: BoxDecoration(
                            color: kWhite,
                            borderRadius: BorderRadius.only(topRight: Radius.circular(30), topLeft: Radius.circular(30))
                        ),
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              SizedBox(height: 320,
                                child: CupertinoDatePicker(
                                  mode: CupertinoDatePickerMode.monthYear,
                                  initialDateTime: DateTime.now(),
                                  minimumYear: 1960,
                                  onDateTimeChanged: (value) {

                                    String getMonthName(int month) {
                                      final format = DateFormat('MMMM'); // MMMM for full month names
                                      return format.format(DateTime(2024, month, 1)); // Set day to 1 for any month
                                    }
                                    controller.valDate.value = "${value.year}-${value.month.toString().length == 1 ? '0${value.month}' : value.month.toString()}";

                                  },),
                              ),

                              InkWell(
                                onTap: () {
                                  lightImpact();
                                  controller.dataListMonthlyLists(controller.valDate.value);
                                  setState(() {

                                  });
                                  Navigator.pop(context);
                                },
                                child: Container(
                                  height: h * 0.05,
                                  width: w * 0.95,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                      color: kDarkBlue3,
                                      borderRadius: BorderRadius.circular(10)
                                  ),
                                  child: textWidget(msg: "OK", txtColor: kWhite, txtFontSize: h * 0.016, txtFontWeight: FontWeight.w600),
                                ),
                              ),
                              SizedBox(height: h * 0.01,)
                            ],
                          ),
                        ),
                      )
                  );


                },
                child: Container(
                  height: h * 0.1,
                  width: w * 0.95,
                  decoration: BoxDecoration(
                      color: kWhite,
                      borderRadius: BorderRadius.circular(20)
                  ),
                  child: Row(
                    children: [
                      SizedBox(width: w * 0.05,),
                      Padding(
                        padding: EdgeInsets.only(top: h * 0.018, bottom: h * 0.018),
                        child: Image.asset("assets/images/month.png", width: w * 0.2,),
                      ),
                      SizedBox(width: w * 0.05,),

                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          textWidget(msg: "Monthly Data", txtColor: kDarkBlue3, txtFontSize: h * 0.018, txtFontWeight: FontWeight.w600),
                          SizedBox(height: h * 0.005,),
                          textWidget(msg: "Monthly Records are Download as \nExcel Sheet",ovrflw: TextOverflow.fade, txaln: TextAlign.justify , txtColor: kDarkBlue3, txtFontSize: h * 0.014, txtFontWeight: FontWeight.w500),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),

          SizedBox(height: h * 0.015,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InkWell(
                onTap: () {
                  lightImpact();

                  controller.dataListYearLists("${DateTime.now().year}");

                },
                child: Container(
                  height: h * 0.1,
                  width: w * 0.95,
                  decoration: BoxDecoration(
                      color: kWhite,
                      borderRadius: BorderRadius.circular(20)
                  ),
                  child: Row(
                    children: [
                      SizedBox(width: w * 0.05,),
                      Padding(
                        padding: EdgeInsets.only(top: h * 0.02, bottom: h * 0.02),
                        child: Image.asset("assets/images/calendar.png", width: w * 0.2,),
                      ),
                      SizedBox(width: w * 0.05,),

                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          textWidget(msg: "Yearly Data", txtColor: kDarkBlue3, txtFontSize: h * 0.018, txtFontWeight: FontWeight.w600),
                          SizedBox(height: h * 0.005,),
                          textWidget(msg: "Yearly Records are Download as \nExcel Sheet",ovrflw: TextOverflow.fade, txaln: TextAlign.justify , txtColor: kDarkBlue3, txtFontSize: h * 0.014, txtFontWeight: FontWeight.w500),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          
        ],
      ),

    );
  }
}


class saveAsExcelController extends GetxController{

  //All time

  RxList dates2 = [].obs;
  RxList ListCreditTotal2 = [].obs;
  RxList ListDebitTotal2 = [].obs;
  RxList ListSavings2 = [].obs;

  RxDouble MonthCreditTotal2 = 0.0.obs;
  RxDouble MonthDebitTotal2 = 0.0.obs;
  RxDouble MonthSavings2 = 0.0.obs;

  Future<List<Map<String, dynamic>>> dataListAllLists(BuildContext context) async {

    statData.value = false;

    ListCreditTotal2.clear();
    ListDebitTotal2.clear();
    ListSavings2.clear();

    MonthCreditTotal2.value = 0.0;
    MonthDebitTotal2.value = 0.0;
    MonthSavings2.value = 0.0;

    // Open the database connection
    final database = await Model().createDatabase();

    // Define the query to select all data from the "expenses" table
    final String query = '''SELECT * from expenses order by dt''';

    // Execute the query and get the results as a list of maps
    final List<Map<String, dynamic>> results = await database.rawQuery(query);

    print("result ==== $results");

    for(int i = 0; i < results.length; i++){

      dates2.add(results[i]["dt"]);

      if (results[i]["mode"].toString() == "Credit") {
        ListCreditTotal2.add(results[i]["amount"].toString());
        ListDebitTotal2.add("0");

      }
      if (results[i]["mode"].toString() == "Debit") {
        ListDebitTotal2.add(results[i]["amount"].toString());
        ListCreditTotal2.add("0");

      }

    }



    for(int i = 0; i < ListCreditTotal2.value.length; i++){
      MonthCreditTotal2.value += double.parse(ListCreditTotal2[i]).round();
    }
    for(int i = 0; i < ListDebitTotal2.value.length; i++){
      MonthDebitTotal2.value += double.parse(ListDebitTotal2[i]).round();
    }


    MonthSavings2.value = MonthCreditTotal2.value - MonthDebitTotal2.value;



    print("Credit : ${ListCreditTotal2}");
    print("Debit : ${ListDebitTotal2}");
    print("Savings : ${ListSavings2}");
    print("creTotal : ${MonthCreditTotal2.value}");
    print("DebTotal : ${MonthDebitTotal2.value}");
    print("SavingsTot : ${MonthSavings2.value}");

    statData.value = true;

    excel().createAllExcel(dates2.value, ListCreditTotal2.value, ListDebitTotal2.value, ListSavings2.value, MonthCreditTotal2.value, MonthDebitTotal2.value, MonthSavings2.value);

    // Return the complete list of results
    return results;
  }



  //month

  RxString valDate = "${DateTime.now().year}-${DateTime.now().month.toString().length == 1 ? '0${DateTime.now().month}' : DateTime.now().month.toString()}".obs;

  RxList dates = [].obs;

  Future<List<Map<String, dynamic>>> dataListMonthDays(String dt) async {

    dates.value.clear();
    // Open the database connection
    final database = await Model().createDatabase();

    // Define the query to select all data from the "expenses" table
    final String query = "SELECT DISTINCT dt AS dt FROM expenses order by dt";

    // Execute the query and get the results as a list of maps
    final results = await database.rawQuery(query);

    for(int i = 0; i < results.length; i++){
      if(results[i]["dt"].toString().substring(5,7) == dt.substring(5, 7) && results[i]["dt"].toString().substring(0,4) == "${dt.substring(0,4)}"){
        dates.add(results[i]);
      }
    }

    print("dates=== ${dates.value}");
    // Return the complete list of results
    return results;
  }


  RxBool statData = false.obs;

  RxList ListCreditTotal = [].obs;
  RxList ListDebitTotal = [].obs;
  RxList ListSavings = [].obs;

  RxDouble MonthCreditTotal = 0.0.obs;
  RxDouble MonthDebitTotal = 0.0.obs;
  RxDouble MonthSavings = 0.0.obs;

  Future<List<Map<String, dynamic>>> dataListMonthlyLists(String s) async {

    dataListMonthDays(valDate.value);

    statData.value = false;

    ListCreditTotal.clear();
    ListDebitTotal.clear();
    ListSavings.clear();

    MonthCreditTotal.value = 0.0;
    MonthDebitTotal.value = 0.0;
    MonthSavings.value = 0.0;

    // Open the database connection
    final database = await Model().createDatabase();

    print(s);
    // Define the query to select all data from the "expenses" table
    final String query = '''SELECT
  dt AS date,
  SUM(CASE WHEN mode = 'Credit' THEN amount ELSE 0 END) AS credit_total,
  SUM(CASE WHEN mode = 'Debit' THEN amount ELSE 0 END) AS debit_total,
  SUM(CASE WHEN mode = 'Savings' THEN amount ELSE 0 END) AS savings_total
  FROM expenses
  WHERE strftime('%Y-%m', dt) = '${s}'
  GROUP BY dt
  ORDER BY dt;
    ''';

    // Execute the query and get the results as a list of maps
    final List<Map<String, dynamic>> results = await database.rawQuery(query);

    print("result ==== $results");

    for(int i = 0; i < results.length; i++){
      ListCreditTotal.add(results[i]["credit_total"].toString());
      ListDebitTotal.add(results[i]["debit_total"].toString());

      RxDouble savi = 0.0.obs;
      savi.value = double.parse(ListCreditTotal[i]) - double.parse(ListDebitTotal[i]);

      ListSavings.add(savi.value.round().toString());

      MonthCreditTotal.value = MonthCreditTotal.value + double.parse(ListCreditTotal[i]);
      MonthDebitTotal.value = MonthDebitTotal.value + double.parse(ListDebitTotal[i]);

    }
    MonthSavings.value = MonthCreditTotal.value - MonthDebitTotal.value;
    print("Credit : ${ListCreditTotal}");
    print("Debit : ${ListDebitTotal}");
    print("Savings : ${ListSavings}");
    print("creTotal : ${MonthCreditTotal.value}");
    print("DebTotal : ${MonthDebitTotal.value}");
    print("SavingsTot : ${MonthSavings.value}");

    statData.value = true;

    excel().createExcel(dates, ListCreditTotal.value, ListDebitTotal.value, ListSavings.value, MonthCreditTotal.value, MonthDebitTotal.value, MonthSavings.value);

    // Return the complete list of results
    return results;
  }


  RxString yearInput = "${DateTime.now().year}".obs;

  //Years

  RxList ListMonths = [].obs;

  RxList ListCreditTotal1 = [].obs;
  RxList ListDebitTotal1 = [].obs;
  RxList ListSavings1 = [].obs;

  RxDouble MonthCreditTotal1 = 0.0.obs;
  RxDouble MonthDebitTotal1 = 0.0.obs;
  RxDouble MonthSavings1 = 0.0.obs;

  Future<List<Map<String, dynamic>>> dataListYearLists(String s) async {

    statData.value = false;

    ListCreditTotal1.clear();
    ListDebitTotal1.clear();
    ListSavings1.clear();

    MonthCreditTotal1.value = 0.0;
    MonthDebitTotal1.value = 0.0;
    MonthSavings1.value = 0.0;

    // Open the database connection
    final database = await Model().createDatabase();

    // Define the query to select all data from the "expenses" table
    final String query = '''SELECT
  strftime('%Y', dt) AS year,
  strftime('%Y-%m', dt) AS month,
  SUM(CASE WHEN mode = 'Credit' THEN amount ELSE 0 END) AS credit_total,
  SUM(CASE WHEN mode = 'Debit' THEN amount ELSE 0 END) AS debit_total,
  SUM(CASE WHEN mode = 'Savings' THEN amount ELSE 0 END) AS savings_total
FROM expenses
WHERE strftime('%Y', dt) = '$s'
GROUP BY strftime('%Y', dt), strftime('%Y-%m', dt)
ORDER BY strftime('%Y', dt) ASC, strftime('%Y-%m', dt) ASC;

    ''';

    // Execute the query and get the results as a list of maps
    final List<Map<String, dynamic>> results = await database.rawQuery(query);

    print("result ==== $results");

    for(int i = 0; i < results.length; i++){
      ListMonths.add(results[i]["month"]);
      ListCreditTotal1.add(results[i]["credit_total"].toString());
      ListDebitTotal1.add(results[i]["debit_total"].toString());

      RxDouble savi = 0.0.obs;
      savi.value = double.parse(ListCreditTotal1[i]) - double.parse(ListDebitTotal1[i]);

      ListSavings1.add(savi.value.round().toString());

      MonthCreditTotal1.value = MonthCreditTotal1.value + double.parse(ListCreditTotal1[i]);
      MonthDebitTotal1.value = MonthDebitTotal1.value + double.parse(ListDebitTotal1[i]);

    }
    MonthSavings1.value = MonthCreditTotal1.value - MonthDebitTotal1.value;
    print("Credit : ${ListCreditTotal1}");
    print("Debit : ${ListDebitTotal1}");
    print("Savings : ${ListSavings1}");
    print("creTotal : ${MonthCreditTotal1.value}");
    print("DebTotal : ${MonthDebitTotal1.value}");
    print("SavingsTot : ${MonthSavings1.value}");


    excel().createYearExcel(ListMonths.value, ListCreditTotal1.value, ListDebitTotal1.value, ListSavings1.value, MonthCreditTotal1.value, MonthDebitTotal1.value, MonthSavings1.value);

    // Return the complete list of results
    return results;
  }

}
