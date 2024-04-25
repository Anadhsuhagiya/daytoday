import 'package:daytoday/global/globals.dart';
import 'package:daytoday/global/haptic.dart';
import 'package:daytoday/pages/settings.dart';
import 'package:daytoday/splash.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../global/Model.dart';
import '../../global/variables.dart';
import '../../widgets/text.dart';

class theme extends StatefulWidget {
  const theme({super.key});

  @override
  State<theme> createState() => _themeState();
}

class _themeState extends State<theme> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kHomeBG,

      appBar: AppBar(
        backgroundColor: kDarkBlue3,
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
        centerTitle: true,
        title: textWidget(
            msg: "Settings",
            txtColor: kWhite,
            txtFontSize: h * 0.02,
            txtFontWeight: FontWeight.w600),
      ),

      body: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [

              SizedBox(height: h * 0.015,),
              InkWell(
                onTap: () async {
                  lightImpact();
                  await Model.prefs!.setInt('theme', 0);
                  Get.offAll(
                      () => splash(),
                    transition: Transition.fade
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
                      Container(
                        height: h * 0.07,
                        width: h * 0.07,
                        decoration: BoxDecoration(
                            color: Color(0xff220045),
                            borderRadius: BorderRadius.circular(10)
                        ),
                      ),
                      SizedBox(width: w * 0.05,),
                      textWidget(msg: "Purple", txtColor: kDarkBlue3, txtFontSize: h * 0.018, txtFontWeight: FontWeight.w600)
                    ],
                  ),
                ),
              ),
              SizedBox(height: h * 0.015,),
              InkWell(
                onTap: () async {
                  lightImpact();
                  await Model.prefs!.setInt('theme', 1);
                  Get.offAll(
                          () => splash(),
                      transition: Transition.fade
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
                      Container(
                        height: h * 0.07,
                        width: h * 0.07,
                        decoration: BoxDecoration(
                          color: Color(0xff000645),
                          borderRadius: BorderRadius.circular(10)
                        ),
                      ),
                      SizedBox(width: w * 0.05,),
                      textWidget(msg: "Night Sky", txtColor: kDarkBlue3, txtFontSize: h * 0.018, txtFontWeight: FontWeight.w600)
                    ],
                  ),
                ),
              ),
              SizedBox(height: h * 0.015,),
              InkWell(
                onTap: () async {
                  lightImpact();
                  await Model.prefs!.setInt('theme', 2);
                  Get.offAll(
                          () => splash(),
                      transition: Transition.fade
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
                      Container(
                        height: h * 0.07,
                        width: h * 0.07,
                        decoration: BoxDecoration(
                            color: Color(0xff590000),
                            borderRadius: BorderRadius.circular(10)
                        ),
                      ),
                      SizedBox(width: w * 0.05,),
                      textWidget(msg: "Royal Maroon", txtColor: kDarkBlue3, txtFontSize: h * 0.018, txtFontWeight: FontWeight.w600)
                    ],
                  ),
                ),
              ),
              SizedBox(height: h * 0.015,),
              InkWell(
                onTap: () async {
                  lightImpact();
                  await Model.prefs!.setInt('theme', 3);
                  Get.offAll(
                          () => splash(),
                      transition: Transition.fade
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
                      Container(
                        height: h * 0.07,
                        width: h * 0.07,
                        decoration: BoxDecoration(
                            color: Color(0xff075200),
                            borderRadius: BorderRadius.circular(10)
                        ),
                      ),
                      SizedBox(width: w * 0.05,),
                      textWidget(msg: "Nature", txtColor: kDarkBlue3, txtFontSize: h * 0.018, txtFontWeight: FontWeight.w600)
                    ],
                  ),
                ),
              ),
              SizedBox(height: h * 0.015,),
              InkWell(
                onTap: () async {
                  lightImpact();
                  await Model.prefs!.setInt('theme', 4);
                  Get.offAll(
                          () => splash(),
                      transition: Transition.fade
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
                      Container(
                        height: h * 0.07,
                        width: h * 0.07,
                        decoration: BoxDecoration(
                            color: Color(0xff00695b),
                            borderRadius: BorderRadius.circular(10)
                        ),
                      ),
                      SizedBox(width: w * 0.05,),
                      textWidget(msg: "Sea", txtColor: kDarkBlue3, txtFontSize: h * 0.018, txtFontWeight: FontWeight.w600)
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
