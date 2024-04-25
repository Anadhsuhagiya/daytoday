import 'package:daytoday/global/categoryList.dart';
import 'package:daytoday/global/globals.dart';
import 'package:daytoday/global/haptic.dart';
import 'package:daytoday/pages/searchPages/searchedPage.dart';
import 'package:daytoday/widgets/text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../global/variables.dart';

class search extends StatefulWidget {
  const search({super.key});

  @override
  State<search> createState() => _searchState();
}

class _searchState extends State<search> {
  @override
  Widget build(BuildContext context) {

    final controller = Get.put(searchController());

    return Scaffold(
      backgroundColor: kHomeBG,

      appBar: AppBar(
        backgroundColor: kDarkBlue3,
        leading: IconButton(onPressed: () {
          lightImpact();
          Get.back();
        }, icon: Icon(CupertinoIcons.back, color: kWhite,)),
        title: Padding(
          padding: EdgeInsets.all(h * 0.01),
          child: TextField(
            controller: controller.txtSearch,
            keyboardType: TextInputType.name,
            cursorColor: kWhite,
            onChanged: (value) => controller.onChangeSearch(value),
            style: TextStyle(color: kWhite, fontSize: h * 0.016),
            decoration: InputDecoration(
              enabledBorder: InputBorder.none,
              focusedBorder: InputBorder.none,
              border: InputBorder.none,
              hintText: "Search Category",
              hintStyle: TextStyle(fontSize: h * 0.016, color: kWhite.withOpacity(0.6))
            ),
          ),
        ),
        
        actions: [
          IconButton(onPressed: () {
            lightImpact();
            controller.txtSearch.text = "";
            controller.sr.value = false;
            controller.temp.clear();
            controller.temp.addAll(cat);
            controller.sr.value = true;
          }, icon: Icon(Icons.close, color: kWhite,))
        ],
      ),

      body: Obx(() => controller.sr.value
          ? controller.temp.isNotEmpty
          ? ListView.builder(
            itemCount: controller.temp.length,
            itemBuilder: (context, index) {

              RxString img = controller.temp[index]["img"].toString().obs;
              RxString name = controller.temp[index]["name"].toString().obs;

              return InkWell(
                onTap: () {
                  lightImpact();

                  Get.to(
                          () => searchedPage(name.value),
                      transition: Transition.fade,
                      duration: Duration(seconds: 1)
                  );
                },
                child: Container(
                  height: h * 0.07,
                  width: w * 0.95,
                  margin: EdgeInsets.only(left: h * 0.01, right: h * 0.01, top: h * 0.01),
                  decoration: BoxDecoration(
                      color: kWhite,
                      borderRadius: BorderRadius.circular(20)
                  ),
                  child: Row(
                    children: [
                      SizedBox(width: w * 0.05,),

                      img.value.toString().length == 1
                          ? Container(
                        height: h * 0.04,
                        width: h * 0.04,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            color: kDarkBlue3,
                            borderRadius: BorderRadius.circular(7)
                        ),
                        child: textWidget(msg: "${img.value}", txtColor: kWhite, txtFontSize: h * 0.03, txtFontWeight: FontWeight.w600),
                      )
                          : Image
                          .asset(
                        img.value,
                        width:
                        h * 0.035,
                      ),
                      SizedBox(width: w * 0.05,),
                      textWidget(msg: "${name.value}", txtColor: kDarkBlue3, txtFontSize: h * 0.018, txtFontWeight: FontWeight.w600)
                    ],
                  ),
                ),
              );
            },
          )
          : Center(child: textWidget(msg: "No Category", txtColor: kDarkBlue3, txtFontSize: h * 0.016, txtFontWeight: FontWeight.w600))
          : Center(child: textWidget(msg: "Type search Text ...", txtColor: kDarkBlue3, txtFontSize: h * 0.016, txtFontWeight: FontWeight.w600),)
      )
    );
  }
}


class searchController extends GetxController{

  final txtSearch = TextEditingController();
  RxBool sr = false.obs;
  RxList temp = [].obs;

  onChangeSearch(String value) {

    sr.value = true;
    temp.clear();

    if(value.isNotEmpty){

      for(int i = 0; i < cat.length; i++){
        if(cat[i]["name"].toString().toLowerCase().contains(value.toString().trim().toLowerCase())){
          temp.add(cat[i]);
        }
      }

    }
    else{
      sr.value = false;
      temp.clear();
      temp.addAll(cat);
    }


  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();

    sr.value = false;
    temp.addAll(cat);
    sr.value = true;
  }



}
