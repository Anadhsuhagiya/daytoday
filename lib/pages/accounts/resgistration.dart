import 'dart:convert';
import 'dart:io';

import 'package:daytoday/global/globals.dart';
import 'package:daytoday/global/haptic.dart';
import 'package:daytoday/global/image_helper.dart';
import 'package:daytoday/pages/home.dart';
import 'package:daytoday/widgets/text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../../global/Model.dart';
import 'package:http/http.dart' as http;
import '../../global/variables.dart';

final imageHelper = ImageHelper();

class registration extends StatefulWidget {
  const registration({super.key});

  @override
  State<registration> createState() => _registrationState();
}

class _registrationState extends State<registration> {
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(registrationController());

    return Scaffold(
      backgroundColor: kHomeBG,
      appBar: AppBar(
        backgroundColor: kDarkBlue3,
        centerTitle: true,
        title: textWidget(msg: "Registration",
            txtColor: kWhite,
            txtFontSize: h * 0.018,
            txtFontWeight: FontWeight.w600),
      ),

      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          children: [

            SizedBox(height: h * 0.015,),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                  onTap: () async {
                    lightImpact();

                    final files = await imageHelper.pickImage();
                    if (files.isNotEmpty) {
                      final croppedFile = await imageHelper.crop(
                          file: files.first, cropStyle: CropStyle.circle);
                      if (croppedFile != null) {
                        controller._image = File(croppedFile.path);
                        setState(() {

                        });
                      }
                    }
                  },
                  child: Container(
                    height: h * 0.17,
                    width: h * 0.17,
                    padding: controller._image != null
                        ? EdgeInsets.all(h * 0)
                        : EdgeInsets.all(h * 0.03),
                    decoration: BoxDecoration(
                      color: kDarkBlue3,
                      borderRadius: BorderRadius.circular(30),
                      border: Border.all(color: kDarkBlue3, width: 3),

                    ),
                    child: controller._image != null
                        ? Container(
                      height: h * 0.17,
                      width: h * 0.17,
                      decoration: BoxDecoration(
                        image: DecorationImage(image: FileImage(
                            controller._image!), fit: BoxFit.cover),
                        borderRadius: BorderRadius.circular(30),
                      ),
                    )
                        : Image.asset(
                      "assets/images/image.png", fit: BoxFit.cover,
                      color: kWhite,),

                  ),
                ),
              ],
            ),

            SizedBox(height: h * 0.01,),

            Padding(
              padding: EdgeInsets.all(h * 0.015),
              child: TextField(
                controller: controller.name,
                keyboardType: TextInputType.name,
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
                    label: textWidget(msg: "Name",
                        txtColor: kDarkBlue3,
                        txtFontSize: h * 0.016,
                        txtFontWeight: FontWeight.w500),
                    hintText: "Enter Your Full Name",
                    hintStyle: TextStyle(color: kDarkBlue3.withOpacity(0.4),
                        fontSize: h * 0.016),
                    prefixIcon: Icon(
                      CupertinoIcons.person_3, color: kDarkBlue3,)
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(h * 0.015),
              child: TextField(
                controller: controller.profession,
                keyboardType: TextInputType.name,
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
                    label: textWidget(msg: "Profession",
                        txtColor: kDarkBlue3,
                        txtFontSize: h * 0.016,
                        txtFontWeight: FontWeight.w500),
                    hintText: "Enter Your Profession",
                    hintStyle: TextStyle(color: kDarkBlue3.withOpacity(0.4),
                        fontSize: h * 0.016),
                    prefixIcon: Icon(
                      CupertinoIcons.person_alt_circle, color: kDarkBlue3,)
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(h * 0.015),
              child: TextField(
                controller: controller.purpose,
                keyboardType: TextInputType.name,
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
                    label: textWidget(msg: "Purpose",
                        txtColor: kDarkBlue3,
                        txtFontSize: h * 0.016,
                        txtFontWeight: FontWeight.w500),
                    hintText: "Enter Your Purpose for making Profile",
                    hintStyle: TextStyle(color: kDarkBlue3.withOpacity(0.4),
                        fontSize: h * 0.016),
                    prefixIcon: Icon(
                      CupertinoIcons.arrow_3_trianglepath, color: kDarkBlue3,)
                ),
              ),
            ),
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
            Padding(
              padding: EdgeInsets.only(left: h * 0.015,
                  top: h * 0.005,
                  right: h * 0.015,
                  bottom: h * 0.015),
              child: TextField(
                controller: controller.additional,
                keyboardType: TextInputType.name,
                cursorColor: kDarkBlue3,
                onTapOutside: (event) => FocusScope.of(context).unfocus(),
                style: TextStyle(color: kDarkBlue3, fontSize: h * 0.016),
                maxLines: 3,
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
                  label: textWidget(msg: "Additional Information",
                      txtColor: kDarkBlue3,
                      txtFontSize: h * 0.016,
                      txtFontWeight: FontWeight.w500),
                  hintText: "Enter Your Additional Information",
                  hintStyle: TextStyle(
                      color: kDarkBlue3.withOpacity(0.4), fontSize: h * 0.016),
                ),
              ),
            ),

            SizedBox(height: h * 0.015,),
            InkWell(
              onTap: () {
                lightImpact();
                controller.onSubmit(context);
              },
              child: Obx(() => Container(
                height: h * 0.06,
                width: w * 0.95,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    color: kDarkBlue3,
                    borderRadius: BorderRadius.circular(20)
                ),
                child: controller._click.value == false
                    ? textWidget(msg: "Submit",
                    txtColor: kWhite,
                    txtFontSize: h * 0.018,
                    txtFontWeight: FontWeight.w600)
                : CupertinoActivityIndicator(color: kWhite,),
              ),)
            ),
            SizedBox(height: h * 0.025,)
          ],
        ),
      ),
    );
  }
}


class registrationController extends GetxController {

  final name = TextEditingController();
  final profession = TextEditingController();
  final purpose = TextEditingController();
  final contact = TextEditingController();
  final email = TextEditingController();
  final additional = TextEditingController();

  RxInt textLength = 0.obs;

  onChangedContact(String value) {
    textLength.value = value
        .toString()
        .length;
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

  File? _image;

  RxBool _click = false.obs;

  Future<void> onSubmit(BuildContext context) async {
    bool emailValid = RegExp(
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(email.text.trim());

    if (_image.isNull) {
      Get.snackbar("Error", "Please Select The Profile Photo...",
          backgroundColor: kError,
          colorText: kWhite,
          duration: Duration(seconds: 2));
    }
    else if (name.text
        .trim()
        .isEmpty) {
      Get.snackbar("Error", "Please Enter Your Name...",
          backgroundColor: kError,
          colorText: kWhite,
          duration: Duration(seconds: 2));
    }
    else if (profession.text
        .trim()
        .isEmpty) {
      Get.snackbar("Error", "Please Enter Your Profession...",
          backgroundColor: kError,
          colorText: kWhite,
          duration: Duration(seconds: 2));
    }
    else if (purpose.text
        .trim()
        .isEmpty) {
      Get.snackbar("Error", "Please Enter Your Purpose for making Account...",
          backgroundColor: kError,
          colorText: kWhite,
          duration: Duration(seconds: 2));
    }
    else if (contact.text
        .trim()
        .isEmpty) {
      Get.snackbar("Error", "Please Enter Your Contact...",
          backgroundColor: kError,
          colorText: kWhite,
          duration: Duration(seconds: 2));
    }
    else if (contact.text
        .trim()
        .length < 10) {
      Get.snackbar("Error", "Please Enter 10 Digit Contact...",
          backgroundColor: kError,
          colorText: kWhite,
          duration: Duration(seconds: 2));
    }
    else if (email.text
        .trim()
        .isEmpty) {
      Get.snackbar("Error", "Please Enter Your Email Address...",
          backgroundColor: kError,
          colorText: kWhite,
          duration: Duration(seconds: 2));
    }
    else if (!emailValid) {
      Get.snackbar("Error", "Please Enter Valid Email Address...",
          backgroundColor: kError,
          colorText: kWhite,
          duration: Duration(seconds: 2));
    }
    else if (additional.text
        .trim()
        .isEmpty) {
      Get.snackbar("Error", "Please Enter Additional Information...",
          backgroundColor: kError,
          colorText: kWhite,
          duration: Duration(seconds: 2));
    }
    else {

      _click.value = true;

      var link = Uri.parse(
          "https://flutteranadh.000webhostapp.com/DayToDay/register.php");
      DateTime dt = DateTime.now();
      String imageName = "${name.text.trim()}${dt.year}${dt.month}${dt.day}${dt
          .hour}${dt.minute}${dt.second}";

      var request = http.MultipartRequest(
          'POST', link);

      request.fields['name'] = "${name.text.trim()}";
      request.fields['profession'] = "${profession.text.trim()}";
      request.fields['purpose'] = "${purpose.text.trim()}";
      request.fields['contact'] = "${contact.text.trim()}";
      request.fields['email'] = "${email.text.trim()}";
      request.fields['additional'] = "${additional.text.trim()}";

      request.files.add(await http.MultipartFile.fromPath(
        "file",
        _image!.path,
      ));

      var res = await request.send();
      var result = await http.Response.fromStream(res);
      print(result.statusCode);


      _click.value = false;
      if (result.statusCode == 200 || result.statusCode == 201) {
        print(result.body);
        var map = jsonDecode(result.body);
        int result1 = map['result'];

        if (result1 == 1) {
          String qry =
              "INSERT INTO account (img, name, profession, purpose, contact, email, additional) values ('${_image!
              .path}', '${name.text.trim()}', '${profession.text
              .trim()}', '${purpose.text.trim()}', '${contact.text
              .trim()}', '${email.text.trim()}', '${additional.text.trim()}')";
          db!.rawInsert(qry).then((value) {
            print(value);
          });

          await Model.prefs!.setInt('signIN', 1);
          await Model.prefs!.setString('img', "${_image}");
          await Model.prefs!.setString('name', "${name.text.trim()}");
          await Model.prefs!.setString(
              'profession', "${profession.text.trim()}");
          await Model.prefs!.setString('purpose', "${purpose.text.trim()}");
          await Model.prefs!.setString('contact', "${contact.text.trim()}");
          await Model.prefs!.setString('email', "${email.text.trim()}");
          await Model.prefs!.setString(
              'additional', "${additional.text.trim()}");


          name.text = "";
          profession.text = "";
          purpose.text = "";
          contact.text = "";
          email.text = "";
          additional.text = "";

          Get.offAll(
                  () => home(),
              transition: Transition.fade,
              duration: Duration(seconds: 1)
          );

          Get.snackbar("Success", "Account Created Successfully ...!",
              backgroundColor: kGreen,
              colorText: kWhite,
              duration: Duration(seconds: 2));
        }
        else if(result1 == 3){
          Get.snackbar("Error", "Image Not Uploaded...!",
              backgroundColor: kError,
              colorText: kWhite,
              duration: Duration(seconds: 3));
        }

        else if(result1 == 4){
          Get.snackbar("Error", "Already have an Account...!",
              backgroundColor: kError,
              colorText: kWhite,
              duration: Duration(seconds: 3));
        }
      }

      else {
        Get.snackbar("Error", "Internal Error Please Try Again...!",
            backgroundColor: kError,
            colorText: kWhite,
            duration: Duration(seconds: 2));
      }
    }
  }


}

