import 'dart:convert';
import 'dart:ffi';

import 'package:daytoday/global/globals.dart';
import 'package:daytoday/global/haptic.dart';
import 'package:daytoday/pages/setting/cate.dart';
import 'package:daytoday/pages/settings.dart';
import 'package:daytoday/widgets/text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:http/http.dart' as http;
import '../../global/variables.dart';

class category extends StatefulWidget {
  const category({super.key});

  @override
  State<category> createState() => _categoryState();
}

class _categoryState extends State<category> {
  @override
  Widget build(BuildContext context) {

    final controller = Get.put(categoryController());

    return Scaffold(

      backgroundColor: kHomeBG,
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: Icon(
              CupertinoIcons.left_chevron,
              color: kWhite,
            )),
        backgroundColor: kDarkBlue3,
        centerTitle: true,
        title: textWidget(msg: "Category", txtColor: kWhite, txtFontSize: h * 0.018, txtFontWeight: FontWeight.w600),
      ),

      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              textWidget(msg: "Add Category", txtColor: kDarkBlue3, txtFontSize: h * 0.04, txtFontWeight: FontWeight.w800)
            ],
          ),

          Obx(() => Container(
            height: h * 0.1,
            width: h * 0.1,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: kDarkBlue3,
              shape: BoxShape.circle
            ),
            child: textWidget(msg: "${controller.letter.value.isEmpty ? "" : controller.letter.value.toString().substring(0,1)}", txtColor: kWhite, txtFontSize: h * 0.06, txtFontWeight: FontWeight.w700),
          )),

          SizedBox(height: h * 0.02,),
          Padding(
            padding: EdgeInsets.only(left: h * 0.015,
                top: h * 0.005,
                right: h * 0.015,
                bottom: h * 0.015),
            child: TextField(
              controller: controller.name,
              keyboardType: TextInputType.name,
              cursorColor: kDarkBlue3,
              onChanged: (value) {
                controller.letter.value = "${value.toString().substring(0,1)}";
              },
              onTapOutside: (event) => FocusScope.of(context).unfocus(),
              style: TextStyle(color: kDarkBlue3, fontSize: h * 0.014),
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
                  label: textWidget(msg: "Category Name",
                      txtColor: kDarkBlue3,
                      txtFontSize: h * 0.014,
                      txtFontWeight: FontWeight.w500),
                  hintText: "Enter Your Category Name",
                  hintStyle: TextStyle(color: kDarkBlue3.withOpacity(0.4),
                      fontSize: h * 0.014),
                  prefixIcon: Icon(Icons.menu, color: kDarkBlue3,)
              ),
            ),
          ),
          SizedBox(height: h * 0.03,),

          InkWell(
            onTap: () {
              lightImpact();
              controller.onSubmit();
            },
            child: Obx(() => Container(
              height: h * 0.06,
              width: w * 0.3,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: kDarkBlue3,
                  borderRadius: BorderRadius.circular(15)
              ),
              child: controller._click.value
                ? CupertinoActivityIndicator(color: kWhite,)
                : textWidget(msg: "Submit", txtColor: kWhite, txtFontSize: h * 0.016, txtFontWeight: FontWeight.w600),
            ),)
          )
        ],
      ),

    );
  }
}


class categoryController extends GetxController{

  RxString letter = "".obs;

  final name = TextEditingController();

  RxBool _click = false.obs;

  Future<void> onSubmit() async {

    if(name.text.trim().isEmpty){
      Get.snackbar("Error", "Please Enter Category ...",
          backgroundColor: kGreen,
          colorText: kWhite,
          duration: Duration(seconds: 2));
    }
    else{
      _click.value = true;
      String url = 'https://flutteranadh.000webhostapp.com/DayToDay/categoryInsert.php';

      Map<String, dynamic> data = {
        'img': "${name.text.trim().toString().substring(0,1)}",
        'name': "${name.text.trim()}",
      };

      final response = await http.post(
        Uri.parse(url),
        body: data,
      );

      _click.value = false;
// Check response status and handle data
      if (response.statusCode == 201 || response.statusCode == 200) {
        // Data inserted successfully!
        final res = jsonDecode(response.body);

        if(res["message"] == "Data inserted successfully!"){
          Get.snackbar("Success", "Category Added Successfully ...",
              backgroundColor: kGreen,
              colorText: kWhite,
              duration: Duration(seconds: 2));

          Get.offAll(() => cate(), transition: Transition.fade, duration: Duration(seconds: 1));
        }
        else{
          Get.snackbar("Error", "Category Not Added Please Try Again ...",
              backgroundColor: kGreen,
              colorText: kWhite,
              duration: Duration(seconds: 2));
        }
      } else {
        // Handle error
        print('Error inserting data: ${response.body}');
      }
    }

  }

}
