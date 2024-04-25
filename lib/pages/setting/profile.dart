import 'dart:ffi';
import 'dart:io';

import 'package:daytoday/global/globals.dart';
import 'package:daytoday/global/haptic.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:sqflite/sqflite.dart';

import '../../global/Model.dart';
import '../../global/variables.dart';
import '../../widgets/text.dart';
import '../accounts/resgistration.dart';

class profile extends StatefulWidget {
  const profile({super.key});

  @override
  State<profile> createState() => _profileState();
}

class _profileState extends State<profile> {
  @override
  Widget build(BuildContext context) {

    final controller = Get.put(profileController());

    return Scaffold(
      backgroundColor: kHomeBG,

      appBar: AppBar(
        backgroundColor: kDarkBlue3,
        leading: IconButton(onPressed: () {
          Get.back();
        }, icon: Icon(CupertinoIcons.left_chevron, color: kWhite,)),

        centerTitle: true,
        title: textWidget(msg: "Profile", txtColor: kWhite, txtFontSize: h * 0.02, txtFontWeight: FontWeight.w600),

      ),
      
      body: controller.status.value
      ? Column(
        children: [
          SizedBox(
            height: h * 0.015,
          ),

          Row(
            children: [
              Stack(
                children: [
                  Container(
                    height: h * 0.2,
                    width: h * 0.2,
                    margin: EdgeInsets.only(left: h * 0.015),
                    decoration: BoxDecoration(
                      color: kWhite,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: kGrey,
                          blurRadius: 10,
                          spreadRadius: -5
                        )
                      ],
                      border: Border.all(color: kDarkBlue3, width: 2),
                    ),
                    child: controller._image != null
                        ? Container(
                      height: h * 0.2,
                      width: h * 0.2,
                      decoration: BoxDecoration(
                        image: DecorationImage(image: FileImage(controller._image!),fit: BoxFit.cover),
                        shape: BoxShape.circle
                      ),
                    )
                        : Container(
                      height: h * 0.2,
                      width: h * 0.2,
                      padding: EdgeInsets.all(h * 0.07),
                      decoration: BoxDecoration(
                          
                          shape: BoxShape.circle
                      ),
                      child: Image.asset("assets/images/image.png", color: kDarkBlue3,),
                    )
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: InkWell(
                      onTap: () async {
                        lightImpact();
                        final files = await imageHelper.pickImage();
                        if(files.isNotEmpty){
                          final croppedFile = await imageHelper.crop(file: files.first, cropStyle: CropStyle.circle);
                          if(croppedFile != null) {
                            controller._image = File(croppedFile.path);
                            setState(() {

                            });
                            controller.updateData("img", controller._image!.path);
                          }
                        }
                      },
                      child: Container(
                        height: h * 0.05,
                        width: h * 0.05,
                        padding: EdgeInsets.all(h * 0.005),
                        decoration: BoxDecoration(
                          color: kDarkBlue3,
                          shape: BoxShape.circle,

                        ),
                        child: Image.asset("assets/images/plus.png", color: kWhite, fit: BoxFit.cover,),
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
          SizedBox(
            height: h * 0.015,
          ),
          
          Row(
            children: [
              Padding(
                padding: EdgeInsets.only(left: h * 0.03),
                child: Obx(() => textWidget(msg: "${controller.Name.value}", txtColor: kDarkBlue3, txtFontSize: h * 0.02, txtFontWeight: FontWeight.w700),
                )
              ),
              SizedBox(width: w * 0.05,),

              InkWell(
                onTap: () {
                  lightImpact();

                  Get.bottomSheet(
                    Container(
                      height: h * 0.4,
                      decoration: BoxDecoration(
                        color: kWhite,
                        borderRadius: BorderRadius.circular(50)
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(height: h * 0.04,),

                          Padding(
                            padding: EdgeInsets.all(h * 0.015),
                            child: TextField(
                              controller: controller.NAME,
                              keyboardType: TextInputType.name,
                              cursorColor: kDarkBlue3,
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
                                  label: textWidget(msg: "Name", txtColor: kDarkBlue3, txtFontSize: h * 0.014, txtFontWeight: FontWeight.w500),
                                  hintText: "Enter Your Name",
                                  hintStyle: TextStyle(color: kDarkBlue3.withOpacity(0.4), fontSize: h * 0.014),
                                  prefixIcon: Icon(CupertinoIcons.group_solid, color: kDarkBlue3,)
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(h * 0.015),
                            child: TextField(
                              controller: controller.PROFESSION,
                              keyboardType: TextInputType.name,
                              cursorColor: kDarkBlue3,
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
                                  label: textWidget(msg: "Profession", txtColor: kDarkBlue3, txtFontSize: h * 0.014, txtFontWeight: FontWeight.w500),
                                  hintText: "Enter Your Profession",
                                  hintStyle: TextStyle(color: kDarkBlue3.withOpacity(0.4), fontSize: h * 0.014),
                                  prefixIcon: Icon(CupertinoIcons.person_alt_circle, color: kDarkBlue3,)
                              ),
                            ),
                          ),
                          SizedBox(height: h * 0.02,),

                          InkWell(
                            onTap: () {
                              lightImpact();

                              if(controller.NAME.text.trim().isEmpty){
                                Get.snackbar("Error", "Please Enter Your Name...",
                                    backgroundColor: kError,
                                    colorText: kWhite,
                                    duration: Duration(seconds: 2));
                              }
                              else if(controller.PROFESSION.text.trim().isEmpty){
                                Get.snackbar("Error", "Please Enter Your Profession...",
                                    backgroundColor: kError,
                                    colorText: kWhite,
                                    duration: Duration(seconds: 2));
                              }
                              else{
                                controller.Name.value = controller.NAME.text.trim();
                                controller.Profession.value = controller.PROFESSION.text.trim();



                                Get.back();
                              }
                            },
                            child: Container(
                              height: h * 0.06,
                              width: w * 0.3,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: kDarkBlue3,
                                borderRadius: BorderRadius.circular(15)
                              ),
                              child: textWidget(msg: "Submit", txtColor: kWhite, txtFontSize: h * 0.018, txtFontWeight: FontWeight.w600),
                            ),
                          )
                        ],
                      ),
                    )
                  );
                },
                child: Container(
                  height: h * 0.04,
                  width: h * 0.04,
                  padding: EdgeInsets.all(h * 0.01),
                  decoration: BoxDecoration(
                    color: kDarkBlue3,
                    shape: BoxShape.circle
                    // borderRadius: BorderRadius.circular(10)
                  ),
                  child: Image.asset("assets/images/pencil.png", color: kWhite,),
                ),
              )
            ],
          ),

          Row(
            children: [
              Padding(
                padding: EdgeInsets.only(left: h * 0.08,),
                child: Obx(() => textWidget(msg: "${controller.Profession.value}", txtColor: kDarkBlue3, txtFontSize: h * 0.014, txtFontWeight: FontWeight.w500),
                )
              ),
              SizedBox(width: w * 0.05,),

            ],
          ),

          //other
          SizedBox(height: h * 0.015,),

          Container(
            height: h * 0.1,
            width: w * 0.95,
            decoration: BoxDecoration(
              color: kWhite,
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(
                  color: kBlack,
                  blurRadius: 10,
                  spreadRadius: -10
                )
              ]
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
              Row(
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: h * 0.02, top: h * 0.01),
                    child: textWidget(msg: "Profile Purpose", txtColor: kDarkBlue3, txtFontSize: h * 0.018, txtFontWeight: FontWeight.w600),
                    
                  ),
                ],
              ),

              Row(
                children: [
                  Container(
                    height: 2,
                    width: w * 0.05,
                    margin: EdgeInsets.only(left: h * 0.02, top: h * 0.005),
                    color: kDarkBlue3,
                  ),
                ],
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: h * 0.02),
                    child: Obx(() => textWidget(msg: "${controller.Purpose.value}", txtColor: kDarkBlue3, txtFontSize: h * 0.016, txtFontWeight: FontWeight.w500),
                    )
                  ),

                  InkWell(
                    onTap: () {
                      lightImpact();
                      Get.bottomSheet(
                          Container(
                            height: h * 0.3,
                            decoration: BoxDecoration(
                                color: kWhite,
                                borderRadius: BorderRadius.circular(50)
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(height: h * 0.04,),

                                Padding(
                                  padding: EdgeInsets.all(h * 0.015),
                                  child: TextField(
                                    controller: controller.PURPOSE,
                                    keyboardType: TextInputType.name,
                                    cursorColor: kDarkBlue3,
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
                                        label: textWidget(msg: "Purpose", txtColor: kDarkBlue3, txtFontSize: h * 0.014, txtFontWeight: FontWeight.w500),
                                        hintText: "Enter Your Purpose",
                                        hintStyle: TextStyle(color: kDarkBlue3.withOpacity(0.4), fontSize: h * 0.014),
                                        prefixIcon: Icon(CupertinoIcons.arrow_3_trianglepath, color: kDarkBlue3,)
                                    ),
                                  ),
                                ),
                                SizedBox(height: h * 0.02,),

                                InkWell(
                                  onTap: () {
                                    lightImpact();

                                    if(controller.PURPOSE.text.trim().isEmpty){
                                      Get.snackbar("Error", "Please Enter Your Purpose for Creating Profile...",
                                          backgroundColor: kError,
                                          colorText: kWhite,
                                          duration: Duration(seconds: 2));
                                    }
                                    else{
                                      controller.Purpose.value = controller.PURPOSE.text.trim();

                                      controller.updateData("purpose", controller.Purpose.value);

                                      Get.back();
                                    }
                                  },
                                  child: Container(
                                    height: h * 0.06,
                                    width: w * 0.3,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                        color: kDarkBlue3,
                                        borderRadius: BorderRadius.circular(15)
                                    ),
                                    child: textWidget(msg: "Submit", txtColor: kWhite, txtFontSize: h * 0.018, txtFontWeight: FontWeight.w600),
                                  ),
                                )
                              ],
                            ),
                          )
                      );
                    },
                    child: Container(
                      height: h * 0.04,
                      width: h * 0.04,
                      margin: EdgeInsets.only(right: h * 0.01),
                      padding: EdgeInsets.all(h * 0.01),
                      decoration: BoxDecoration(
                          color: kDarkBlue3,
                          shape: BoxShape.circle
                        // borderRadius: BorderRadius.circular(10)
                      ),
                      child: Image.asset("assets/images/pencil.png", color: kWhite,),
                    ),
                  )
                ],
              ),
            ],),
          ),
          
          //contact
          SizedBox(height: h * 0.015,),

          Container(
            height: h * 0.1,
            width: w * 0.95,
            decoration: BoxDecoration(
                color: kWhite,
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                      color: kBlack,
                      blurRadius: 10,
                      spreadRadius: -10
                  )
                ]
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: h * 0.02, top: h * 0.01),
                      child: textWidget(msg: "Contact", txtColor: kDarkBlue3, txtFontSize: h * 0.018, txtFontWeight: FontWeight.w600),
                    ),
                  ],
                ),

                Row(
                  children: [
                    Container(
                      height: 2,
                      width: w * 0.05,
                      margin: EdgeInsets.only(left: h * 0.02, top: h * 0.005),
                      color: kDarkBlue3,
                    ),
                  ],
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: h * 0.02),
                      child: Obx(() => textWidget(msg: "${controller.Contact.value}", txtColor: kDarkBlue3, txtFontSize: h * 0.016, txtFontWeight: FontWeight.w500),
                      )
                    ),

                    InkWell(
                      onTap: () {
                        lightImpact();
                        Get.bottomSheet(
                            Container(
                              height: h * 0.3,
                              decoration: BoxDecoration(
                                  color: kWhite,
                                  borderRadius: BorderRadius.circular(50)
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(height: h * 0.04,),

                                  Obx(() => Padding(
                                    padding: EdgeInsets.all(h * 0.015),
                                    child: TextField(
                                      controller: controller.CONTACT,
                                      keyboardType: TextInputType.number,
                                      cursorColor: kDarkBlue3,
                                      maxLength: 10,
                                      onChanged: (value) => controller.onChangedContact(value),
                                      onTapOutside: (event) => FocusScope.of(context).unfocus(),
                                      style: TextStyle(color: kDarkBlue3, fontSize: h * 0.014),
                                      decoration: InputDecoration(
                                          counter: Offstage(),
                                          suffix: Text("${controller.textLength.value} / 10",style: TextStyle(color: kDarkBlue3,
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
                                          prefix: textWidget(msg: "+91 ", txtColor: kDarkBlue3, txtFontSize: h * 0.014, txtFontWeight: FontWeight.w500),
                                          label: textWidget(msg: "Contact", txtColor: kDarkBlue3, txtFontSize: h * 0.014, txtFontWeight: FontWeight.w500),
                                          hintText: "Enter Your Contact",
                                          hintStyle: TextStyle(color: kDarkBlue3.withOpacity(0.4), fontSize: h * 0.014),
                                          prefixIcon: Icon(CupertinoIcons.phone, color: kDarkBlue3,)
                                      ),
                                    ),
                                  )),
                                  SizedBox(height: h * 0.02,),

                                  InkWell(
                                    onTap: () {
                                      lightImpact();

                                      if(controller.CONTACT.text.trim().isEmpty){
                                        Get.snackbar("Error", "Please Enter Your Contact...",
                                            backgroundColor: kError,
                                            colorText: kWhite,
                                            duration: Duration(seconds: 2));
                                      }
                                      else if(controller.CONTACT.text.trim().length < 10){
                                        Get.snackbar("Error", "Please Enter 10 Digit Contact Number...",
                                            backgroundColor: kError,
                                            colorText: kWhite,
                                            duration: Duration(seconds: 2));
                                      }
                                      else{
                                        controller.Contact.value = controller.CONTACT.text.trim();
                                        controller.updateData("contact", controller.Contact.value);
                                        Get.back();
                                      }
                                    },
                                    child: Container(
                                      height: h * 0.06,
                                      width: w * 0.3,
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                          color: kDarkBlue3,
                                          borderRadius: BorderRadius.circular(15)
                                      ),
                                      child: textWidget(msg: "Submit", txtColor: kWhite, txtFontSize: h * 0.018, txtFontWeight: FontWeight.w600),
                                    ),
                                  )
                                ],
                              ),
                            )
                        );
                      },
                      child: Container(
                        height: h * 0.04,
                        width: h * 0.04,
                        margin: EdgeInsets.only(right: h * 0.01),
                        padding: EdgeInsets.all(h * 0.01),
                        decoration: BoxDecoration(
                            color: kDarkBlue3,
                            shape: BoxShape.circle
                          // borderRadius: BorderRadius.circular(10)
                        ),
                        child: Image.asset("assets/images/pencil.png", color: kWhite,),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),

          //email
          SizedBox(height: h * 0.015,),

          Container(
            height: h * 0.1,
            width: w * 0.95,
            decoration: BoxDecoration(
                color: kWhite,
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                      color: kBlack,
                      blurRadius: 10,
                      spreadRadius: -10
                  )
                ]
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: h * 0.02, top: h * 0.01),
                      child: textWidget(msg: "Email", txtColor: kDarkBlue3, txtFontSize: h * 0.018, txtFontWeight: FontWeight.w600),
                    ),
                  ],
                ),

                Row(
                  children: [
                    Container(
                      height: 2,
                      width: w * 0.05,
                      margin: EdgeInsets.only(left: h * 0.02, top: h * 0.005),
                      color: kDarkBlue3,
                    ),
                  ],
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: h * 0.02),
                      child: Obx(() => textWidget(msg: "${controller.Email.value}", txtColor: kDarkBlue3, txtFontSize: h * 0.016, txtFontWeight: FontWeight.w500),
                      )
                    ),

                    InkWell(
                      onTap: () {
                        lightImpact();
                        Get.bottomSheet(
                            Container(
                              height: h * 0.3,
                              decoration: BoxDecoration(
                                  color: kWhite,
                                  borderRadius: BorderRadius.circular(50)
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(height: h * 0.04,),

                                  Padding(
                                    padding: EdgeInsets.only(left: h * 0.015, top: h * 0.005, right: h * 0.015, bottom: h * 0.015),
                                    child: TextField(
                                      controller: controller.EMAIL,
                                      keyboardType: TextInputType.emailAddress,
                                      cursorColor: kDarkBlue3,
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
                                          label: textWidget(msg: "Email", txtColor: kDarkBlue3, txtFontSize: h * 0.014, txtFontWeight: FontWeight.w500),
                                          hintText: "Enter Your Email Address",
                                          hintStyle: TextStyle(color: kDarkBlue3.withOpacity(0.4), fontSize: h * 0.014),
                                          prefixIcon: Icon(CupertinoIcons.mail, color: kDarkBlue3,)
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: h * 0.02,),

                                  InkWell(
                                    onTap: () {
                                      lightImpact();

                                      bool emailValid = RegExp(
                                          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                          .hasMatch(controller.EMAIL.text.trim());

                                      if(controller.EMAIL.text.trim().isEmpty){
                                        Get.snackbar("Error", "Please Enter Your Email Address...",
                                            backgroundColor: kError,
                                            colorText: kWhite,
                                            duration: Duration(seconds: 2));
                                      }
                                      else if(!emailValid){
                                        Get.snackbar("Error", "Please Enter Valid Email Address...",
                                            backgroundColor: kError,
                                            colorText: kWhite,
                                            duration: Duration(seconds: 2));
                                      }
                                      else{
                                        controller.Email.value = controller.EMAIL.text.trim();
                                        controller.updateData("email", controller.Email.value);
                                        Get.back();
                                      }
                                    },
                                    child: Container(
                                      height: h * 0.06,
                                      width: w * 0.3,
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                          color: kDarkBlue3,
                                          borderRadius: BorderRadius.circular(15)
                                      ),
                                      child: textWidget(msg: "Submit", txtColor: kWhite, txtFontSize: h * 0.018, txtFontWeight: FontWeight.w600),
                                    ),
                                  )
                                ],
                              ),
                            )
                        );
                      },
                      child: Container(
                        height: h * 0.04,
                        width: h * 0.04,
                        margin: EdgeInsets.only(right: h * 0.01),
                        padding: EdgeInsets.all(h * 0.01),
                        decoration: BoxDecoration(
                            color: kDarkBlue3,
                            shape: BoxShape.circle
                          // borderRadius: BorderRadius.circular(10)
                        ),
                        child: Image.asset("assets/images/pencil.png", color: kWhite,),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),

          //info
          SizedBox(height: h * 0.015,),

          Container(
            height: h * 0.1,
            width: w * 0.95,
            decoration: BoxDecoration(
                color: kWhite,
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                      color: kBlack,
                      blurRadius: 10,
                      spreadRadius: -10
                  )
                ]
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: h * 0.02, top: h * 0.01),
                      child: textWidget(msg: "Additional Information", txtColor: kDarkBlue3, txtFontSize: h * 0.018, txtFontWeight: FontWeight.w600),
                    ),
                  ],
                ),

                Row(
                  children: [
                    Container(
                      height: 2,
                      width: w * 0.05,
                      margin: EdgeInsets.only(left: h * 0.02, top: h * 0.005),
                      color: kDarkBlue3,
                    ),
                  ],
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: Padding(
                        padding: EdgeInsets.only(left: h * 0.02),
                        child: Obx(() => textWidget(msg: "${controller.Additional.value}", txaln: TextAlign.start, ovrflw: TextOverflow.ellipsis, txtColor: kDarkBlue3, txtFontSize: h * 0.016, txtFontWeight: FontWeight.w500),
                        )
                      ),
                    ),

                    InkWell(
                      onTap: () {
                        lightImpact();
                        Get.bottomSheet(
                            Container(
                              height: h * 0.3,
                              decoration: BoxDecoration(
                                  color: kWhite,
                                  borderRadius: BorderRadius.circular(50)
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(height: h * 0.04,),

                                  Padding(
                                    padding: EdgeInsets.only(left: h * 0.015, top: h * 0.005, right: h * 0.015, bottom: h * 0.015),
                                    child: TextField(
                                      controller: controller.ADDITIONAL,
                                      keyboardType: TextInputType.name,
                                      cursorColor: kDarkBlue3,
                                      onTapOutside: (event) => FocusScope.of(context).unfocus(),
                                      style: TextStyle(color: kDarkBlue3, fontSize: h * 0.014),
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
                                        label: textWidget(msg: "Additional Information", txtColor: kDarkBlue3, txtFontSize: h * 0.014, txtFontWeight: FontWeight.w500),
                                        hintText: "Enter Your Additional Information",
                                        hintStyle: TextStyle(color: kDarkBlue3.withOpacity(0.4), fontSize: h * 0.014),
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: h * 0.02,),

                                  InkWell(
                                    onTap: () {
                                      lightImpact();

                                      if(controller.ADDITIONAL.text.trim().isEmpty){
                                        Get.snackbar("Error", "Please Enter Your Additional Information...",
                                            backgroundColor: kError,
                                            colorText: kWhite,
                                            duration: Duration(seconds: 2));
                                      }
                                      else{
                                        controller.Additional.value = controller.ADDITIONAL.text.trim();
                                        controller.updateData("additional", controller.Additional.value);
                                        Get.back();
                                      }
                                    },
                                    child: Container(
                                      height: h * 0.06,
                                      width: w * 0.3,
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                          color: kDarkBlue3,
                                          borderRadius: BorderRadius.circular(15)
                                      ),
                                      child: textWidget(msg: "Submit", txtColor: kWhite, txtFontSize: h * 0.018, txtFontWeight: FontWeight.w600),
                                    ),
                                  )
                                ],
                              ),
                            )
                        );
                      },
                      child: Container(
                        height: h * 0.04,
                        width: h * 0.04,
                        margin: EdgeInsets.only(right: h * 0.01, left: h * 0.015),
                        padding: EdgeInsets.all(h * 0.01),
                        decoration: BoxDecoration(
                            color: kDarkBlue3,
                            shape: BoxShape.circle
                          // borderRadius: BorderRadius.circular(10)
                        ),
                        child: Image.asset("assets/images/pencil.png", color: kWhite,),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),

        ],
      )
      : Center(child: CircularProgressIndicator(color: kDarkBlue3,strokeWidth: 3,),),
    );
  }
}


class profileController extends GetxController{

  File? _image;

  RxString Name = "".obs;
  RxString Profession = "".obs;
  RxString Purpose = "".obs;
  RxString Contact = "".obs;
  RxString Email = "".obs;
  RxString Additional = "".obs;

  Database? db;

  RxBool status = false.obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();

    print("IMAGE === ${img}");
    // _image = File('${img.substring(16, img.length-1)}');
    Name.value = name;
    Profession.value = profession;
    Purpose.value = purpose;
    Contact.value = contact;
    Email.value = email;
    Additional.value = additional;

    status.value = true;

    Model().createDatabase().then((value) {
      db = value;
    });

  }

  final NAME = TextEditingController();
  final PROFESSION = TextEditingController();
  final PURPOSE = TextEditingController();
  final CONTACT = TextEditingController();
  final EMAIL = TextEditingController();
  final ADDITIONAL = TextEditingController();

  RxInt textLength = 0.obs;

  onChangedContact(String value) {
    textLength.value = value.length;
  }

  updateData(String field, String Data) async {

    String qry =
        "UPDATE account set $field = '$Data' where id = $id}";
    db!.rawUpdate(qry).then((value) {
      print(value);
    });

    await Model.prefs!.setString('$field', "${Data}");

    Get.snackbar("Success", "$field data is Updated ...!",
        backgroundColor: kGreen,
        colorText: kWhite,
        duration: Duration(seconds: 2));

  }


}
