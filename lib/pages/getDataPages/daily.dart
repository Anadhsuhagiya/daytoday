import 'package:daytoday/global/Model.dart';
import 'package:daytoday/global/globals.dart';
import 'package:daytoday/pages/home.dart';
import 'package:daytoday/widgets/text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:pull_down_button/pull_down_button.dart';
import 'package:sqflite/sqflite.dart';

import '../../global/categoryList.dart';
import '../../global/haptic.dart';
import '../../global/variables.dart';
import '../../widgets/frostedGlass.dart';

class daily extends StatefulWidget {
  const daily({super.key});

  @override
  State<daily> createState() => _dailyState();
}

class _dailyState extends State<daily> {

  final controller = Get.put(dailyController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    go();
  }
  go() async {
    controller.status.value = false;
    await Future.delayed(Duration(seconds: 1));
    controller.status.value = true;
  }

  @override
  Widget build(BuildContext context) {



    return Scaffold(
      backgroundColor: kHomeBG,

      floatingActionButton: FloatingActionButton(
        backgroundColor: kDarkBlue3,
        onPressed: () {
          lightImpact();

          controller.title.text = "";
          controller.Amount.text = "";
          controller.description.text = "";
          controller.valex.value = 1;
          controller.Ex.value = "Debit";
          controller.CategoryIcon.value = "";
          controller.CategoryString.value = "";
          controller.SelectedDate.value = "";

          Get.bottomSheet(Container(
            height: h * 0.6,
            width: w,
            decoration: BoxDecoration(
                color: kWhite,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(50),
                    topRight: Radius.circular(50))),
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Column(
                children: [
                  SizedBox(
                    height: h * 0.03,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      controller.CustomRadioEx("Credit", 0),
                      controller.CustomRadioEx("Debit", 1),
                    ],
                  ),
                  SizedBox(
                    height: h * 0.03,
                  ),

                  Row(
                    children: [
                      SizedBox(width: h * 0.015,),
                      InkWell(
                          onTap: () {

                            DateTime? _chosenDateTime;
                            Get.bottomSheet(isDismissible: false,

                                Container(
                                  height: 650,
                                  decoration: BoxDecoration(
                                      color: kWhite,
                                      borderRadius: BorderRadius.only(topRight: Radius.circular(30), topLeft: Radius.circular(30))
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      SizedBox(height: 320,
                                        child: CupertinoDatePicker(
                                          mode: CupertinoDatePickerMode.date,
                                          initialDateTime: DateTime.now(),
                                          minimumYear: 1960,
                                          onDateTimeChanged: (value) {

                                            controller.SelectedDate.value = value.toString().substring(0, 10);
                                          },),
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          InkWell(
                                            onTap: () {
                                              if(controller.SelectedDate.value == "Select Date"){
                                                controller.SelectedDate.value = DateTime.now().toString().substring(0, 10);
                                              }

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
                                        ],
                                      ),
                                      SizedBox(height: h * 0.01,)
                                    ],
                                  ),
                                )

                            );

                          },
                          child: Image.asset("assets/images/dates.png", width: h * 0.022, color: kDarkBlue3,)),
                      SizedBox(width: h * 0.015,),
                      InkWell(
                        onTap: () {

                          DateTime? _chosenDateTime;
                          Get.bottomSheet(isDismissible: false,

                              Container(
                                height: 650,
                                decoration: BoxDecoration(
                                    color: kWhite,
                                    borderRadius: BorderRadius.only(topRight: Radius.circular(30), topLeft: Radius.circular(30))
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    SizedBox(height: 320,
                                      child: CupertinoDatePicker(
                                        mode: CupertinoDatePickerMode.date,
                                        initialDateTime: DateTime.now(),
                                        minimumYear: 1960,
                                        onDateTimeChanged: (value) {

                                          controller.SelectedDate.value = value.toString().substring(0, 10);
                                        },),
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        InkWell(
                                          onTap: () {
                                            if(controller.SelectedDate.value == "Select Date"){
                                              controller.SelectedDate.value = DateTime.now().toString().substring(0, 10);
                                            }

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
                                      ],
                                    ),
                                    SizedBox(height: h * 0.01,)
                                  ],
                                ),
                              )

                          );

                        },
                        child: Obx(() => textWidget(msg: "${controller.SelectedDate.value}", txtColor: kDarkBlue3, txtFontSize: h * 0.016, txtFontWeight: FontWeight.w600)
                        ),
                      )
                    ],
                  ),

                  SizedBox(
                    height: h * 0.03,
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                          left: h * 0.015,
                        ),
                        child: textWidget(
                            msg: "Title",
                            txtColor: kDarkBlue3,
                            txtFontSize: h * 0.014,
                            txtFontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.all(h * 0.01),
                    child: TextField(
                      controller: controller.title,
                      keyboardType: TextInputType.name,
                      cursorColor: kDarkBlue3,
                      style: TextStyle(fontSize: h * 0.014),
                      onTapOutside: (event) =>
                          FocusScope.of(context).unfocus(),
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(
                                color: kDarkBlue3,
                                width: 1,
                              )),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(
                                color: kDarkBlue3,
                                width: 1,
                              )),
                          hintText: "Enter Title",
                          hintStyle: TextStyle(fontSize: h * 0.014),
                          prefixIcon: IconButton(
                              onPressed: () {
                                lightImpact();
                                Get.dialog(
                                    transitionCurve: Curves.easeInOut,
                                    transitionDuration:
                                    Duration(milliseconds: 300),
                                    FrostedGlass(
                                      widget: AlertDialog(
                                        backgroundColor:
                                        kWhite.withOpacity(0.6),
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                            BorderRadius.circular(30)),
                                        content: Container(
                                          height: h * 0.6,
                                          width: w,
                                          margin: EdgeInsets.all(h * 0.005),
                                          child: Column(
                                            children: [

                                              Obx(() =>
                                              controller.searchCat.value
                                                  ? controller.tempCat
                                                  .length !=
                                                  0
                                                  ? Expanded(
                                                child: ListView
                                                    .builder(
                                                  itemCount:
                                                  controller
                                                      .tempCat
                                                      .length,
                                                  itemBuilder:
                                                      (context,
                                                      index) {
                                                    return InkWell(
                                                      onTap:
                                                          () {
                                                        lightImpact();
                                                        controller
                                                            .CategoryIcon
                                                            .value = controller
                                                            .tempCat[index]
                                                        [
                                                        "img"];
                                                        controller
                                                            .CategoryString
                                                            .value = controller
                                                            .tempCat[index]
                                                        [
                                                        "name"];
                                                        Navigator.pop(context);
                                                      },
                                                      child:
                                                      Column(
                                                        children: [
                                                          SizedBox(
                                                            height:
                                                            h * 0.03,
                                                          ),
                                                          Row(
                                                            children: [
                                                              Image.asset(
                                                                controller.tempCat[index]["img"],
                                                                width: h * 0.02,
                                                              ),
                                                              SizedBox(
                                                                width: w * 0.04,
                                                              ),
                                                              textWidget(msg: "${controller.tempCat[index]["name"]}", txtColor: kDarkBlue3, txtFontSize: h * 0.016, txtFontWeight: FontWeight.w500)
                                                            ],
                                                          ),
                                                          SizedBox(
                                                            height:
                                                            h * 0.03,
                                                          ),
                                                          Container(
                                                            height:
                                                            h * 0.001,
                                                            width:
                                                            w,
                                                            color:
                                                            kDarkBlue3,
                                                            margin:
                                                            EdgeInsets.all(h * 0.001),
                                                          ),
                                                        ],
                                                      ),
                                                    );
                                                  },
                                                ),
                                              )
                                                  : Expanded(
                                                child: ListView
                                                    .builder(
                                                  itemCount:
                                                  cat
                                                      .length,
                                                  itemBuilder:
                                                      (context,
                                                      index) {
                                                    return InkWell(
                                                      onTap: () {
                                                        lightImpact();
                                                        controller
                                                            .CategoryIcon
                                                            .value = cat[index]
                                                        [
                                                        "img"];
                                                        controller
                                                            .CategoryString
                                                            .value = cat[index]
                                                        [
                                                        "name"];
                                                        Navigator.pop(context);
                                                      },
                                                      child: Column(
                                                        children: [
                                                          SizedBox(
                                                            height:
                                                            h * 0.03,
                                                          ),
                                                          Row(
                                                            children: [
                                                              cat[index]["img"].toString().length == 1
                                                                  ? Container(
                                                                height: h * 0.03,
                                                                width: h * 0.03,
                                                                alignment: Alignment.center,
                                                                decoration: BoxDecoration(
                                                                    color: kDarkBlue3,
                                                                    borderRadius: BorderRadius.circular(7)
                                                                ),
                                                                child: textWidget(msg: "${cat[index]["img"]}", txtColor: kWhite, txtFontSize: h * 0.02, txtFontWeight: FontWeight.w600),
                                                              )
                                                                  : Image
                                                                  .asset(
                                                                cat[index]
                                                                [
                                                                "img"],
                                                                width:
                                                                h * 0.02,
                                                              ),
                                                              SizedBox(
                                                                width: w * 0.04,
                                                              ),
                                                              textWidget(
                                                                  msg: "${cat[index]["name"]}",
                                                                  txtColor: kDarkBlue3,
                                                                  txtFontSize: h * 0.016,
                                                                  txtFontWeight: FontWeight.w500)
                                                            ],
                                                          ),
                                                          SizedBox(
                                                            height:
                                                            h * 0.03,
                                                          ),
                                                          Container(
                                                            height:
                                                            h * 0.001,
                                                            width:
                                                            w,
                                                            color:
                                                            kDarkBlue3,
                                                            margin:
                                                            EdgeInsets.all(h * 0.001),
                                                          ),
                                                        ],
                                                      ),
                                                    );
                                                  },
                                                ),
                                              )
                                                  : Expanded(
                                                child: ListView
                                                    .builder(
                                                  itemCount:
                                                  cat
                                                      .length,
                                                  itemBuilder:
                                                      (context,
                                                      index) {
                                                    return InkWell(
                                                      onTap: () {
                                                        lightImpact();
                                                        controller
                                                            .CategoryIcon
                                                            .value = cat[index]
                                                        [
                                                        "img"];
                                                        controller
                                                            .CategoryString
                                                            .value = cat[index]
                                                        [
                                                        "name"];
                                                        Navigator.pop(context);
                                                      },
                                                      child: Column(
                                                        children: [
                                                          SizedBox(
                                                            height: h *
                                                                0.03,
                                                          ),
                                                          Row(
                                                            children: [
                                                              cat[index]["img"].toString().length == 1
                                                              ? Container(
                                                                height: h * 0.03,
                                                                width: h * 0.03,
                                                                alignment: Alignment.center,
                                                                decoration: BoxDecoration(
                                                                  color: kDarkBlue3,
                                                                  borderRadius: BorderRadius.circular(7)
                                                                ),
                                                                child: textWidget(msg: "${cat[index]["img"]}", txtColor: kWhite, txtFontSize: h * 0.02, txtFontWeight: FontWeight.w600),
                                                              )
                                                                  : Image
                                                                  .asset(
                                                                cat[index]
                                                                [
                                                                "img"],
                                                                width:
                                                                h * 0.02,
                                                              ),
                                                              SizedBox(
                                                                width:
                                                                w * 0.04,
                                                              ),
                                                              textWidget(
                                                                  msg:
                                                                  "${cat[index]["name"]}",
                                                                  txtColor:
                                                                  kDarkBlue3,
                                                                  txtFontSize: h *
                                                                      0.016,
                                                                  txtFontWeight:
                                                                  FontWeight.w500)
                                                            ],
                                                          ),
                                                          SizedBox(
                                                            height: h *
                                                                0.03,
                                                          ),
                                                          Container(
                                                            height: h *
                                                                0.001,
                                                            width: w,
                                                            color:
                                                            kDarkBlue3,
                                                            margin: EdgeInsets
                                                                .all(h *
                                                                0.001),
                                                          ),
                                                        ],
                                                      ),
                                                    );
                                                  },
                                                ),
                                              )),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ));
                              },
                              icon: Icon(
                                CupertinoIcons.add_circled,
                                color: kDarkBlue3,
                              ))),
                    ),
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                          left: h * 0.015,
                        ),
                        child: textWidget(
                            msg: "Amount",
                            txtColor: kDarkBlue3,
                            txtFontSize: h * 0.014,
                            txtFontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.all(h * 0.01),
                    child: TextField(
                      controller: controller.Amount,
                      keyboardType: TextInputType.number,
                      cursorColor: kDarkBlue3,
                      style: TextStyle(fontSize: h * 0.014),
                      onTapOutside: (event) =>
                          FocusScope.of(context).unfocus(),
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(
                                color: kDarkBlue3,
                                width: 1,
                              )),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(
                                color: kDarkBlue3,
                                width: 1,
                              )),
                          hintText: "Enter Amount",
                          hintStyle: TextStyle(fontSize: h * 0.014),
                          prefixIcon: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              textWidget(
                                  msg: "₹",
                                  txtColor: kDarkBlue3,
                                  txtFontSize: h * 0.02,
                                  txtFontWeight: FontWeight.w600),
                            ],
                          )),
                    ),
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                          left: h * 0.015,
                        ),
                        child: textWidget(
                            msg: "Description",
                            txtColor: kDarkBlue3,
                            txtFontSize: h * 0.014,
                            txtFontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.all(h * 0.01),
                    child: TextField(
                      controller: controller.description,
                      keyboardType: TextInputType.name,
                      maxLines: 4,
                      cursorColor: kDarkBlue3,
                      style: TextStyle(fontSize: h * 0.014),
                      onTapOutside: (event) =>
                          FocusScope.of(context).unfocus(),
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(
                              color: kDarkBlue3,
                              width: 1,
                            )),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(
                              color: kDarkBlue3,
                              width: 1,
                            )),
                        hintText: "Enter Description",
                        hintStyle: TextStyle(fontSize: h * 0.014),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: h * 0.015,
                  ),
                  InkWell(
                    onTap: () async {
                      lightImpact();
                      controller.onSubmit(context);
                      await Future.delayed(Duration(seconds: 1));
                      setState(() {

                      });
                    },
                    child: Container(
                      height: h * 0.05,
                      width: w * 0.95,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: kDarkBlue3,
                          borderRadius: BorderRadius.circular(15)),
                      child: textWidget(
                          msg: "Submit",
                          txtColor: kWhite,
                          txtFontSize: h * 0.016,
                          txtFontWeight: FontWeight.w500),
                    ),
                  ),

                  SizedBox(height: h * 0.015,)
                ],
              ),
            ),
          ));
        },
        child: Icon(
          CupertinoIcons.add,
          color: kWhite,
        ),
      ),

      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [

          Expanded(
            child: Container(
              width: w,
              child: Column(
                children: [
                  SizedBox(height: h * 0.01,),
                  Container(
                    height: h * 0.05,
                    width: w * 0.95,
                    decoration: BoxDecoration(
                      color: kDarkBlue3,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          onTap: () {

                            DateTime? _chosenDateTime;
                            Get.bottomSheet(
                              isDismissible: false,
                                Container(
                                  height: 450,
                                  decoration: BoxDecoration(
                                      color: kWhite,
                                      borderRadius: BorderRadius.only(topRight: Radius.circular(30), topLeft: Radius.circular(30))
                                  ),
                                  child: SingleChildScrollView(
                                    child: Column(
                                      children: [
                                        SizedBox(height: 320,
                                          child: CupertinoDatePicker(
                                            mode: CupertinoDatePickerMode.date,
                                            initialDateTime: DateTime.now(),
                                            minimumYear: 1960,
                                            onDateTimeChanged: (value) {
                                              String getWeekdayName(int weekday) {
                                                if(weekday == 1){
                                                  return "Monday";
                                                }
                                                else if(weekday == 2){
                                                  return "Tuesday";
                                                }
                                                else if(weekday == 3){
                                                  return "Wednesday";
                                                }else if(weekday == 4){
                                                  return "Thursday";
                                                }
                                                else if(weekday == 5){
                                                  return "Friday";
                                                }
                                                else if(weekday == 6){
                                                  return "Saturday";
                                                }
                                                else{
                                                  return "Sunday";
                                                }

                                              }
                                              controller.valDate.value = "";
                                              controller.valDate.value = "${value.toString().substring(0, 10)}";
                                              print("DATE === ${value.toString().substring(0, 10)}");

                                              String getMonthName(int month) {
                                                final format = DateFormat('MMMM'); // MMMM for full month names
                                                return format.format(DateTime(2024, month, 1)); // Set day to 1 for any month
                                              }
                                              print("${value.weekday}");
                                              controller.TodayDate.value = value.day.toString();
                                              controller.month.value = "${getMonthName(value.month)}, ${value.year}";
                                              controller.dayStr.value = getWeekdayName(value.weekday);
                                            },),
                                        ),
                                        InkWell(
                                          onTap: () async {
                                            lightImpact();

                                            controller.getData(controller.valDate.value);
                                            Navigator.pop(context);
                                            await Future.delayed(Duration(seconds: 1));
                                            setState(() {

                                            });



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
                            setState(() {

                            });

                          },
                          child: Obx(() => Container(
                            width: w * 0.5,
                            margin: EdgeInsets.only(left: w * 0.05),
                            child: Row(
                              children: [
                                textWidget(msg: "${controller.TodayDate.value}", txtColor: kWhite, txtFontSize: h * 0.023, txtFontWeight: FontWeight.w700),
                                SizedBox(width: w * 0.04,),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    textWidget(msg: "${controller.month.value}", txtColor: kWhite, txtFontSize: h * 0.015, txtFontWeight: FontWeight.w500),
                                    textWidget(msg: "${controller.dayStr.value}", txtColor: kWhite, txtFontSize: h * 0.015, txtFontWeight: FontWeight.w500),
                                  ],
                                )
                              ],
                            ),
                          )),
                        ),

                        Padding(
                          padding:  EdgeInsets.only(right: w * 0.05),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              textWidget(msg: "Savings", txtColor: kWhite, txtFontSize: h * 0.016, txtFontWeight: FontWeight.w600),
                              textWidget(msg: "₹ ${savings.round()}/-", txtColor: kWhite, txtFontSize: h * 0.014, txtFontWeight: FontWeight.w500),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(height: h * 0.01,),
                  Container(
                    height: h * 0.04,
                    width: w * 0.95,
                    decoration: BoxDecoration(
                      color: kDarkBlue3.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding:  EdgeInsets.only(left: w * 0.05),
                          child: textWidget(msg: "Total Income [ Credit ]", txtColor: kDarkBlue3, txtFontSize: h * 0.016, txtFontWeight: FontWeight.w600),
                        ),
                        Padding(
                          padding:  EdgeInsets.only(right: w * 0.05),
                          child: textWidget(msg: "₹ ${CreditTotal.round()}/-", txtColor: kDarkBlue3, txtFontSize: h * 0.016, txtFontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: h * 0.01,),
                  Expanded(
                      child: Obx(() => controller.status.value
                          ? CreditData.isEmpty
                          ? Center(
                        child: textWidget(msg: "No Income Found", txtColor: kDarkBlue3, txtFontSize: h * 0.016, txtFontWeight: FontWeight.w600),
                      )
                          :ListView.builder(
                        itemCount: CreditData.length,
                        itemBuilder: (context, index) {

                          return Container(
                            height: h * 0.05,
                            width: w * 0.95,
                            margin: EdgeInsets.only(left: h * 0.01, right: h * 0.01, top: h * 0.01),
                            decoration: BoxDecoration(
                                color: kWhite,
                                borderRadius: BorderRadius.circular(10)
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    SizedBox(width: w * 0.01,),

                                    PullDownButton(
                                      itemBuilder: (context) => [

                                        PullDownMenuItem(
                                          title: 'Edit',
                                          onTap: () {
                                            lightImpact();

                                            controller.title.text = CreditData[index]["title"];
                                            controller.Amount.text = CreditData[index]["amount"];
                                            controller.description.text = CreditData[index]["description"];
                                            controller.valex.value = CreditData[index]["mode"].toString() == "Credit" ? 0 : 1;
                                            controller.Ex.value = CreditData[index]["mode"];
                                            controller.CategoryIcon.value = CreditData[index]["img"];
                                            controller.CategoryString.value = CreditData[index]["name"];
                                            controller.SelectedDate.value = CreditData[index]["dt"];

                                            Get.bottomSheet(Container(
                                              height: h * 0.6,
                                              width: w,
                                              decoration: BoxDecoration(
                                                  color: kWhite,
                                                  borderRadius: BorderRadius.only(
                                                      topLeft: Radius.circular(50),
                                                      topRight: Radius.circular(50))),
                                              child: SingleChildScrollView(
                                                physics: BouncingScrollPhysics(),
                                                child: Column(
                                                  children: [
                                                    SizedBox(
                                                      height: h * 0.03,
                                                    ),
                                                    Row(
                                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                      children: [
                                                        controller.CustomRadioEx("Credit", 0),
                                                        controller.CustomRadioEx("Debit", 1),
                                                      ],
                                                    ),
                                                    SizedBox(
                                                      height: h * 0.03,
                                                    ),

                                                    Row(
                                                      children: [
                                                        SizedBox(width: h * 0.015,),
                                                        InkWell(
                                                            onTap: () {

                                                              DateTime? _chosenDateTime;
                                                              Get.bottomSheet(isDismissible: false,

                                                                  Container(
                                                                    height: 650,
                                                                    decoration: BoxDecoration(
                                                                        color: kWhite,
                                                                        borderRadius: BorderRadius.only(topRight: Radius.circular(30), topLeft: Radius.circular(30))
                                                                    ),
                                                                    child: Column(
                                                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                                      children: [
                                                                        SizedBox(height: 320,
                                                                          child: CupertinoDatePicker(
                                                                            mode: CupertinoDatePickerMode.date,
                                                                            initialDateTime: DateTime.now(),
                                                                            minimumYear: 1960,
                                                                            onDateTimeChanged: (value) {

                                                                              controller.SelectedDate.value = value.toString().substring(0, 10);
                                                                            },),
                                                                        ),
                                                                        Row(
                                                                          mainAxisAlignment: MainAxisAlignment.center,
                                                                          children: [
                                                                            InkWell(
                                                                              onTap: () {
                                                                                if(controller.SelectedDate.value == "Select Date"){
                                                                                  controller.SelectedDate.value = DateTime.now().toString().substring(0, 10);
                                                                                }

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
                                                                          ],
                                                                        ),
                                                                        SizedBox(height: h * 0.01,)
                                                                      ],
                                                                    ),
                                                                  )

                                                              );

                                                            },
                                                            child: Image.asset("assets/images/dates.png", width: h * 0.022, color: kDarkBlue3,)),
                                                        SizedBox(width: h * 0.015,),
                                                        InkWell(
                                                          onTap: () {

                                                            DateTime? _chosenDateTime;
                                                            Get.bottomSheet(isDismissible: false,

                                                                Container(
                                                                  height: 650,
                                                                  decoration: BoxDecoration(
                                                                      color: kWhite,
                                                                      borderRadius: BorderRadius.only(topRight: Radius.circular(30), topLeft: Radius.circular(30))
                                                                  ),
                                                                  child: Column(
                                                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                                    children: [
                                                                      SizedBox(height: 320,
                                                                        child: CupertinoDatePicker(
                                                                          mode: CupertinoDatePickerMode.date,
                                                                          initialDateTime: DateTime.now(),
                                                                          minimumYear: 1960,
                                                                          onDateTimeChanged: (value) {

                                                                            controller.SelectedDate.value = value.toString().substring(0, 10);
                                                                          },),
                                                                      ),
                                                                      Row(
                                                                        mainAxisAlignment: MainAxisAlignment.center,
                                                                        children: [
                                                                          InkWell(
                                                                            onTap: () {
                                                                              if(controller.SelectedDate.value == "Select Date"){
                                                                                controller.SelectedDate.value = DateTime.now().toString().substring(0, 10);
                                                                              }

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
                                                                        ],
                                                                      ),
                                                                      SizedBox(height: h * 0.01,)
                                                                    ],
                                                                  ),
                                                                )

                                                            );

                                                          },
                                                          child: Obx(() => textWidget(msg: "${controller.SelectedDate.value}", txtColor: kDarkBlue3, txtFontSize: h * 0.016, txtFontWeight: FontWeight.w600)
                                                          ),
                                                        )
                                                      ],
                                                    ),

                                                    SizedBox(
                                                      height: h * 0.03,
                                                    ),
                                                    Row(
                                                      children: [
                                                        Padding(
                                                          padding: EdgeInsets.only(
                                                            left: h * 0.015,
                                                          ),
                                                          child: textWidget(
                                                              msg: "Title",
                                                              txtColor: kDarkBlue3,
                                                              txtFontSize: h * 0.014,
                                                              txtFontWeight: FontWeight.w600),
                                                        ),
                                                      ],
                                                    ),
                                                    Padding(
                                                      padding: EdgeInsets.all(h * 0.01),
                                                      child: TextField(
                                                        controller: controller.title,
                                                        keyboardType: TextInputType.name,
                                                        cursorColor: kDarkBlue3,
                                                        style: TextStyle(fontSize: h * 0.014),
                                                        onTapOutside: (event) =>
                                                            FocusScope.of(context).unfocus(),
                                                        decoration: InputDecoration(
                                                            border: OutlineInputBorder(
                                                                borderRadius: BorderRadius.circular(12),
                                                                borderSide: BorderSide(
                                                                  color: kDarkBlue3,
                                                                  width: 1,
                                                                )),
                                                            enabledBorder: OutlineInputBorder(
                                                                borderRadius: BorderRadius.circular(12),
                                                                borderSide: BorderSide(
                                                                  color: kDarkBlue3,
                                                                  width: 1,
                                                                )),
                                                            hintText: "Enter Title",
                                                            hintStyle: TextStyle(fontSize: h * 0.014),
                                                            prefixIcon: IconButton(
                                                                onPressed: () {
                                                                  lightImpact();
                                                                  Get.dialog(
                                                                      transitionCurve: Curves.easeInOut,
                                                                      transitionDuration:
                                                                      Duration(milliseconds: 300),
                                                                      FrostedGlass(
                                                                        widget: AlertDialog(
                                                                          backgroundColor:
                                                                          kWhite.withOpacity(0.6),
                                                                          shape: RoundedRectangleBorder(
                                                                              borderRadius:
                                                                              BorderRadius.circular(30)),
                                                                          content: Container(
                                                                            height: h * 0.6,
                                                                            width: w,
                                                                            margin: EdgeInsets.all(h * 0.005),
                                                                            child: Column(
                                                                              children: [

                                                                                Obx(() =>
                                                                                controller.searchCat.value
                                                                                    ? controller.tempCat
                                                                                    .length !=
                                                                                    0
                                                                                    ? Expanded(
                                                                                  child: ListView
                                                                                      .builder(
                                                                                    itemCount:
                                                                                    controller
                                                                                        .tempCat
                                                                                        .length,
                                                                                    itemBuilder:
                                                                                        (context,
                                                                                        index) {
                                                                                      return InkWell(
                                                                                        onTap:
                                                                                            () {
                                                                                          lightImpact();
                                                                                          controller
                                                                                              .CategoryIcon
                                                                                              .value = controller
                                                                                              .tempCat[index]
                                                                                          [
                                                                                          "img"];
                                                                                          controller
                                                                                              .CategoryString
                                                                                              .value = controller
                                                                                              .tempCat[index]
                                                                                          [
                                                                                          "name"];
                                                                                          Navigator.pop(context);
                                                                                        },
                                                                                        child:
                                                                                        Column(
                                                                                          children: [
                                                                                            SizedBox(
                                                                                              height:
                                                                                              h * 0.03,
                                                                                            ),
                                                                                            Row(
                                                                                              children: [
                                                                                                Image.asset(
                                                                                                  controller.tempCat[index]["img"],
                                                                                                  width: h * 0.02,
                                                                                                ),
                                                                                                SizedBox(
                                                                                                  width: w * 0.04,
                                                                                                ),
                                                                                                textWidget(msg: "${controller.tempCat[index]["name"]}", txtColor: kDarkBlue3, txtFontSize: h * 0.016, txtFontWeight: FontWeight.w500)
                                                                                              ],
                                                                                            ),
                                                                                            SizedBox(
                                                                                              height:
                                                                                              h * 0.03,
                                                                                            ),
                                                                                            Container(
                                                                                              height:
                                                                                              h * 0.001,
                                                                                              width:
                                                                                              w,
                                                                                              color:
                                                                                              kDarkBlue3,
                                                                                              margin:
                                                                                              EdgeInsets.all(h * 0.001),
                                                                                            ),
                                                                                          ],
                                                                                        ),
                                                                                      );
                                                                                    },
                                                                                  ),
                                                                                )
                                                                                    : Expanded(
                                                                                  child: ListView
                                                                                      .builder(
                                                                                    itemCount:
                                                                                    cat
                                                                                        .length,
                                                                                    itemBuilder:
                                                                                        (context,
                                                                                        index) {
                                                                                      return InkWell(
                                                                                        onTap: () {
                                                                                          lightImpact();
                                                                                          controller
                                                                                              .CategoryIcon
                                                                                              .value = cat[index]
                                                                                          [
                                                                                          "img"];
                                                                                          controller
                                                                                              .CategoryString
                                                                                              .value = cat[index]
                                                                                          [
                                                                                          "name"];
                                                                                          Navigator.pop(context);
                                                                                        },
                                                                                        child: Column(
                                                                                          children: [
                                                                                            SizedBox(
                                                                                              height:
                                                                                              h * 0.03,
                                                                                            ),
                                                                                            Row(
                                                                                              children: [
                                                                                                cat[index]["img"].toString().length == 1
                                                                                                    ? Container(
                                                                                                  height: h * 0.03,
                                                                                                  width: h * 0.03,
                                                                                                  alignment: Alignment.center,
                                                                                                  decoration: BoxDecoration(
                                                                                                      color: kDarkBlue3,
                                                                                                      borderRadius: BorderRadius.circular(7)
                                                                                                  ),
                                                                                                  child: textWidget(msg: "${cat[index]["img"]}", txtColor: kWhite, txtFontSize: h * 0.02, txtFontWeight: FontWeight.w600),
                                                                                                )
                                                                                                    : Image
                                                                                                    .asset(
                                                                                                  cat[index]
                                                                                                  [
                                                                                                  "img"],
                                                                                                  width:
                                                                                                  h * 0.02,
                                                                                                ),
                                                                                                SizedBox(
                                                                                                  width: w * 0.04,
                                                                                                ),
                                                                                                textWidget(
                                                                                                    msg: "${cat[index]["name"]}",
                                                                                                    txtColor: kDarkBlue3,
                                                                                                    txtFontSize: h * 0.016,
                                                                                                    txtFontWeight: FontWeight.w500)
                                                                                              ],
                                                                                            ),
                                                                                            SizedBox(
                                                                                              height:
                                                                                              h * 0.03,
                                                                                            ),
                                                                                            Container(
                                                                                              height:
                                                                                              h * 0.001,
                                                                                              width:
                                                                                              w,
                                                                                              color:
                                                                                              kDarkBlue3,
                                                                                              margin:
                                                                                              EdgeInsets.all(h * 0.001),
                                                                                            ),
                                                                                          ],
                                                                                        ),
                                                                                      );
                                                                                    },
                                                                                  ),
                                                                                )
                                                                                    : Expanded(
                                                                                  child: ListView
                                                                                      .builder(
                                                                                    itemCount:
                                                                                    cat
                                                                                        .length,
                                                                                    itemBuilder:
                                                                                        (context,
                                                                                        index) {
                                                                                      return InkWell(
                                                                                        onTap: () {
                                                                                          lightImpact();
                                                                                          controller
                                                                                              .CategoryIcon
                                                                                              .value = cat[index]
                                                                                          [
                                                                                          "img"];
                                                                                          controller
                                                                                              .CategoryString
                                                                                              .value = cat[index]
                                                                                          [
                                                                                          "name"];
                                                                                          Navigator.pop(context);
                                                                                        },
                                                                                        child: Column(
                                                                                          children: [
                                                                                            SizedBox(
                                                                                              height: h *
                                                                                                  0.03,
                                                                                            ),
                                                                                            Row(
                                                                                              children: [
                                                                                                cat[index]["img"].toString().length == 1
                                                                                                    ? Container(
                                                                                                  height: h * 0.03,
                                                                                                  width: h * 0.03,
                                                                                                  alignment: Alignment.center,
                                                                                                  decoration: BoxDecoration(
                                                                                                      color: kDarkBlue3,
                                                                                                      borderRadius: BorderRadius.circular(7)
                                                                                                  ),
                                                                                                  child: textWidget(msg: "${cat[index]["img"]}", txtColor: kWhite, txtFontSize: h * 0.02, txtFontWeight: FontWeight.w600),
                                                                                                )
                                                                                                    : Image
                                                                                                    .asset(
                                                                                                  cat[index]
                                                                                                  [
                                                                                                  "img"],
                                                                                                  width:
                                                                                                  h * 0.02,
                                                                                                ),
                                                                                                SizedBox(
                                                                                                  width:
                                                                                                  w * 0.04,
                                                                                                ),
                                                                                                textWidget(
                                                                                                    msg:
                                                                                                    "${cat[index]["name"]}",
                                                                                                    txtColor:
                                                                                                    kDarkBlue3,
                                                                                                    txtFontSize: h *
                                                                                                        0.016,
                                                                                                    txtFontWeight:
                                                                                                    FontWeight.w500)
                                                                                              ],
                                                                                            ),
                                                                                            SizedBox(
                                                                                              height: h *
                                                                                                  0.03,
                                                                                            ),
                                                                                            Container(
                                                                                              height: h *
                                                                                                  0.001,
                                                                                              width: w,
                                                                                              color:
                                                                                              kDarkBlue3,
                                                                                              margin: EdgeInsets
                                                                                                  .all(h *
                                                                                                  0.001),
                                                                                            ),
                                                                                          ],
                                                                                        ),
                                                                                      );
                                                                                    },
                                                                                  ),
                                                                                )),
                                                                              ],
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ));
                                                                },
                                                                icon: Icon(
                                                                  CupertinoIcons.add_circled,
                                                                  color: kDarkBlue3,
                                                                ))),
                                                      ),
                                                    ),
                                                    Row(
                                                      children: [
                                                        Padding(
                                                          padding: EdgeInsets.only(
                                                            left: h * 0.015,
                                                          ),
                                                          child: textWidget(
                                                              msg: "Amount",
                                                              txtColor: kDarkBlue3,
                                                              txtFontSize: h * 0.014,
                                                              txtFontWeight: FontWeight.w600),
                                                        ),
                                                      ],
                                                    ),
                                                    Padding(
                                                      padding: EdgeInsets.all(h * 0.01),
                                                      child: TextField(
                                                        controller: controller.Amount,
                                                        keyboardType: TextInputType.number,
                                                        cursorColor: kDarkBlue3,
                                                        style: TextStyle(fontSize: h * 0.014),
                                                        onTapOutside: (event) =>
                                                            FocusScope.of(context).unfocus(),
                                                        decoration: InputDecoration(
                                                            border: OutlineInputBorder(
                                                                borderRadius: BorderRadius.circular(12),
                                                                borderSide: BorderSide(
                                                                  color: kDarkBlue3,
                                                                  width: 1,
                                                                )),
                                                            enabledBorder: OutlineInputBorder(
                                                                borderRadius: BorderRadius.circular(12),
                                                                borderSide: BorderSide(
                                                                  color: kDarkBlue3,
                                                                  width: 1,
                                                                )),
                                                            hintText: "Enter Amount",
                                                            hintStyle: TextStyle(fontSize: h * 0.014),
                                                            prefixIcon: Column(
                                                              mainAxisAlignment: MainAxisAlignment.center,
                                                              children: [
                                                                textWidget(
                                                                    msg: "₹",
                                                                    txtColor: kDarkBlue3,
                                                                    txtFontSize: h * 0.02,
                                                                    txtFontWeight: FontWeight.w600),
                                                              ],
                                                            )),
                                                      ),
                                                    ),
                                                    Row(
                                                      children: [
                                                        Padding(
                                                          padding: EdgeInsets.only(
                                                            left: h * 0.015,
                                                          ),
                                                          child: textWidget(
                                                              msg: "Description",
                                                              txtColor: kDarkBlue3,
                                                              txtFontSize: h * 0.014,
                                                              txtFontWeight: FontWeight.w600),
                                                        ),
                                                      ],
                                                    ),
                                                    Padding(
                                                      padding: EdgeInsets.all(h * 0.01),
                                                      child: TextField(
                                                        controller: controller.description,
                                                        keyboardType: TextInputType.name,
                                                        maxLines: 4,
                                                        cursorColor: kDarkBlue3,
                                                        style: TextStyle(fontSize: h * 0.014),
                                                        onTapOutside: (event) =>
                                                            FocusScope.of(context).unfocus(),
                                                        decoration: InputDecoration(
                                                          border: OutlineInputBorder(
                                                              borderRadius: BorderRadius.circular(12),
                                                              borderSide: BorderSide(
                                                                color: kDarkBlue3,
                                                                width: 1,
                                                              )),
                                                          enabledBorder: OutlineInputBorder(
                                                              borderRadius: BorderRadius.circular(12),
                                                              borderSide: BorderSide(
                                                                color: kDarkBlue3,
                                                                width: 1,
                                                              )),
                                                          hintText: "Enter Description",
                                                          hintStyle: TextStyle(fontSize: h * 0.014),
                                                        ),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: h * 0.015,
                                                    ),

                                                    InkWell(
                                                      onTap: () async {
                                                        lightImpact();
                                                        controller.onUpdateSubmit(context, CreditData[index]);
                                                        await Future.delayed(Duration(seconds: 1));
                                                        setState(() {

                                                        });
                                                      },
                                                      child: Container(
                                                        height: h * 0.05,
                                                        width: w * 0.95,
                                                        alignment: Alignment.center,
                                                        decoration: BoxDecoration(
                                                            color: kDarkBlue3,
                                                            borderRadius: BorderRadius.circular(15)),
                                                        child: textWidget(
                                                            msg: "Submit",
                                                            txtColor: kWhite,
                                                            txtFontSize: h * 0.016,
                                                            txtFontWeight: FontWeight.w500),
                                                      ),
                                                    ),

                                                    SizedBox(height: h * 0.015,)
                                                  ],
                                                ),
                                              ),
                                            ));
                                            setState(() {

                                            });
                                          },
                                        ),
                                        PullDownMenuItem(
                                          title: 'Delete',
                                          onTap: () {
                                            lightImpact();

                                            showDialog(barrierDismissible: false,context: context, builder: (context) {
                                              return FrostedGlass(widget: AlertDialog(
                                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                                                backgroundColor: kWhite,
                                                content: Container(
                                                  height: h * 0.2,
                                                  width: w,
                                                  decoration: BoxDecoration(

                                                      borderRadius: BorderRadius.circular(30)
                                                  ),
                                                  child: Column(
                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    children: [
                                                      Column(
                                                        children: [
                                                          Row(
                                                            children: [
                                                              Padding(
                                                                padding: EdgeInsets.all(w * 0.05),
                                                                child: textWidget(msg: "Delete Record ?", txtColor: kDarkBlue3, txtFontSize: h * 0.02, txtFontWeight: FontWeight.w700),
                                                              )
                                                            ],
                                                          ),

                                                          Row(
                                                            children: [
                                                              Flexible(
                                                                child: Padding(
                                                                  padding: EdgeInsets.all(w * 0.01),
                                                                  child: textWidget(msg: "Are you sure you want to Delete The Record ?", ovrflw: TextOverflow.fade,txaln: TextAlign.justify,txtColor: kDarkBlue3, txtFontSize: h * 0.016, txtFontWeight: FontWeight.w500),
                                                                ),
                                                              )
                                                            ],
                                                          )],
                                                      ),
                                                      Row(
                                                        mainAxisAlignment: MainAxisAlignment.end,
                                                        children: [
                                                          InkWell(
                                                            onTap: () {
                                                              lightImpact();
                                                              Navigator.pop(context);
                                                            },
                                                            child: Container(
                                                              height: h * 0.04,
                                                              width: w * 0.2,
                                                              margin: EdgeInsets.all(w * 0.03),
                                                              alignment: Alignment.center,
                                                              decoration: BoxDecoration(
                                                                  color: Color(0xffffd9d9),
                                                                  borderRadius: BorderRadius.circular(10)
                                                              ),
                                                              child: textWidget(msg: "No", txtColor: kError, txtFontSize: h * 0.018, txtFontWeight: FontWeight.w600),
                                                            ),
                                                          ),
                                                          InkWell(
                                                            onTap: () {
                                                              lightImpact();
                                                              print("DATA = ${CreditData[index]}");

                                                              if(controller.db != null){
                                                                String qry1 =
                                                                    "DELETE FROM expenses where id = '${CreditData[index]["id"]}'";
                                                                controller.db!.rawDelete(qry1).then((value) {
                                                                  print(value);
                                                                });
                                                              }
                                                              else {
                                                                // Handle the case where db is null (e.g., show error message)
                                                                print("Error: Database connection is not established!");
                                                              }

                                                              Navigator.pop(context);
                                                              Get.offAll(
                                                                      () => home(),
                                                                  transition: Transition.fade,
                                                                  duration: Duration(seconds: 1)
                                                              );
                                                              setState(() {

                                                              });
                                                            },
                                                            child: Container(
                                                              height: h * 0.04,
                                                              width: w * 0.2,
                                                              margin: EdgeInsets.all(w * 0.03),
                                                              alignment: Alignment.center,
                                                              decoration: BoxDecoration(
                                                                  color: Color(
                                                                      0xffc4eeb8),
                                                                  borderRadius: BorderRadius.circular(10)
                                                              ),
                                                              child: textWidget(msg: "Yes", txtColor: kGreen, txtFontSize: h * 0.018, txtFontWeight: FontWeight.w600),
                                                            ),
                                                          ),
                                                        ],
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ));
                                            },);

                                          },
                                        ),
                                      ],
                                      buttonBuilder: (context, showMenu) => CupertinoButton(
                                        onPressed: showMenu,
                                        padding: EdgeInsets.zero,
                                        child: const Icon(
                                          CupertinoIcons.ellipsis_circle,
                                          color: kDarkBlue2,
                                        ),
                                      ),
                                    ),
                                    CreditData[index]["img"].toString().length == 1
                                        ? Container(
                                      height: h * 0.03,
                                      width: h * 0.03,
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                          color: kDarkBlue3,
                                          borderRadius: BorderRadius.circular(7)
                                      ),
                                      child: textWidget(msg: "${CreditData[index]["img"]}", txtColor: kWhite, txtFontSize: h * 0.02, txtFontWeight: FontWeight.w600),
                                    )
                                        : Image
                                        .asset(
                                      CreditData[index]
                                      [
                                      "img"],
                                      width:
                                      h * 0.025,
                                    ),
                                    SizedBox(width: w * 0.05,),
                                    textWidget(msg: "${CreditData[index]["title"]}", txtColor: kDarkBlue3, txtFontSize: h * 0.016, txtFontWeight: FontWeight.w500)
                                  ],
                                ),
                                Row(
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(right: w * 0.05),
                                      child: textWidget(msg: "₹ ${CreditData[index]["amount"]}/-", txtColor: kDarkBlue3, txtFontSize: h * 0.016, txtFontWeight: FontWeight.w600),
                                    ),

                                  ],
                                ),

                              ],
                            ),
                          );
                        },
                      )
                          : Center(
                        child: CircularProgressIndicator(
                          color: kDarkBlue3,
                          strokeWidth: 3,
                        ),
                      ))
                  ),
                ],
              ),
            ),
          ),

          Expanded(
            child: Container(
              width: w,
              child: Column(
                children: [
                  SizedBox(height: h * 0.01,),
                  Container(
                    height: h * 0.04,
                    width: w * 0.95,
                    decoration: BoxDecoration(
                      color: kDarkBlue3.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding:  EdgeInsets.only(left: w * 0.05),
                          child: textWidget(msg: "Total Expense [ Debit ]", txtColor: kDarkBlue3, txtFontSize: h * 0.016, txtFontWeight: FontWeight.w600),
                        ),
                        Padding(
                          padding:  EdgeInsets.only(right: w * 0.05),
                          child: textWidget(msg: "₹ ${DebitTotal.round()}/-", txtColor: kDarkBlue3, txtFontSize: h * 0.016, txtFontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: h * 0.01,),
                  Expanded(
                      child: Obx(() => controller.status.value
                          ? DebitData.isEmpty
                          ? Center(
                        child: textWidget(msg: "No Expense Found", txtColor: kDarkBlue3, txtFontSize: h * 0.016, txtFontWeight: FontWeight.w600),
                      )
                          :ListView.builder(
                        itemCount: DebitData.length,
                        itemBuilder: (context, index) {

                          return Container(
                            height: h * 0.05,
                            width: w * 0.95,
                            margin: EdgeInsets.only(left: h * 0.01, right: h * 0.01, top: h * 0.01),
                            decoration: BoxDecoration(
                                color: kWhite,
                                borderRadius: BorderRadius.circular(10)
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    SizedBox(width: w * 0.01,),
                                    PullDownButton(
                                      itemBuilder: (context) => [

                                        PullDownMenuItem(
                                          title: 'Edit',
                                          onTap: () {
                                            lightImpact();

                                            controller.title.text = DebitData[index]["title"];
                                            controller.Amount.text = DebitData[index]["amount"];
                                            controller.description.text = DebitData[index]["description"];
                                            controller.valex.value = DebitData[index]["mode"].toString() == "Credit" ? 0 : 1;
                                            controller.Ex.value = DebitData[index]["mode"];
                                            controller.CategoryIcon.value = DebitData[index]["img"];
                                            controller.CategoryString.value = DebitData[index]["name"];
                                            controller.SelectedDate.value = DebitData[index]["dt"];

                                            Get.bottomSheet(Container(
                                              height: h * 0.6,
                                              width: w,
                                              decoration: BoxDecoration(
                                                  color: kWhite,
                                                  borderRadius: BorderRadius.only(
                                                      topLeft: Radius.circular(50),
                                                      topRight: Radius.circular(50))),
                                              child: SingleChildScrollView(
                                                physics: BouncingScrollPhysics(),
                                                child: Column(
                                                  children: [
                                                    SizedBox(
                                                      height: h * 0.03,
                                                    ),
                                                    Row(
                                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                      children: [
                                                        controller.CustomRadioEx("Credit", 0),
                                                        controller.CustomRadioEx("Debit", 1),
                                                      ],
                                                    ),
                                                    SizedBox(
                                                      height: h * 0.03,
                                                    ),

                                                    Row(
                                                      children: [
                                                        SizedBox(width: h * 0.015,),
                                                        InkWell(
                                                            onTap: () {

                                                              DateTime? _chosenDateTime;
                                                              Get.bottomSheet(isDismissible: false,

                                                                  Container(
                                                                    height: 650,
                                                                    decoration: BoxDecoration(
                                                                        color: kWhite,
                                                                        borderRadius: BorderRadius.only(topRight: Radius.circular(30), topLeft: Radius.circular(30))
                                                                    ),
                                                                    child: Column(
                                                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                                      children: [
                                                                        SizedBox(height: 320,
                                                                          child: CupertinoDatePicker(
                                                                            mode: CupertinoDatePickerMode.date,
                                                                            initialDateTime: DateTime.now(),
                                                                            minimumYear: 1960,
                                                                            onDateTimeChanged: (value) {

                                                                              controller.SelectedDate.value = value.toString().substring(0, 10);
                                                                            },),
                                                                        ),
                                                                        Row(
                                                                          mainAxisAlignment: MainAxisAlignment.center,
                                                                          children: [
                                                                            InkWell(
                                                                              onTap: () {
                                                                                if(controller.SelectedDate.value == "Select Date"){
                                                                                  controller.SelectedDate.value = DateTime.now().toString().substring(0, 10);
                                                                                }

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
                                                                          ],
                                                                        ),
                                                                        SizedBox(height: h * 0.01,)
                                                                      ],
                                                                    ),
                                                                  )

                                                              );

                                                            },
                                                            child: Image.asset("assets/images/dates.png", width: h * 0.022, color: kDarkBlue3,)),
                                                        SizedBox(width: h * 0.015,),
                                                        InkWell(
                                                          onTap: () {

                                                            DateTime? _chosenDateTime;
                                                            Get.bottomSheet(isDismissible: false,

                                                                Container(
                                                                  height: 650,
                                                                  decoration: BoxDecoration(
                                                                      color: kWhite,
                                                                      borderRadius: BorderRadius.only(topRight: Radius.circular(30), topLeft: Radius.circular(30))
                                                                  ),
                                                                  child: Column(
                                                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                                    children: [
                                                                      SizedBox(height: 320,
                                                                        child: CupertinoDatePicker(
                                                                          mode: CupertinoDatePickerMode.date,
                                                                          initialDateTime: DateTime.now(),
                                                                          minimumYear: 1960,
                                                                          onDateTimeChanged: (value) {

                                                                            controller.SelectedDate.value = value.toString().substring(0, 10);
                                                                          },),
                                                                      ),
                                                                      Row(
                                                                        mainAxisAlignment: MainAxisAlignment.center,
                                                                        children: [
                                                                          InkWell(
                                                                            onTap: () {
                                                                              if(controller.SelectedDate.value == "Select Date"){
                                                                                controller.SelectedDate.value = DateTime.now().toString().substring(0, 10);
                                                                              }

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
                                                                        ],
                                                                      ),
                                                                      SizedBox(height: h * 0.01,)
                                                                    ],
                                                                  ),
                                                                )

                                                            );

                                                          },
                                                          child: Obx(() => textWidget(msg: "${controller.SelectedDate.value}", txtColor: kDarkBlue3, txtFontSize: h * 0.016, txtFontWeight: FontWeight.w600)
                                                          ),
                                                        )
                                                      ],
                                                    ),

                                                    SizedBox(
                                                      height: h * 0.03,
                                                    ),
                                                    Row(
                                                      children: [
                                                        Padding(
                                                          padding: EdgeInsets.only(
                                                            left: h * 0.015,
                                                          ),
                                                          child: textWidget(
                                                              msg: "Title",
                                                              txtColor: kDarkBlue3,
                                                              txtFontSize: h * 0.014,
                                                              txtFontWeight: FontWeight.w600),
                                                        ),
                                                      ],
                                                    ),
                                                    Padding(
                                                      padding: EdgeInsets.all(h * 0.01),
                                                      child: TextField(
                                                        controller: controller.title,
                                                        keyboardType: TextInputType.name,
                                                        cursorColor: kDarkBlue3,
                                                        style: TextStyle(fontSize: h * 0.014),
                                                        onTapOutside: (event) =>
                                                            FocusScope.of(context).unfocus(),
                                                        decoration: InputDecoration(
                                                            border: OutlineInputBorder(
                                                                borderRadius: BorderRadius.circular(12),
                                                                borderSide: BorderSide(
                                                                  color: kDarkBlue3,
                                                                  width: 1,
                                                                )),
                                                            enabledBorder: OutlineInputBorder(
                                                                borderRadius: BorderRadius.circular(12),
                                                                borderSide: BorderSide(
                                                                  color: kDarkBlue3,
                                                                  width: 1,
                                                                )),
                                                            hintText: "Enter Title",
                                                            hintStyle: TextStyle(fontSize: h * 0.014),
                                                            prefixIcon: IconButton(
                                                                onPressed: () {
                                                                  lightImpact();
                                                                  Get.dialog(
                                                                      transitionCurve: Curves.easeInOut,
                                                                      transitionDuration:
                                                                      Duration(milliseconds: 300),
                                                                      FrostedGlass(
                                                                        widget: AlertDialog(
                                                                          backgroundColor:
                                                                          kWhite.withOpacity(0.6),
                                                                          shape: RoundedRectangleBorder(
                                                                              borderRadius:
                                                                              BorderRadius.circular(30)),
                                                                          content: Container(
                                                                            height: h * 0.6,
                                                                            width: w,
                                                                            margin: EdgeInsets.all(h * 0.005),
                                                                            child: Column(
                                                                              children: [

                                                                                Obx(() =>
                                                                                controller.searchCat.value
                                                                                    ? controller.tempCat
                                                                                    .length !=
                                                                                    0
                                                                                    ? Expanded(
                                                                                  child: ListView
                                                                                      .builder(
                                                                                    itemCount:
                                                                                    controller
                                                                                        .tempCat
                                                                                        .length,
                                                                                    itemBuilder:
                                                                                        (context,
                                                                                        index) {
                                                                                      return InkWell(
                                                                                        onTap:
                                                                                            () {
                                                                                          lightImpact();
                                                                                          controller
                                                                                              .CategoryIcon
                                                                                              .value = controller
                                                                                              .tempCat[index]
                                                                                          [
                                                                                          "img"];
                                                                                          controller
                                                                                              .CategoryString
                                                                                              .value = controller
                                                                                              .tempCat[index]
                                                                                          [
                                                                                          "name"];
                                                                                          Navigator.pop(context);
                                                                                        },
                                                                                        child:
                                                                                        Column(
                                                                                          children: [
                                                                                            SizedBox(
                                                                                              height:
                                                                                              h * 0.03,
                                                                                            ),
                                                                                            Row(
                                                                                              children: [
                                                                                                Image.asset(
                                                                                                  controller.tempCat[index]["img"],
                                                                                                  width: h * 0.02,
                                                                                                ),
                                                                                                SizedBox(
                                                                                                  width: w * 0.04,
                                                                                                ),
                                                                                                textWidget(msg: "${controller.tempCat[index]["name"]}", txtColor: kDarkBlue3, txtFontSize: h * 0.016, txtFontWeight: FontWeight.w500)
                                                                                              ],
                                                                                            ),
                                                                                            SizedBox(
                                                                                              height:
                                                                                              h * 0.03,
                                                                                            ),
                                                                                            Container(
                                                                                              height:
                                                                                              h * 0.001,
                                                                                              width:
                                                                                              w,
                                                                                              color:
                                                                                              kDarkBlue3,
                                                                                              margin:
                                                                                              EdgeInsets.all(h * 0.001),
                                                                                            ),
                                                                                          ],
                                                                                        ),
                                                                                      );
                                                                                    },
                                                                                  ),
                                                                                )
                                                                                    : Expanded(
                                                                                  child: ListView
                                                                                      .builder(
                                                                                    itemCount:
                                                                                    cat
                                                                                        .length,
                                                                                    itemBuilder:
                                                                                        (context,
                                                                                        index) {
                                                                                      return InkWell(
                                                                                        onTap: () {
                                                                                          lightImpact();
                                                                                          controller
                                                                                              .CategoryIcon
                                                                                              .value = cat[index]
                                                                                          [
                                                                                          "img"];
                                                                                          controller
                                                                                              .CategoryString
                                                                                              .value = cat[index]
                                                                                          [
                                                                                          "name"];
                                                                                          Navigator.pop(context);
                                                                                        },
                                                                                        child: Column(
                                                                                          children: [
                                                                                            SizedBox(
                                                                                              height:
                                                                                              h * 0.03,
                                                                                            ),
                                                                                            Row(
                                                                                              children: [
                                                                                                cat[index]["img"].toString().length == 1
                                                                                                    ? Container(
                                                                                                  height: h * 0.03,
                                                                                                  width: h * 0.03,
                                                                                                  alignment: Alignment.center,
                                                                                                  decoration: BoxDecoration(
                                                                                                      color: kDarkBlue3,
                                                                                                      borderRadius: BorderRadius.circular(7)
                                                                                                  ),
                                                                                                  child: textWidget(msg: "${cat[index]["img"]}", txtColor: kWhite, txtFontSize: h * 0.02, txtFontWeight: FontWeight.w600),
                                                                                                )
                                                                                                    : Image
                                                                                                    .asset(
                                                                                                  cat[index]
                                                                                                  [
                                                                                                  "img"],
                                                                                                  width:
                                                                                                  h * 0.02,
                                                                                                ),
                                                                                                SizedBox(
                                                                                                  width: w * 0.04,
                                                                                                ),
                                                                                                textWidget(
                                                                                                    msg: "${cat[index]["name"]}",
                                                                                                    txtColor: kDarkBlue3,
                                                                                                    txtFontSize: h * 0.016,
                                                                                                    txtFontWeight: FontWeight.w500)
                                                                                              ],
                                                                                            ),
                                                                                            SizedBox(
                                                                                              height:
                                                                                              h * 0.03,
                                                                                            ),
                                                                                            Container(
                                                                                              height:
                                                                                              h * 0.001,
                                                                                              width:
                                                                                              w,
                                                                                              color:
                                                                                              kDarkBlue3,
                                                                                              margin:
                                                                                              EdgeInsets.all(h * 0.001),
                                                                                            ),
                                                                                          ],
                                                                                        ),
                                                                                      );
                                                                                    },
                                                                                  ),
                                                                                )
                                                                                    : Expanded(
                                                                                  child: ListView
                                                                                      .builder(
                                                                                    itemCount:
                                                                                    cat
                                                                                        .length,
                                                                                    itemBuilder:
                                                                                        (context,
                                                                                        index) {
                                                                                      return InkWell(
                                                                                        onTap: () {
                                                                                          lightImpact();
                                                                                          controller
                                                                                              .CategoryIcon
                                                                                              .value = cat[index]
                                                                                          [
                                                                                          "img"];
                                                                                          controller
                                                                                              .CategoryString
                                                                                              .value = cat[index]
                                                                                          [
                                                                                          "name"];
                                                                                          Navigator.pop(context);
                                                                                        },
                                                                                        child: Column(
                                                                                          children: [
                                                                                            SizedBox(
                                                                                              height: h *
                                                                                                  0.03,
                                                                                            ),
                                                                                            Row(
                                                                                              children: [
                                                                                                cat[index]["img"].toString().length == 1
                                                                                                    ? Container(
                                                                                                  height: h * 0.03,
                                                                                                  width: h * 0.03,
                                                                                                  alignment: Alignment.center,
                                                                                                  decoration: BoxDecoration(
                                                                                                      color: kDarkBlue3,
                                                                                                      borderRadius: BorderRadius.circular(7)
                                                                                                  ),
                                                                                                  child: textWidget(msg: "${cat[index]["img"]}", txtColor: kWhite, txtFontSize: h * 0.02, txtFontWeight: FontWeight.w600),
                                                                                                )
                                                                                                    : Image
                                                                                                    .asset(
                                                                                                  cat[index]
                                                                                                  [
                                                                                                  "img"],
                                                                                                  width:
                                                                                                  h * 0.02,
                                                                                                ),
                                                                                                SizedBox(
                                                                                                  width:
                                                                                                  w * 0.04,
                                                                                                ),
                                                                                                textWidget(
                                                                                                    msg:
                                                                                                    "${cat[index]["name"]}",
                                                                                                    txtColor:
                                                                                                    kDarkBlue3,
                                                                                                    txtFontSize: h *
                                                                                                        0.016,
                                                                                                    txtFontWeight:
                                                                                                    FontWeight.w500)
                                                                                              ],
                                                                                            ),
                                                                                            SizedBox(
                                                                                              height: h *
                                                                                                  0.03,
                                                                                            ),
                                                                                            Container(
                                                                                              height: h *
                                                                                                  0.001,
                                                                                              width: w,
                                                                                              color:
                                                                                              kDarkBlue3,
                                                                                              margin: EdgeInsets
                                                                                                  .all(h *
                                                                                                  0.001),
                                                                                            ),
                                                                                          ],
                                                                                        ),
                                                                                      );
                                                                                    },
                                                                                  ),
                                                                                )),
                                                                              ],
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ));
                                                                },
                                                                icon: Icon(
                                                                  CupertinoIcons.add_circled,
                                                                  color: kDarkBlue3,
                                                                ))),
                                                      ),
                                                    ),
                                                    Row(
                                                      children: [
                                                        Padding(
                                                          padding: EdgeInsets.only(
                                                            left: h * 0.015,
                                                          ),
                                                          child: textWidget(
                                                              msg: "Amount",
                                                              txtColor: kDarkBlue3,
                                                              txtFontSize: h * 0.014,
                                                              txtFontWeight: FontWeight.w600),
                                                        ),
                                                      ],
                                                    ),
                                                    Padding(
                                                      padding: EdgeInsets.all(h * 0.01),
                                                      child: TextField(
                                                        controller: controller.Amount,
                                                        keyboardType: TextInputType.number,
                                                        cursorColor: kDarkBlue3,
                                                        style: TextStyle(fontSize: h * 0.014),
                                                        onTapOutside: (event) =>
                                                            FocusScope.of(context).unfocus(),
                                                        decoration: InputDecoration(
                                                            border: OutlineInputBorder(
                                                                borderRadius: BorderRadius.circular(12),
                                                                borderSide: BorderSide(
                                                                  color: kDarkBlue3,
                                                                  width: 1,
                                                                )),
                                                            enabledBorder: OutlineInputBorder(
                                                                borderRadius: BorderRadius.circular(12),
                                                                borderSide: BorderSide(
                                                                  color: kDarkBlue3,
                                                                  width: 1,
                                                                )),
                                                            hintText: "Enter Amount",
                                                            hintStyle: TextStyle(fontSize: h * 0.014),
                                                            prefixIcon: Column(
                                                              mainAxisAlignment: MainAxisAlignment.center,
                                                              children: [
                                                                textWidget(
                                                                    msg: "₹",
                                                                    txtColor: kDarkBlue3,
                                                                    txtFontSize: h * 0.02,
                                                                    txtFontWeight: FontWeight.w600),
                                                              ],
                                                            )),
                                                      ),
                                                    ),
                                                    Row(
                                                      children: [
                                                        Padding(
                                                          padding: EdgeInsets.only(
                                                            left: h * 0.015,
                                                          ),
                                                          child: textWidget(
                                                              msg: "Description",
                                                              txtColor: kDarkBlue3,
                                                              txtFontSize: h * 0.014,
                                                              txtFontWeight: FontWeight.w600),
                                                        ),
                                                      ],
                                                    ),
                                                    Padding(
                                                      padding: EdgeInsets.all(h * 0.01),
                                                      child: TextField(
                                                        controller: controller.description,
                                                        keyboardType: TextInputType.name,
                                                        maxLines: 4,
                                                        cursorColor: kDarkBlue3,
                                                        style: TextStyle(fontSize: h * 0.014),
                                                        onTapOutside: (event) =>
                                                            FocusScope.of(context).unfocus(),
                                                        decoration: InputDecoration(
                                                          border: OutlineInputBorder(
                                                              borderRadius: BorderRadius.circular(12),
                                                              borderSide: BorderSide(
                                                                color: kDarkBlue3,
                                                                width: 1,
                                                              )),
                                                          enabledBorder: OutlineInputBorder(
                                                              borderRadius: BorderRadius.circular(12),
                                                              borderSide: BorderSide(
                                                                color: kDarkBlue3,
                                                                width: 1,
                                                              )),
                                                          hintText: "Enter Description",
                                                          hintStyle: TextStyle(fontSize: h * 0.014),
                                                        ),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: h * 0.015,
                                                    ),

                                                    InkWell(
                                                      onTap: () async {
                                                        lightImpact();
                                                        controller.onUpdateSubmit(context, DebitData[index]);
                                                        await Future.delayed(Duration(seconds: 1));
                                                        setState(() {

                                                        });
                                                      },
                                                      child: Container(
                                                        height: h * 0.05,
                                                        width: w * 0.95,
                                                        alignment: Alignment.center,
                                                        decoration: BoxDecoration(
                                                            color: kDarkBlue3,
                                                            borderRadius: BorderRadius.circular(15)),
                                                        child: textWidget(
                                                            msg: "Submit",
                                                            txtColor: kWhite,
                                                            txtFontSize: h * 0.016,
                                                            txtFontWeight: FontWeight.w500),
                                                      ),
                                                    ),

                                                    SizedBox(height: h * 0.015,)
                                                  ],
                                                ),
                                              ),
                                            ));
                                          },
                                        ),
                                        PullDownMenuItem(
                                          title: 'Delete',
                                          onTap: () {
                                            lightImpact();

                                            showDialog(barrierDismissible: false,context: context, builder: (context) {
                                              return FrostedGlass(widget: AlertDialog(
                                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                                                backgroundColor: kWhite,
                                                content: Container(
                                                  height: h * 0.2,
                                                  width: w,
                                                  decoration: BoxDecoration(

                                                      borderRadius: BorderRadius.circular(30)
                                                  ),
                                                  child: Column(
                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    children: [
                                                      Column(
                                                        children: [
                                                          Row(
                                                            children: [
                                                              Padding(
                                                                padding: EdgeInsets.all(w * 0.05),
                                                                child: textWidget(msg: "Delete Record ?", txtColor: kDarkBlue3, txtFontSize: h * 0.02, txtFontWeight: FontWeight.w700),
                                                              )
                                                            ],
                                                          ),

                                                          Row(
                                                            children: [
                                                              Flexible(
                                                                child: Padding(
                                                                  padding: EdgeInsets.all(w * 0.01),
                                                                  child: textWidget(msg: "Are you sure you want to Delete The Record ?", ovrflw: TextOverflow.fade,txaln: TextAlign.justify,txtColor: kDarkBlue3, txtFontSize: h * 0.016, txtFontWeight: FontWeight.w500),
                                                                ),
                                                              )
                                                            ],
                                                          )],
                                                      ),
                                                      Row(
                                                        mainAxisAlignment: MainAxisAlignment.end,
                                                        children: [
                                                          InkWell(
                                                            onTap: () {
                                                              lightImpact();
                                                              Navigator.pop(context);
                                                            },
                                                            child: Container(
                                                              height: h * 0.04,
                                                              width: w * 0.2,
                                                              margin: EdgeInsets.all(w * 0.03),
                                                              alignment: Alignment.center,
                                                              decoration: BoxDecoration(
                                                                  color: Color(0xffffd9d9),
                                                                  borderRadius: BorderRadius.circular(10)
                                                              ),
                                                              child: textWidget(msg: "No", txtColor: kError, txtFontSize: h * 0.018, txtFontWeight: FontWeight.w600),
                                                            ),
                                                          ),
                                                          InkWell(
                                                            onTap: () {
                                                              lightImpact();
                                                              print("DATA = ${DebitData[index]}");

                                                              if(controller.db != null){
                                                                String qry1 =
                                                                    "DELETE FROM expenses where id = '${DebitData[index]["id"]}'";
                                                                controller.db!.rawDelete(qry1).then((value) {
                                                                  print(value);
                                                                });
                                                              }
                                                              else {
                                                                // Handle the case where db is null (e.g., show error message)
                                                                print("Error: Database connection is not established!");
                                                              }

                                                              Navigator.pop(context);
                                                              Get.offAll(
                                                                      () => home(),
                                                                  transition: Transition.fade,
                                                                  duration: Duration(seconds: 1)
                                                              );
                                                              setState(() {

                                                              });
                                                            },
                                                            child: Container(
                                                              height: h * 0.04,
                                                              width: w * 0.2,
                                                              margin: EdgeInsets.all(w * 0.03),
                                                              alignment: Alignment.center,
                                                              decoration: BoxDecoration(
                                                                  color: Color(
                                                                      0xffc4eeb8),
                                                                  borderRadius: BorderRadius.circular(10)
                                                              ),
                                                              child: textWidget(msg: "Yes", txtColor: kGreen, txtFontSize: h * 0.018, txtFontWeight: FontWeight.w600),
                                                            ),
                                                          ),
                                                        ],
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ));
                                            },);



                                          },
                                        ),
                                      ],
                                      buttonBuilder: (context, showMenu) => CupertinoButton(
                                        onPressed: showMenu,
                                        padding: EdgeInsets.zero,
                                        child: const Icon(
                                          CupertinoIcons.ellipsis_circle,
                                          color: kDarkBlue2,
                                        ),
                                      ),
                                    ),
                                    DebitData[index]["img"].toString().length == 1
                                        ? Container(
                                      height: h * 0.03,
                                      width: h * 0.03,
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                          color: kDarkBlue3,
                                          borderRadius: BorderRadius.circular(7)
                                      ),
                                      child: textWidget(msg: "${DebitData[index]["img"]}", txtColor: kWhite, txtFontSize: h * 0.02, txtFontWeight: FontWeight.w600),
                                    )
                                        : Image
                                        .asset(
                                      DebitData[index]
                                      [
                                      "img"],
                                      width:
                                      h * 0.025,
                                    ),
                                    SizedBox(width: w * 0.05,),
                                    textWidget(msg: "${DebitData[index]["title"]}", txtColor: kDarkBlue3, txtFontSize: h * 0.016, txtFontWeight: FontWeight.w500)
                                  ],
                                ),
                                Row(
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(right: w * 0.05),
                                      child: textWidget(msg: "₹ ${DebitData[index]["amount"]}/-", txtColor: kDarkBlue3, txtFontSize: h * 0.016, txtFontWeight: FontWeight.w600),
                                    ),

                                  ],
                                ),

                              ],
                            ),
                          );
                        },
                      )
                          : Center(
                        child: CircularProgressIndicator(
                          color: kDarkBlue3,
                          strokeWidth: 3,
                        ),
                      ))
                  ),
                ],
              ),
            ),
          ),

        ],
      ),
    );
  }
}


class dailyController extends GetxController{

  final search = TextEditingController();

  RxInt valex = 1.obs;
  RxString Ex = "Debit".obs;

  Database? db;



  Widget CustomRadioEx(String text, int index) {
    return Obx(() => InkWell(
      onTap: () {
        valex.value = index;
        Ex.value = text;
      },
      child: Container(
        height: h * 0.04,
        width: w * 0.3,
        alignment: Alignment.center,
        decoration: BoxDecoration(
            color: valex.value == index ? kDarkBlue3 : kWhite,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(width: 1, color: kDarkBlue3)),
        child: textWidget(
            msg: "$text",
            txtColor: valex.value == index ? kWhite : kDarkBlue3,
            txtFontSize: h * 0.016,
            txtFontWeight: FontWeight.w500),
      ),
    ));
  }

  final title = TextEditingController();
  final Amount = TextEditingController();
  final description = TextEditingController();

  RxBool searchCat = false.obs;
  List<Map> tempCat = [];

  catSearch(String value) {
    searchCat.value = false;
    tempCat.clear();
    if (value.isNotEmpty) {
      searchCat.value = true;
      tempCat.clear();

      for (int i = 0; i < cat.length; i++) {
        if (cat[i]["name"]
            .toString()
            .toLowerCase()
            .contains(value.toString().trim().toLowerCase())) {
          tempCat.add(cat[i]);
        }
      }
    } else {
      searchCat.value = false;
    }
  }

  RxString CategoryIcon = "".obs;
  RxString CategoryString = "".obs;

  onSubmit(BuildContext context) {
    lightImpact();

    if (SelectedDate.value.isEmpty) {
      Get.snackbar("Error", "Please Select Date ...!",
          backgroundColor: kError,
          colorText: kWhite,
          duration: Duration(seconds: 2));
    }
    else if (CategoryIcon.value.isEmpty) {
      Get.snackbar("Error", "Please Select Category ...!",
          backgroundColor: kError,
          colorText: kWhite,
          duration: Duration(seconds: 2));
    }
    else if (title.text.trim().isEmpty) {
      Get.snackbar("Error", "Please Enter Title ...!",
          backgroundColor: kError,
          colorText: kWhite,
          duration: Duration(seconds: 2));
    } else if (Amount.text.trim().isEmpty) {
      Get.snackbar("Error", "Please Enter Amount ...!",
          backgroundColor: kError,
          colorText: kWhite,
          duration: Duration(seconds: 2));
    } else {
      String qry =
          "INSERT INTO expenses (title, amount, description, mode, img, name, dt) values ('${title.text.trim()}', '${Amount.text.trim()}', '${description.text.trim()}', '${Ex.value}', '${CategoryIcon.value}', '${CategoryString.value}', '${SelectedDate.value}')";
      db!.rawInsert(qry).then((value) {
        print(value);
      });



      title.text = "";
      Amount.text = "";
      description.text = "";

      Navigator.pop(context);

      Get.snackbar("Success", "Data Added Successfull ...!",
          backgroundColor: kGreen,
          colorText: kWhite,
          duration: Duration(seconds: 2));

      Model().dataList(DateTime.now().toString().substring(0, 10));

    }
  }

  RxString SelectedDate = "Select Date".obs;

  String getWeekdayName(int weekday) {
    if(weekday == 1){
      return "Monday";
    }
    else if(weekday == 2){
      return "Tuesday";
    }
    else if(weekday == 3){
      return "Wednesday";
    }else if(weekday == 4){
      return "Thursday";
    }
    else if(weekday == 5){
      return "Friday";
    }
    else if(weekday == 6){
      return "Saturday";
    }
    else{
      return "Sunday";
    }

  }

  String getMonthName(int month) {
    final format = DateFormat('MMMM'); // MMMM for full month names
    return format.format(DateTime(2024, month, 1)); // Set day to 1 for any month
  }

  RxString TodayDate = DateTime.now().day.toString().obs;
  RxString month = "".obs;
  RxString dayStr = "".obs;
  RxString valDate = "".obs;
  RxBool status = false.obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    Model().createDatabase().then((value) {
      db = value;
    });
    month.value = "${getMonthName(DateTime.now().month)}, ${DateTime.now().year}";
    dayStr.value = getWeekdayName(DateTime.now().weekday);
    getData(DateTime.now().toString().substring(0, 10));
    status.value = true;

  }


  getData(String dt) async {

    status.value = false;
    Model().dataList(dt);
    await Future.delayed(Duration(seconds: 1));
    status.value = true;

  }

  void onUpdateSubmit(BuildContext context, debitData) {
    lightImpact();

    if (SelectedDate.value.isEmpty) {
      Get.snackbar("Error", "Please Select Date ...!",
          backgroundColor: kError,
          colorText: kWhite,
          duration: Duration(seconds: 2));
    }
    else if (CategoryIcon.value.isEmpty) {
      Get.snackbar("Error", "Please Select Category ...!",
          backgroundColor: kError,
          colorText: kWhite,
          duration: Duration(seconds: 2));
    }
    else if (title.text.trim().isEmpty) {
      Get.snackbar("Error", "Please Enter Title ...!",
          backgroundColor: kError,
          colorText: kWhite,
          duration: Duration(seconds: 2));
    } else if (Amount.text.trim().isEmpty) {
      Get.snackbar("Error", "Please Enter Amount ...!",
          backgroundColor: kError,
          colorText: kWhite,
          duration: Duration(seconds: 2));
    } else {
      String qry =
          "UPDATE expenses set title = '${title.text.trim()}' , amount  = '${Amount.text.trim()}' , description = '${description.text.trim()}' , mode = '${Ex.value}' , img = '${CategoryIcon.value}' , name = '${CategoryString.value}', dt = '${SelectedDate.value}' where id = '${debitData["id"]}'";
      db!.rawUpdate(qry).then((value) {
        print(value);
      });



      title.text = "";
      Amount.text = "";
      description.text = "";

      Get.offAll(
          () => home(),
        transition: Transition.fade,
        duration: Duration(seconds: 1)
      );

      Get.snackbar("Success", "Data Updated Successfull ...!",
          backgroundColor: kGreen,
          colorText: kWhite,
          duration: Duration(seconds: 2));



    }
  }


}