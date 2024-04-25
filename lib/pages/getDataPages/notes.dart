import 'package:daytoday/global/globals.dart';
import 'package:daytoday/global/haptic.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../../global/Model.dart';
import '../../global/variables.dart';
import '../../widgets/text.dart';

class notes extends StatefulWidget {
  const notes({super.key});

  @override
  State<notes> createState() => _notesState();
}

class _notesState extends State<notes> {
  @override
  Widget build(BuildContext context) {

    final controller = Get.put(noteController());

    return Scaffold(

      backgroundColor: kHomeBG,

      floatingActionButton: FloatingActionButton(onPressed: () {
        controller.addNote.value = !controller.addNote.value;
        if(controller.addNote.value == false){

          controller.onSubmit(context);

          String getMonthName(int month) {
            final format = DateFormat('MMMM'); // MMMM for full month names
            return format.format(DateTime(2024, month, 1)); // Set day to 1 for any month
          }
          controller.month.value = "${getMonthName(DateTime.now().month)}, ${DateTime.now().year}";
        }
        else{

          controller.dataListNote(controller.SelectedDate.value);
        }
      },
        backgroundColor: kDarkBlue3,
      child: Obx(() => Icon(controller.addNote.value ? CupertinoIcons.checkmark_alt : CupertinoIcons.pen, color: kWhite,),)
      ),


      body: Obx(() => controller.addNote.value
          ? Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: h * 0.01,),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: h * 0.05,
                width: w * 0.95,
                decoration: BoxDecoration(
                  color: kDarkBlue3,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: () {

                        DateTime? _chosenDateTime;
                        Get.bottomSheet(
                          isDismissible: false,
                            Container(
                              height: 500,
                              decoration: BoxDecoration(
                                  color: kWhite,
                                  borderRadius: BorderRadius.only(topRight: Radius.circular(30), topLeft: Radius.circular(30))
                              ),
                              child: SingleChildScrollView(
                                child: Column(
                                  children: [
                                    SizedBox(height: 320,
                                      child: CupertinoDatePicker(
                                        mode: CupertinoDatePickerMode.date,
                                        initialDateTime: DateTime.now(),
                                        minimumYear: 1960,
                                        onDateTimeChanged: (value) {
                                          String getWeekdayName(int weekday) {
                                            if(weekday == 1){
                                              return "Monday";
                                            }
                                            else if(weekday == 2){
                                              return "Tuesday";
                                            }
                                            else if(weekday == 3){
                                              return "Wednesday";
                                            }else if(weekday == 4){
                                              return "Thursday";
                                            }
                                            else if(weekday == 5){
                                              return "Friday";
                                            }
                                            else if(weekday == 6){
                                              return "Saturday";
                                            }
                                            else{
                                              return "Sunday";
                                            }

                                          }
                                          controller.valDate.value = "";
                                          controller.valDate.value = "${value.toString().substring(0, 10)}";

                                          String getMonthName(int month) {
                                            final format = DateFormat('MMMM'); // MMMM for full month names
                                            return format.format(DateTime(2024, month, 1)); // Set day to 1 for any month
                                          }
                                          print("${value.weekday}");
                                          controller.TodayDate.value = value.day.toString();
                                          controller.month.value = "${getMonthName(value.month)}, ${value.year}";
                                          controller.dayStr.value = getWeekdayName(value.weekday);

                                          controller.SelectedDate.value = value.toString().substring(0,10);

                                        },),
                                    ),

                                    InkWell(
                                      onTap: () {
                                        lightImpact();

                                        controller.dataListNote(controller.SelectedDate.value);
                                        setState(() {

                                        });
                                        Navigator.pop(context);

                                      },
                                      child: Container(
                                        height: h * 0.05,
                                        width: w * 0.95,
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                            color: kDarkBlue3,
                                            borderRadius: BorderRadius.circular(10)
                                        ),
                                        child: textWidget(msg: "OK", txtColor: kWhite, txtFontSize: h * 0.016, txtFontWeight: FontWeight.w600),
                                      ),
                                    ),
                                    SizedBox(height: h * 0.01,)
                                  ],
                                ),
                              ),
                            )
                        );

                      },
                      child: Obx(() => Container(
                        width: w * 0.5,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            textWidget(msg: "${controller.TodayDate.value}", txtColor: kWhite, txtFontSize: h * 0.023, txtFontWeight: FontWeight.w700),
                            SizedBox(width: w * 0.04,),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                textWidget(msg: "${controller.month.value}", txtColor: kWhite, txtFontSize: h * 0.015, txtFontWeight: FontWeight.w500),
                                textWidget(msg: "${controller.dayStr.value}", txtColor: kWhite, txtFontSize: h * 0.015, txtFontWeight: FontWeight.w500),
                              ],
                            )
                          ],
                        ),
                      )),
                    ),

                  ],
                ),
              ),
            ],
          ),

          Expanded(
            child: Padding(
              padding: EdgeInsets.all(h * 0.015),
              child: TextField(
                controller: controller.note,
                keyboardType: TextInputType.multiline,
                maxLines: 99999,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: "Start Typing",
                  hintStyle: TextStyle(color: kBlack.withOpacity(0.3))
                ),
              ),
            ),
          )
        ],
      )
          : Column(
        children: [
          SizedBox(height: h * 0.01,),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: h * 0.05,
                width: w * 0.95,
                decoration: BoxDecoration(
                  color: kDarkBlue3,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: () {

                        DateTime? _chosenDateTime;
                        Get.bottomSheet(
                          isDismissible: false,
                            Container(
                              height: 500,
                              decoration: BoxDecoration(
                                  color: kWhite,
                                  borderRadius: BorderRadius.only(topRight: Radius.circular(30), topLeft: Radius.circular(30))
                              ),
                              child: SingleChildScrollView(
                                child: Column(
                                  children: [
                                    SizedBox(height: 320,
                                      child: CupertinoDatePicker(
                                        mode: CupertinoDatePickerMode.monthYear,
                                        initialDateTime: DateTime.now(),
                                        minimumYear: 1960,
                                        onDateTimeChanged: (value) {

                                          String getMonthName(int month) {
                                            final format = DateFormat('MMMM'); // MMMM for full month names
                                            return format.format(DateTime(2024, month, 1)); // Set day to 1 for any month
                                          }
                                          controller.valDate.value = value.month.toString().length == 1 ? "0${value.month}" : value.month.toString();
                                          controller.yearofList.value = value.year.toString();
                                          controller.month.value = "${getMonthName(value.month)}, ${value.year}";
                                        },),
                                    ),

                                    InkWell(
                                      onTap: () {
                                        print("month == ${controller.valDate.value}");
                                        controller.dataListNote(controller.valDate.value);
                                        setState(() {

                                        });
                                        Navigator.pop(context);
                                      },
                                      child: Container(
                                        height: h * 0.05,
                                        width: w * 0.95,
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                            color: kDarkBlue3,
                                            borderRadius: BorderRadius.circular(10)
                                        ),
                                        child: textWidget(msg: "OK", txtColor: kWhite, txtFontSize: h * 0.016, txtFontWeight: FontWeight.w600),
                                      ),
                                    ),
                                    SizedBox(height: h * 0.01,)
                                  ],
                                ),
                              ),
                            )
                        );

                      },
                      child: Obx(() => Container(
                        width: w * 0.5,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [

                            textWidget(msg: "${controller.month.value}", txtColor: kWhite, txtFontSize: h * 0.015, txtFontWeight: FontWeight.w500)
                          ],
                        ),
                      )),
                    ),

                  ],
                ),
              ),
            ],
          ),
          
          Expanded(
            child: Obx(() => controller.status.value
                ? controller.NoteList.isNotEmpty
            ? ListView.builder(
              itemCount: controller.NoteList.length,
              itemBuilder: (context, index) {
                return Container(
                  height: h * 0.1,
                  width: w * 0.95,
                  margin: EdgeInsets.only(left: h * 0.01, top: h * 0.01, right: h * 0.01),
                  decoration: BoxDecoration(
                      color: kWhite,
                      borderRadius: BorderRadius.circular(15)
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(padding: EdgeInsets.only(left: w * 0.05, top: h * 0.01),
                        child: textWidget(msg: "${controller.NoteList[index]["dt"]}", txtColor: kDarkBlue3, txtFontSize: h * 0.018, txtFontWeight: FontWeight.w600),
                      ),
                      Flexible(
                        child: Padding(padding: EdgeInsets.only(left: w * 0.05, top: h * 0.005, bottom: h * 0.005),
                        child: textWidget(msg: "${controller.NoteList[index]["content"]}", txtColor: kDarkBlue3, txtFontSize: h * 0.016, txtFontWeight: FontWeight.w500,ovrflw: TextOverflow.fade, txaln: TextAlign.start,),
                        ),
                      )
                    ],
                  ),
                );
              },
            )
                : Center(child: textWidget(msg: "No Notes Found", txtColor: kDarkBlue3, txtFontSize: h * 0.016, txtFontWeight: FontWeight.w600),)
              : Center(child: CircularProgressIndicator(color: kDarkBlue3,strokeWidth: 3,),),
            )
          )
        ],
      ),)
    );
  }
}


class noteController extends GetxController{

  RxBool addNote = false.obs;

  RxString SelectedDate = "${DateTime.now().toString().substring(0, 10)}".obs;

  String getWeekdayName(int weekday) {
    if(weekday == 1){
      return "Monday";
    }
    else if(weekday == 2){
      return "Tuesday";
    }
    else if(weekday == 3){
      return "Wednesday";
    }else if(weekday == 4){
      return "Thursday";
    }
    else if(weekday == 5){
      return "Friday";
    }
    else if(weekday == 6){
      return "Saturday";
    }
    else{
      return "Sunday";
    }

  }

  String getMonthName(int month) {
    final format = DateFormat('MMMM'); // MMMM for full month names
    return format.format(DateTime(2024, month, 1)); // Set day to 1 for any month
  }

  RxString TodayDate = DateTime.now().day.toString().obs;
  RxString month = "".obs;
  RxString dayStr = "".obs;
  RxString valDate = "".obs;
  RxBool status = false.obs;

  Database? db;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();

    Model().createDatabase().then((value) {
      db = value;
    });

    month.value = "${getMonthName(DateTime.now().month)}, ${DateTime.now().year}";
    dayStr.value = getWeekdayName(DateTime.now().weekday);

    status.value = false;
    dataListNote(DateTime.now().month.toString().length == 1 ? "0${DateTime.now().month}" : DateTime.now().month.toString());
    status.value = true;
    
  }

  final note = TextEditingController();

  Future<void> onSubmit(BuildContext context) async {
    if(note.text.trim().isNotEmpty){

      final database = await Model().createDatabase();

      final String query = "SELECT * FROM notes";

      // Execute the query and get the results as a list of maps
      final results = await database.rawQuery(query);
      print("RESULTS === $results");

      if(results.isEmpty){
        String qry =
            "INSERT INTO notes (content, dt) values ('${note.text.trim()}', '${SelectedDate.value}')";
        db!.rawInsert(qry).then((value) {
          print(value);
        });

        note.text = "";


        Get.snackbar("Success", "Note Added Successfull ...!",
            backgroundColor: kGreen,
            colorText: kWhite,
            duration: Duration(seconds: 2));

        dataListNote(DateTime.now().month.toString().length == 1 ? "0${DateTime.now().month}" : DateTime.now().month.toString());

      }
      else{
        RxBool isThere = false.obs;
        for(int i = 0; i < results.length; i++){
          if(results[i]["dt"].toString() == SelectedDate.value){
            isThere.value = false;
            String qry =
                "UPDATE notes set content = '${note.text.trim()}' where dt = '${SelectedDate.value}'";
            db!.rawUpdate(qry).then((value) {
              print(value);
            });

            note.text = "";


            Get.snackbar("Success", "Note Updated Successfull ...!",
                backgroundColor: kGreen,
                colorText: kWhite,
                duration: Duration(seconds: 2));

            dataListNote(DateTime.now().month.toString().length == 1 ? "0${DateTime.now().month}" : DateTime.now().month.toString());
            break;
          }
          else{
            isThere.value = true;
          }
        }

        if(isThere.value == true){
          String qry =
              "INSERT INTO notes (content, dt) values ('${note.text.trim()}', '${SelectedDate.value}')";
          db!.rawInsert(qry).then((value) {
            print(value);
          });

          note.text = "";


          Get.snackbar("Success", "Note Added Successfull ...!",
              backgroundColor: kGreen,
              colorText: kWhite,
              duration: Duration(seconds: 2));

          dataListNote(DateTime.now().month.toString().length == 1 ? "0${DateTime.now().month}" : DateTime.now().month.toString());

        }
      }


    }
    else{
      final database = await Model().createDatabase();

      final String query = "DELETE From notes";

      // Execute the query and get the results as a list of maps
      final results = await database.rawDelete(query);
      Get.snackbar("Success", "Note Deleted Successfull ...!",
          backgroundColor: kGreen,
          colorText: kWhite,
          duration: Duration(seconds: 2));

      dataListNote(DateTime.now().month.toString().length == 1 ? "0${DateTime.now().month}" : DateTime.now().month.toString());

    }
  }

  RxList NoteList = [].obs;
  RxString yearofList = "${DateTime.now().year}".obs;

  Future<List<Map<String, dynamic>>> dataListNote(String dt) async {

    NoteList.clear();
    note.text = "";
    // Open the database connection
    final database = await Model().createDatabase();

    // Define the query to select all data from the "expenses" table
    final String query = "SELECT * FROM notes";

    // Execute the query and get the results as a list of maps
    final results = await database.rawQuery(query);


    print("${DateTime.now().toString().substring(0, 11)}");

    for(int i = 0; i < results.length; i++){
      print("month====${results[i]["dt"].toString().substring(6,8)}");
      if(results[i]["dt"].toString().substring(5,7) == dt && results[i]["dt"].toString().substring(0,4) == "${yearofList.value}"){
        NoteList.add(results[i]);
      }
      print("first === ${results[i]["dt"].toString().trim()}");
      print("Second === ${DateTime.now().toString().substring(0, 11)}");
      print("Condition === ${results[i]["dt"].toString().trim() == "${DateTime.now().toString().substring(0, 11)}"}");
      if(dt.trim() == results[i]["dt"].toString().trim()){
        note.text = results[i]["content"].toString();
        
      }
    }

    // Return the complete list of results
    return results;
  }

}
