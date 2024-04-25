import 'dart:convert';

import 'package:daytoday/global/globals.dart';
import 'package:daytoday/global/haptic.dart';
import 'package:daytoday/pages/login.dart';
import 'package:daytoday/pages/setting/cate.dart';
import 'package:daytoday/pages/setting/category.dart';
import 'package:daytoday/pages/setting/profile.dart';
import 'package:daytoday/pages/setting/saveAsExcel.dart';
import 'package:daytoday/pages/setting/theme.dart';
import 'package:daytoday/widgets/text.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:http/http.dart' as http;
import 'package:sqflite/sqflite.dart';
import '../global/Model.dart';
import '../global/variables.dart';
import 'home.dart';

class settings extends StatefulWidget {
  const settings({super.key});

  @override
  State<settings> createState() => _settingsState();
}

class _settingsState extends State<settings> {

  bool light = false;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Get.offAll(
                () => home(),
            transition: Transition.fade,
            duration: Duration(seconds: 1)
        );
        return true;
      },
      child: Scaffold(
        backgroundColor: kHomeBG,
        appBar: AppBar(
          backgroundColor: kDarkBlue3,
          leading: IconButton(
              onPressed: () {
                Get.offAll(
                        () => home(),
                    transition: Transition.fade,
                    duration: Duration(seconds: 1)
                );
              },
              icon: Icon(
                CupertinoIcons.left_chevron,
                color: kWhite,
              )),
          centerTitle: true,
          title: textWidget(
              msg: "Settings",
              txtColor: kWhite,
              txtFontSize: h * 0.02,
              txtFontWeight: FontWeight.w600),
        ),
        body: Column(
          children: [
            Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(left: h * 0.01, top: h * 0.01),
                  child: textWidget(
                      msg: "General",
                      txtColor: kDarkBlue3,
                      txtFontSize: h * 0.018,
                      txtFontWeight: FontWeight.w600),
                ),
              ],
            ),

            Row(
              children: [
                Container(
                  height: 2,
                  width: w * 0.05,
                  margin: EdgeInsets.only(left: h * 0.01, top: h * 0.005),
                  color: kDarkBlue3,
                ),
              ],
            ),

            SizedBox(
              height: h * 0.015,
            ),

            //options
            InkWell(
              onTap: () {
                lightImpact();
                Get.to(() => profile(),
                    transition: Transition.fade, duration: Duration(seconds: 1));
              },
              child: Container(
                height: h * 0.08,
                width: w * 0.95,
                decoration: BoxDecoration(
                    color: kWhite, borderRadius: BorderRadius.circular(15)),
                child: Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: w * 0.07),
                      child: Image.asset(
                        "assets/images/profile.png",
                        width: h * 0.03,
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: w * 0.07),
                          child: textWidget(
                              msg: "Profile",
                              txtColor: kDarkBlue3,
                              txtFontSize: h * 0.016,
                              txtFontWeight: FontWeight.w600),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: w * 0.07),
                          child: textWidget(
                              msg: "Manage Your Profile",
                              txtColor: kDarkBlue3,
                              txtFontSize: h * 0.014,
                              txtFontWeight: FontWeight.w500),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
            SizedBox(
              height: h * 0.01,
            ),
            Container(
              height: h * 0.08,
              width: w * 0.95,
              decoration: BoxDecoration(
                  color: kWhite, borderRadius: BorderRadius.circular(15)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: w * 0.07),
                        child: Image.asset(
                          "assets/images/face.png",
                          width: h * 0.03,
                        ),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(left: w * 0.07),
                            child: textWidget(
                                msg: "Face Lock",
                                txtColor: kDarkBlue3,
                                txtFontSize: h * 0.016,
                                txtFontWeight: FontWeight.w600),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: w * 0.07),
                            child: textWidget(
                                msg: "Help to Protect Your Data",
                                txtColor: kDarkBlue3,
                                txtFontSize: h * 0.014,
                                txtFontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                    ],
                  ),

                  Padding(
                    padding: EdgeInsets.only(right: h * 0.01),
                    child: CupertinoSwitch(value: face, onChanged: (value) async {
                      face = !face;
                      await Model.prefs!.setBool('face', face);
                      setState(() {

                      });
                    },),
                  )
                ],
              ),
            ),
            SizedBox(
              height: h * 0.01,
            ),
            InkWell(
              onTap: () {
                lightImpact();
                Get.to(() => theme(),
                    transition: Transition.fade, duration: Duration(seconds: 1));
              },
              child: Container(
                height: h * 0.08,
                width: w * 0.95,
                decoration: BoxDecoration(
                    color: kWhite, borderRadius: BorderRadius.circular(15)),
                child: Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: w * 0.07),
                      child: Image.asset(
                        "assets/images/themes.png",
                        width: h * 0.03,
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: w * 0.07),
                          child: textWidget(
                              msg: "Theme",
                              txtColor: kDarkBlue3,
                              txtFontSize: h * 0.016,
                              txtFontWeight: FontWeight.w600),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: w * 0.07),
                          child: textWidget(
                              msg: "Choose Default Themes",
                              txtColor: kDarkBlue3,
                              txtFontSize: h * 0.014,
                              txtFontWeight: FontWeight.w500),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),

            SizedBox(
              height: h * 0.015,
            ),
            Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(left: h * 0.01, top: h * 0.01),
                  child: textWidget(
                      msg: "Backups",
                      txtColor: kDarkBlue3,
                      txtFontSize: h * 0.018,
                      txtFontWeight: FontWeight.w600),
                ),
              ],
            ),

            Row(
              children: [
                Container(
                  height: 2,
                  width: w * 0.05,
                  margin: EdgeInsets.only(left: h * 0.01, top: h * 0.005),
                  color: kDarkBlue3,
                ),
              ],
            ),

            SizedBox(
              height: h * 0.015,
            ),

            //options


            Container(
              height: h * 0.08,
              width: w * 0.95,
              decoration: BoxDecoration(
                  color: kWhite, borderRadius: BorderRadius.circular(15)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: w * 0.07),
                        child: Image.asset(
                          "assets/images/backup.png",
                          width: h * 0.03,
                        ),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(left: w * 0.07),
                            child: textWidget(
                                msg: "Google Drive Backup",
                                txtColor: kDarkBlue3,
                                txtFontSize: h * 0.016,
                                txtFontWeight: FontWeight.w600),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: w * 0.07),
                            child: textWidget(
                                msg: "Last Backup",
                                txtColor: kDarkBlue3,
                                txtFontSize: h * 0.014,
                                txtFontWeight: FontWeight.w500),
                          ),
                        ],
                      )
                    ],
                  ),
                  InkWell(
                    onTap: () async {

                      Database? db;

                      Model().createDatabase().then((value) {
                        db = value;
                      });
                      
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
                                  textWidget(msg: "All Data Backup Process is Running", txtColor: kDarkBlue3, txtFontSize: h  * 0.018, txtFontWeight: FontWeight.w600)
                                ],
                              ),
                            ],
                          ),
                        ),
                      );

                      //get All Data
                      String api = 'https://flutteranadh.000webhostapp.com/DayToDay/getAllData.php?uid=${id}';

                      var response = await Dio().get(api);
                      print("response :- $response");

                      if(response.statusCode == 200){

                        print("RESPONSE === ${response.data}");
                        Map map = jsonDecode(response.data);

                        print("LIST === $map");

                        if(map.isEmpty){

                          Navigator.pop(context);
                          Get.snackbar("Success", "No Data Found Start as New ...",
                              backgroundColor: kGreen,
                              colorText: kWhite,
                              duration: Duration(seconds: 2));

                          Get.offAll(() => home(),transition: Transition.fade, duration: Duration(seconds: 1));

                        }
                        else{
                          if(map["expense"].isEmpty){
                            Get.snackbar("Success", "No Data Found You can Start as New ...",
                                backgroundColor: kGreen,
                                colorText: kWhite,
                                duration: Duration(seconds: 2));
                          }
                          else{
                            String qry =
                                "DELETE FROM expenses";
                            db!.rawDelete(qry).then((value) {
                              print(value);
                            });
                            for(int i = 0; i < map["expense"].length; i++){
                              String qry =
                                  "INSERT INTO expenses (title, amount, description, mode, img, name, dt) values ('${map["expense"][i]["title"]}', '${map["expense"][i]["amount"]}', '${map["expense"][i]["description"]}', '${map["expense"][i]["mode"]}', '${map["expense"][i]["img"]}', '${map["expense"][i]["name"]}', '${map["expense"][i]["dt"]}')";
                              db!.rawInsert(qry).then((value) {
                                print(value);
                              });
                            }

                            Get.snackbar("Success", "Expense Data are Backed up...",
                                backgroundColor: kGreen,
                                colorText: kWhite,
                                duration: Duration(seconds: 2));

                          }


                          if(map["notes"].isEmpty){
                            Get.snackbar("Success", "No Data Found You can Start as New ...",
                                backgroundColor: kGreen,
                                colorText: kWhite,
                                duration: Duration(seconds: 2));
                          }
                          else{
                            String qry =
                                "DELETE FROM notes";
                            db!.rawDelete(qry).then((value) {
                              print(value);
                            });
                            for(int i = 0; i < map["notes"].length; i++){
                              String qry =
                                  "INSERT INTO notes (content, dt) values ('${map["notes"][i]["content"]}', '${map["notes"][i]["dt"]}')";
                              db!.rawInsert(qry).then((value) {
                                print(value);
                              });
                            }

                            Get.snackbar("Success", "Notes Data are Backed up...",
                                backgroundColor: kGreen,
                                colorText: kWhite,
                                duration: Duration(seconds: 2));
                          }

                          Navigator.pop(context);

                          Get.offAll(() => home(),transition: Transition.fade, duration: Duration(seconds: 1));

                        }
                      }
                    },
                    child: Container(
                      height: h * 0.04,
                      width: w * 0.25,
                      margin: EdgeInsets.only(right: w * 0.04),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: kDarkBlue3,
                          borderRadius: BorderRadius.circular(10)),
                      child: textWidget(
                          msg: "Backup",
                          txtColor: kWhite,
                          txtFontSize: h * 0.016,
                          txtFontWeight: FontWeight.w600),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: h * 0.01,
            ),
            InkWell(
              onTap: () {
                lightImpact();

                Get.to(() => saveAsExcel(),
                    transition: Transition.fade, duration: Duration(seconds: 1));
              },
              child: Container(
                height: h * 0.08,
                width: w * 0.95,
                decoration: BoxDecoration(
                    color: kWhite, borderRadius: BorderRadius.circular(15)),
                child: Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: w * 0.07),
                      child: Image.asset(
                        "assets/images/sheets.png",
                        width: h * 0.03,
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: w * 0.07),
                          child: textWidget(
                              msg: "Save as Excel",
                              txtColor: kDarkBlue3,
                              txtFontSize: h * 0.016,
                              txtFontWeight: FontWeight.w600),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: w * 0.07),
                          child: textWidget(
                              msg: "Save the Data as Excel Sheet",
                              txtColor: kDarkBlue3,
                              txtFontSize: h * 0.014,
                              txtFontWeight: FontWeight.w500),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
            SizedBox(
              height: h * 0.01,
            ),
            InkWell(
              onTap: () {
                lightImpact();

                Get.to(() => cate(), transition: Transition.fade, duration: Duration(seconds: 1));
              },
              child: Container(
                height: h * 0.08,
                width: w * 0.95,
                decoration: BoxDecoration(
                    color: kWhite, borderRadius: BorderRadius.circular(15)),
                child: Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: w * 0.07),
                      child: Image.asset(
                        "assets/images/menu.png",
                        width: h * 0.03,
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: w * 0.07),
                          child: textWidget(
                              msg: "Custom & Default Categories",
                              txtColor: kDarkBlue3,
                              txtFontSize: h * 0.016,
                              txtFontWeight: FontWeight.w600),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: w * 0.07),
                          child: textWidget(
                              msg: "Add, Edit & Delete your own Categories",
                              txtColor: kDarkBlue3,
                              txtFontSize: h * 0.014,
                              txtFontWeight: FontWeight.w500),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),

            SizedBox(
              height: h * 0.01,
            ),
            InkWell(
              onTap: () {
                lightImpact();

                Model.prefs!.clear();
                Get.offAll(() => login(), transition: Transition.fade, duration: Duration(seconds: 1));

              },
              child: Container(
                height: h * 0.08,
                width: w * 0.95,
                decoration: BoxDecoration(
                    color: kWhite, borderRadius: BorderRadius.circular(15)),
                child: Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: w * 0.07),
                      child: Image.asset(
                        "assets/images/logout.png",
                        width: h * 0.03,
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: w * 0.07),
                          child: textWidget(
                              msg: "Log Out",
                              txtColor: kDarkBlue3,
                              txtFontSize: h * 0.016,
                              txtFontWeight: FontWeight.w600),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: w * 0.07),
                          child: textWidget(
                              msg: "Log Out your Account",
                              txtColor: kDarkBlue3,
                              txtFontSize: h * 0.014,
                              txtFontWeight: FontWeight.w500),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
