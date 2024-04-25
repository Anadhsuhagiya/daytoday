import 'package:daytoday/pages/accounts/resgistration.dart';
import 'package:daytoday/pages/home.dart';
import 'package:daytoday/pages/welcomePage.dart';
import 'package:daytoday/splash.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'global/Model.dart';
import 'global/variables.dart';

void main(){
  runApp(MaterialApp(debugShowCheckedModeBanner: false,home: MyApp(),));
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});



  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    h = MediaQuery.of(context).size.height;
    w = MediaQuery.of(context).size.width;

    return GetMaterialApp(
        getPages: [],
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          fontFamily: 'montserrat',
        ),
        title: 'Flutter Demo',
      home: splash(),
    );
  }
}

