import 'dart:convert';

import 'package:daytoday/global/globals.dart';
import 'package:daytoday/global/haptic.dart';
import 'package:daytoday/pages/home.dart';
import 'package:daytoday/pages/welcomePage.dart';
import 'package:daytoday/widgets/frostedGlass.dart';
import 'package:daytoday/widgets/text.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../global/Model.dart';
import '../global/variables.dart';

class login extends StatefulWidget {
  const login({super.key});

  @override
  State<login> createState() => _loginState();
}

class _loginState extends State<login> {
  @override
  Widget build(BuildContext context) {

    final controller = Get.put(loginController());

    return Scaffold(
      backgroundColor: kHomeBG,

      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              textWidget(msg: "Login", txtColor: kDarkBlue3, txtFontSize: h * 0.05, txtFontWeight: FontWeight.w800)
            ],
          ),
          SizedBox(height: h * 0.02,),

          Obx(() =>
              Padding(
                padding: EdgeInsets.all(h * 0.015),
                child: TextField(
                  controller: controller.contact,
                  keyboardType: TextInputType.number,
                  cursorColor: kDarkBlue3,
                  maxLength: 10,
                  onChanged: (value) => controller.onChangedContact(value),
                  onTapOutside: (event) => FocusScope.of(context).unfocus(),
                  style: TextStyle(color: kDarkBlue3, fontSize: h * 0.016),
                  decoration: InputDecoration(
                      counter: Offstage(),
                      suffix: Text("${controller.textLength.value} / 10",
                        style: TextStyle(color: kDarkBlue3,
                          fontSize: h * 0.016,
                          fontWeight: FontWeight.w500,),),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide(color: kDarkBlue3, width: 2)
                      ),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide(color: kDarkBlue3, width: 2)
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide(color: kDarkBlue3, width: 2)
                      ),
                      prefix: textWidget(msg: "+91 ",
                          txtColor: kDarkBlue3,
                          txtFontSize: h * 0.016,
                          txtFontWeight: FontWeight.w500),
                      label: textWidget(msg: "Contact",
                          txtColor: kDarkBlue3,
                          txtFontSize: h * 0.016,
                          txtFontWeight: FontWeight.w500),
                      hintText: "Enter Your Contact",
                      hintStyle: TextStyle(color: kDarkBlue3.withOpacity(0.4),
                          fontSize: h * 0.016),
                      prefixIcon: Icon(
                        CupertinoIcons.phone, color: kDarkBlue3,)
                  ),
                ),
              )),
          Padding(
            padding: EdgeInsets.only(left: h * 0.015,
                top: h * 0.005,
                right: h * 0.015,
                bottom: h * 0.015),
            child: TextField(
              controller: controller.email,
              keyboardType: TextInputType.emailAddress,
              cursorColor: kDarkBlue3,
              onTapOutside: (event) => FocusScope.of(context).unfocus(),
              style: TextStyle(color: kDarkBlue3, fontSize: h * 0.016),
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide(color: kDarkBlue3, width: 2)
                  ),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide(color: kDarkBlue3, width: 2)
                  ),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide(color: kDarkBlue3, width: 2)
                  ),
                  label: textWidget(msg: "Email",
                      txtColor: kDarkBlue3,
                      txtFontSize: h * 0.016,
                      txtFontWeight: FontWeight.w500),
                  hintText: "Enter Your Email Address",
                  hintStyle: TextStyle(color: kDarkBlue3.withOpacity(0.4),
                      fontSize: h * 0.016),
                  prefixIcon: Icon(CupertinoIcons.mail, color: kDarkBlue3,)
              ),
            ),
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(width: w * 0.05,),
              InkWell(
                onTap: () {
                  lightImpact();
                  Get.to(()=> welcomePage(), transition: Transition.fade, duration: Duration(seconds: 1));
                },
                child: textWidget(msg: "You haven't account ?", txtColor: kError, txtFontSize: h * 0.016, txtFontWeight: FontWeight.w600),
              ),
            ],
          ),

          SizedBox(height: h * 0.025,),

          InkWell(
            onTap: () {
              lightImpact();
              controller.onSubmitLogin(context);
            },
            child: Obx(() => Container(
              height: h * 0.06,
              width: w * 0.3,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: kDarkBlue3,
                  borderRadius: BorderRadius.circular(15)
              ),
              child: controller._click.value == false
              ? textWidget(msg: "Login", txtColor: kWhite, txtFontSize: h * 0.018, txtFontWeight: FontWeight.w600)
              : CupertinoActivityIndicator(color: kWhite,),
            )),
          )
        ],
      ),
    );
  }
}


class loginController extends GetxController{

  final contact = TextEditingController();
  final email = TextEditingController();

  RxBool _click = false.obs;

  RxInt textLength = 0.obs;

  onChangedContact(String value) {
    textLength.value = value.toString().length;
  }

  Future<void> onSubmitLogin(BuildContext context) async {


    if(contact.text.trim().isEmpty){
      Get.snackbar("Error", "Please Enter Contact Number...",
          backgroundColor: kError,
          colorText: kWhite,
          duration: Duration(seconds: 2));
    }
    else if(contact.text.trim().toString().length < 10){
      Get.snackbar("Error", "Please Enter 10 Digit Contact Number...",
          backgroundColor: kError,
          colorText: kWhite,
          duration: Duration(seconds: 2));
    }
    else if(email.text.trim().isEmpty){
      Get.snackbar("Error", "Please Enter Email Address...",
          backgroundColor: kError,
          colorText: kWhite,
          duration: Duration(seconds: 2));
    }
    else {
      _click.value = true;
      String api = 'https://flutteranadh.000webhostapp.com/DayToDay/login.php?email=${email.text.trim()}&contact=${contact.text.trim()}';

      var response = await Dio().get(api);
      print("response :- $response");

      _click.value = false;
      if(response.statusCode == 200) {
        Map map = jsonDecode(response.data);

        int result = map['result'];
        print("result :- $result");

        if(result == 1){
          print("Sucess");

          Map data = map['data'];

          await Model.prefs!.setInt('signIN', 1);
          await Model.prefs!.setString('uid', "${data["id"]}");
          await Model.prefs!.setString('img', "${data["img"]}");
          await Model.prefs!.setString('name', "${data["name"]}");
          await Model.prefs!.setString(
              'profession', "${data["profession"]}");
          await Model.prefs!.setString('purpose', "${data["purpose"]}");
          await Model.prefs!.setString('contact', "${data["contact"]}");
          await Model.prefs!.setString('email', "${data["email"]}");
          await Model.prefs!.setString(
              'additional', "${data["additional"]}");

          Get.snackbar("Success", "Login Successfully ...",
              backgroundColor: kGreen,
              colorText: kWhite,
              duration: Duration(seconds: 2));


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
          String api = 'https://flutteranadh.000webhostapp.com/DayToDay/getAllData.php?uid=${data["id"]}';

          var response = await Dio().get(api);
          print("response :- $response");

          if(response.statusCode == 200){

            print("RESPONSE === ${response.data}");
            Map map = jsonDecode(response.data);

            print("LIST === $map");

            if(map.isNull){

              Navigator.pop(context);
              Get.snackbar("Success", "No Data Found Start as New ...",
                  backgroundColor: kGreen,
                  colorText: kWhite,
                  duration: Duration(seconds: 2));

              Get.offAll(() => home(),transition: Transition.fade, duration: Duration(seconds: 1));

            }
            else{
              if(map["expense"] == []){
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


              if(map["notes"] == []){
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
              await Model.prefs!.setInt('signIN', 1);
              Navigator.pop(context);

              Get.offAll(() => home(),transition: Transition.fade, duration: Duration(seconds: 1));

            }
          }



        }
        else{
          Get.snackbar("Error", "Credential Invalid Please Try Again...",
              backgroundColor: kError,
              colorText: kWhite,
              duration: Duration(seconds: 2));
        }
      }
    }

  }



  Database? db;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();

    Model().createDatabase().then((value) {
      db = value;
    });

  }

}