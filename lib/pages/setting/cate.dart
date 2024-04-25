import 'dart:convert';

import 'package:daytoday/global/globals.dart';
import 'package:daytoday/global/variables.dart';
import 'package:daytoday/pages/settings.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../widgets/text.dart';
import 'category.dart';

class cate extends StatefulWidget {
  const cate({super.key});

  @override
  State<cate> createState() => _cateState();
}

class _cateState extends State<cate> {
  @override
  Widget build(BuildContext context) {

    final controller = Get.put(cateController());

    return WillPopScope(
      onWillPop: () async {
        Get.offAll(
                () => settings(),
            transition: Transition.fade,
            duration: Duration(seconds: 1)
        );
        return true;
      },
      child: Scaffold(
        backgroundColor: kHomeBG,

        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                Get.offAll(
                        () => settings(),
                    transition: Transition.fade,
                    duration: Duration(seconds: 1)
                );
              },
              icon: Icon(
                CupertinoIcons.left_chevron,
                color: kWhite,
              )),
          backgroundColor: kDarkBlue3,
          centerTitle: true,
          title: textWidget(msg: "Category", txtColor: kWhite, txtFontSize: h * 0.018, txtFontWeight: FontWeight.w600),
        ),

        floatingActionButton: FloatingActionButton(onPressed: () {
          Get.to(() => category(), transition: Transition.fade, duration: Duration(seconds: 1));
        },
        backgroundColor: kDarkBlue3,
        child: Icon(CupertinoIcons.add, color: kWhite,),
        ),

        body: Obx(() => controller.status.value
        ? ListView.builder(
          itemCount: cat.length,
          itemBuilder: (context, index) {
            return Container(
              height: h * 0.1,
              width: w * 0.95,
              margin: EdgeInsets.only(left: h * 0.01, top: h * 0.015, right: h * 0.01),
              decoration: BoxDecoration(
                color: kWhite,
                borderRadius: BorderRadius.circular(20)
              ),
              child: Row(
                children: [
                  SizedBox(width: w * 0.05,),

                  cat[index]["img"].toString().length == 1
                  ? Container(
                    height: h * 0.08,
                    width: h * 0.08,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: kDarkBlue3,
                      borderRadius: BorderRadius.circular(10)
                    ),
                    child: textWidget(msg: "${cat[index]["img"]}", txtColor: kWhite, txtFontSize: h * 0.05, txtFontWeight: FontWeight.w700),
                  )
                      : Image.asset("${cat[index]["img"]}", width: h * 0.07,),

                  Padding(
                    padding: EdgeInsets.only(left: w * 0.05),
                    child: textWidget(msg: "${cat[index]["name"]}", txtColor: kDarkBlue3, txtFontSize: h * 0.018, txtFontWeight: FontWeight.w600),
                  )
                ],
              ),
            );
          },
        )
        : Center(child: CupertinoActivityIndicator(color: kWhite,),)),
      ),
    );
  }
}



class cateController extends GetxController{

  RxBool status = false.obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getCategory();
  }

  getCategory() async {
    cat.clear();

    status.value = false;
    //get All Data
    String api = 'https://flutteranadh.000webhostapp.com/DayToDay/categoryGet.php';

    var response = await Dio().get(api);
    print("response :- $response");

    if(response.statusCode == 200 || response.statusCode == 201){
      final data = jsonDecode(response.data);
      status.value = true;
      cat.addAll(data);
    }
  }

}