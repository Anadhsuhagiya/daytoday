import 'package:daytoday/widgets/text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';


import '../global/globals.dart';
import '../global/variables.dart';


class drawerWidget extends StatefulWidget {

  @override
  State<drawerWidget> createState() => _drawerWidgetState();
}

class _drawerWidgetState extends State<drawerWidget> {


  @override
  Widget build(BuildContext context) {


    return AlertDialog(
      backgroundColor: kWhite.withOpacity(0.6),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
      content: Container(
        height: h * 0.6,
        width: w,
        margin: EdgeInsets.all(h * 0.005),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              height: h * 0.1,
              width: h * 0.1,
              padding: EdgeInsets.all(h * 0.02),
              decoration: BoxDecoration(
                color: kDarkBlue3,
                shape: BoxShape.circle,
              ),
              child: Image.asset("images/user.png",),
            ),
            SizedBox(height: h * 0.02,),

            //menu
            GestureDetector(
              // highlightColor: Colors.transparent,
              // splashColor: Colors.transparent,
              onTap: () {
                Navigator.pop(context);
                // Get.offAll(
                //         () => Dashboard(),
                //     transition: Transition.fade,
                //     duration: Duration(seconds: 1)
                // );
              },
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: h * 0.01),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    textWidget(msg: "Dashboard", txtColor: kDarkBlue3, txtFontSize: h * 0.016, txtFontWeight: FontWeight.w600),
                    Image.asset("images/rightArrow.png",height: h * 0.018,width: h * 0.018,)
                  ],
                ),
              ),
            ),
            InkWell(
              highlightColor: Colors.transparent,
              splashColor: Colors.transparent,
              onTap: () {
                Navigator.pop(context);
                // Get.to(
                //     () => medicine(),
                //   transition: Transition.fade,
                //   duration: Duration(seconds: 1)
                // );
              },
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: h * 0.01),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    textWidget(msg: "Medicine", txtColor: kDarkBlue3, txtFontSize: h * 0.016, txtFontWeight: FontWeight.w600),
                    Image.asset("images/rightArrow.png",height: h * 0.018,width: h * 0.018,)
                  ],
                ),
              ),
            ),
            InkWell(
              highlightColor: Colors.transparent,
              splashColor: Colors.transparent,
              onTap: () {
                Navigator.pop(context);
                // Get.to(
                //         () => departmentsOfDoctors(),
                //     transition: Transition.fade,
                //     duration: Duration(seconds: 1)
                // );
              },
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: h * 0.01),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    textWidget(msg: "Doctors", txtColor: kDarkBlue3, txtFontSize: h * 0.016, txtFontWeight: FontWeight.w600),
                    Image.asset("images/rightArrow.png",height: h * 0.018,width: h * 0.018,)
                  ],
                ),
              ),
            ),
            InkWell(
              highlightColor: Colors.transparent,
              splashColor: Colors.transparent,
              onTap: () {
                Navigator.pop(context);
                // Get.to(
                //         () => appointment(),
                //     transition: Transition.fade,
                //     duration: Duration(seconds: 1)
                // );
              },
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: h * 0.01),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    textWidget(msg: "Appointment", txtColor: kDarkBlue3, txtFontSize: h * 0.016, txtFontWeight: FontWeight.w600),
                    Image.asset("images/rightArrow.png",height: h * 0.018,width: h * 0.018,)
                  ],
                ),
              ),
            ),
            InkWell(
              highlightColor: Colors.transparent,
              splashColor: Colors.transparent,
              onTap: () {
                Navigator.pop(context);
                // Get.to(
                //         () => settings(),
                //     transition: Transition.fade,
                //     duration: Duration(seconds: 1)
                // );
              },
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: h * 0.01),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    textWidget(msg: "Settings", txtColor: kDarkBlue3, txtFontSize: h * 0.016, txtFontWeight: FontWeight.w600),
                    Image.asset("images/rightArrow.png",height: h * 0.018,width: h * 0.018,)
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
