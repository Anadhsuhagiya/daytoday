import 'package:daytoday/global/globals.dart';
import 'package:daytoday/global/variables.dart';
import 'package:daytoday/pages/faceLock.dart';
import 'package:daytoday/pages/home.dart';
import 'package:daytoday/pages/welcomePage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'global/Model.dart';

class splash extends StatefulWidget {
  const splash({super.key});

  @override
  State<splash> createState() => _splashState();
}

class _splashState extends State<splash> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    go();
  }

  go() async {
    Model.prefs = await SharedPreferences.getInstance();
    await Future.delayed(Duration(milliseconds: 500));
    int status = Model.prefs!.getInt('signIN') ?? 0;
    face = Model.prefs!.getBool('face') ?? false;
    int col = Model.prefs!.getInt('theme') ?? 0;

    print("Face === $face");

    kDarkBlue3 = col == 0 ? Color(0xff220045) : col == 1 ? Color(0xff000645) : col == 2 ? Color(0xff590000) : col == 3 ? Color(0xff075200) : Color(0xff00695b);
    kHomeBG = col == 0 ? Color(0xffd4c4ed) : col == 1 ? Color(0xffd7daf1) : col == 2 ? Color(
        0xfff8dfdf) : col == 3 ? Color(0xffdff5dd) : Color(0xffd9f3f0);

    if(status == 1){

      if(face == true){
        Get.offAll(
                () => FaceLock(),
            transition: Transition.fade,
            duration: Duration(seconds: 1)
        );
      }
      else{
        Get.offAll(
                () => home(),
            transition: Transition.fade,
            duration: Duration(seconds: 1)
        );
      }

    }
    else{
      Get.offAll(
              () => welcomePage(),
          transition: Transition.fade,
          duration: Duration(seconds: 1)
      );
    }
  }

  @override
  Widget build(BuildContext context) {


    return Scaffold(

    );
  }
}

