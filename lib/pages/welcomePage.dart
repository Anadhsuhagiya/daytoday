import 'package:daytoday/global/globals.dart';
import 'package:daytoday/global/haptic.dart';
import 'package:daytoday/pages/accounts/resgistration.dart';
import 'package:daytoday/pages/home.dart';
import 'package:daytoday/pages/login.dart';
import 'package:daytoday/widgets/text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:particles_flutter/particles_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../global/Model.dart';
import '../global/variables.dart';

class welcomePage extends StatefulWidget {
  const welcomePage({super.key});

  @override
  State<welcomePage> createState() => _welcomePageState();
}

class _welcomePageState extends State<welcomePage> {
  @override
  Widget build(BuildContext context) {

    final controller = Get.put(welcomController());

    return Scaffold(
      backgroundColor: kHomeBG,

      body: Stack(
        children: [
          CircularParticle(
            width: w,
            height: h,
            particleColor: Colors.white.withOpacity(.6),
            numberOfParticles: 300,
            speedOfParticles: 2,
            maxParticleSize: 9,
            awayRadius: 0,
            onTapAnimation: false,
            isRandSize: true,
            isRandomColor: false,
            connectDots: false,
            enableHover: false,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: h * 0.2,
                    width: h * 0.2,
                    decoration: BoxDecoration(
                      color: kDarkBlue3,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: kBlack,
                          spreadRadius: -10,
                          blurRadius: 10
                        )
                      ]
                    ),
                  ),
                ],
              ),
              SizedBox(height: h * 0.015,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  textWidget(msg: "Welcom To !", txtColor: kDarkBlue3, txtFontSize: h * 0.018, txtFontWeight: FontWeight.w500)
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  textWidget(msg: "Day To Day", txtColor: kDarkBlue3, txtFontSize: h * 0.03, txtFontWeight: FontWeight.w700)
                ],
              ),
              SizedBox(height: h * 0.02,),

              Container(
                height: h * 0.32,
                width: w * 0.95,
                decoration: BoxDecoration(
                  color: kDarkBlue3.withOpacity(0.8),
                  borderRadius: BorderRadius.circular(30)
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: w * 0.05,top: h * 0.02),
                          child: textWidget(msg: "Already a User ?", txtColor: kWhite, txtFontSize: h * 0.024, txtFontWeight: FontWeight.w700),
                        ),
                      ],
                    ),

                    Row(
                      children: [
                        Flexible(
                          child: Padding(
                            padding: EdgeInsets.only(left: w * 0.05,top: h * 0.01, right: w * 0.05),
                            child: textWidget(msg: "If you have already used this app before, and have backed up your data to your Google Drive, Click on find Backup to restore your Data and Continue working on it.",ovrflw: TextOverflow.fade, txaln: TextAlign.justify, txtColor: kWhite, txtFontSize: h * 0.016, txtFontWeight: FontWeight.w500),
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: h * 0.02,),

                    Row(
                      children: [
                        InkWell(
                          onTap: () {
                            lightImpact();
                            Get.to(
                                () => login(),
                              transition: Transition.fade,
                              duration: Duration(seconds: 1)
                            );
                          },
                          child: Container(
                            height: h * 0.05,
                            width: w * 0.3,
                            margin: EdgeInsets.only(left: w * 0.05),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: kHomeBG,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: textWidget(msg: "Find Backup", txtColor: kDarkBlue3, txtFontSize: h * 0.016, txtFontWeight: FontWeight.w600),
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: h * 0.02,),

                    Row(
                      children: [
                        InkWell(
                          onTap: () {
                            lightImpact();
                            Get.to(
                                () => registration(),
                              transition: Transition.fade,
                              duration: Duration(seconds: 1)
                            );
                          },
                          child: Container(
                            height: h * 0.05,
                            width: w * 0.3,
                            margin: EdgeInsets.only(left: w * 0.05),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: kHomeBG,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: textWidget(msg: "I'm New User", txtColor: kDarkBlue3, txtFontSize: h * 0.016, txtFontWeight: FontWeight.w600),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              )

            ],
          ),
        ],
      ),
    );
  }
}

class welcomController extends GetxController{



}
