import 'dart:math';

import 'package:daytoday/global/globals.dart';
import 'package:daytoday/widgets/text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:sqflite/sqflite.dart';

import '../../global/Model.dart';
import '../../global/haptic.dart';
import '../../global/variables.dart';

class searchedPage extends StatefulWidget {

  String value;

  searchedPage(this.value);


  @override
  State<searchedPage> createState() => _searchedPageState();
}

class _searchedPageState extends State<searchedPage> {
  @override
  Widget build(BuildContext context) {

    final controller = Get.put(searchedPageController(widget.value));

    return Scaffold(
      backgroundColor: kHomeBG,

      appBar: AppBar(
        backgroundColor: kDarkBlue3,

        leading: IconButton(onPressed: () {
          lightImpact();
          Get.back();
        }, icon: Icon(CupertinoIcons.back, color: kWhite,)),
        
        centerTitle: true,
        title: textWidget(msg: "${widget.value}", txtColor: kWhite, txtFontSize: h * 0.02, txtFontWeight: FontWeight.w600),
      ),

      body: Column(
        children: [
          SizedBox(
            height: h * 0.01,
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: h * 0.06,
                width: w * 0.95,
                decoration: BoxDecoration(
                  color: kDarkBlue3,
                  borderRadius: BorderRadius.circular(15)
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: w * 0.05),
                      child: textWidget(msg: "Total  : ", txtColor: kWhite, txtFontSize: h * 0.016, txtFontWeight: FontWeight.w600),
                    ),

                    Padding(
                      padding: EdgeInsets.only(right: w * 0.05),
                      child: Obx(() => textWidget(msg: "₹ ${controller.total.value}/-", txtColor: kWhite, txtFontSize: h * 0.016, txtFontWeight: FontWeight.w600)),
                    ),
                  ],
                ),
              ),
            ],
          ),

          Obx(() => Expanded(
            child: controller.status.value
            ? controller.expense.isNotEmpty
            ? ListView.builder(
              itemCount: controller.expense.length,
              itemBuilder: (context, index) {
                return Container(
                  height: h * 0.05,
                  width: w * 0.95,
                  margin: EdgeInsets.only(left: h * 0.01, top: h * 0.01, right: h * 0.01),
                  decoration: BoxDecoration(
                    color: kWhite,
                    borderRadius: BorderRadius.circular(10)
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: w * 0.05),
                        child: Row(
                          children: [
                            textWidget(msg: "${controller.expense[index]["dt"]}", txtColor: kDarkBlue3, txtFontSize: h * 0.016, txtFontWeight: FontWeight.w500),
                            SizedBox(width: w * 0.05,),
                            textWidget(msg: "${controller.expense[index]["title"]}", txtColor: kDarkBlue3, txtFontSize: h * 0.016, txtFontWeight: FontWeight.w500)
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(right: w * 0.05),
                        child: Obx(() => textWidget(msg: "₹ ${controller.expense[index]["amount"]}/-", txtColor: kDarkBlue3, txtFontSize: h * 0.016, txtFontWeight: FontWeight.w500)),
                      )
                    ],
                  ),
                );
              },
            )
            : Center(child: textWidget(msg: "No Data Found", txtColor: kDarkBlue3, txtFontSize: h * 0.016, txtFontWeight: FontWeight.w600),)
            : Center(child: CircularProgressIndicator(color: kDarkBlue3,strokeWidth: 3,),),
          ))
        ],
      ),

    );
  }
}


class searchedPageController extends GetxController{

  RxList expense = [].obs;
  RxBool status = false.obs;
  RxDouble total = 0.0.obs;
  Database? db;

  String value;

  searchedPageController(this.value);

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();

    Model().createDatabase().then((value) {
      db = value;
    });

    dataListMonthDays(value);



  }


  Future<List<Map<String, dynamic>>> dataListMonthDays(String name) async {

    status.value = false;
    expense.value.clear();
    // Open the database connection
    final database = await Model().createDatabase();

    // Define the query to select all data from the "expenses" table
    final String query = "SELECT * FROM expenses where name = '$name' order by dt";

    // Execute the query and get the results as a list of maps
    final results = await database.rawQuery(query);

    expense.value = results;

    for(int i = 0; i < results.length; i++){
      total.value = total.value + double.parse(results[i]["amount"].toString());
    }

    print("Expenses=== ${expense.value}");

    status.value = true;
    // Return the complete list of results
    return results;
  }



}
