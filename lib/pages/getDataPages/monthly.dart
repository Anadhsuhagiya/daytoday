import 'package:daytoday/global/globals.dart';
import 'package:daytoday/global/haptic.dart';
import 'package:daytoday/widgets/frostedGlass.dart';
import 'package:daytoday/widgets/monthCard.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:sqflite/sqflite.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';

import '../../global/Model.dart';
import '../../global/variables.dart';
import '../../widgets/mobile.dart';
import '../../widgets/text.dart';

class monthly extends StatefulWidget {
  const monthly({super.key});

  @override
  State<monthly> createState() => _monthlyState();
}

class _monthlyState extends State<monthly> {

  final controller = Get.put(monthlyController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    go();
  }

  go() async {
    controller.status.value = false;
    await Future.delayed(Duration(seconds: 1));
    controller.status.value = true;
  }

  @override
  Widget build(BuildContext context) {



    return Scaffold(
      backgroundColor: kHomeBG,
      
      floatingActionButton: FloatingActionButton(onPressed: () async {
        lightImpact();

        controller.dataListMonthlyPDF(controller.PDFMonth.value);
        await Future.delayed(Duration(seconds: 1));

        Get.bottomSheet(
          isDismissible: false,
          Container(
            height: h * 0.1,
            width: w,
            decoration: BoxDecoration(
              color: kWhite,
              borderRadius: BorderRadius.only(topRight: Radius.circular(30), topLeft: Radius.circular(30))
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                CircularProgressIndicator(color: kDarkBlue3,strokeWidth: 3,),
                textWidget(msg: "Please wait creating PDF ... ", txtColor: kDarkBlue3, txtFontSize: h * 0.018, txtFontWeight: FontWeight.w600)
              ],
            ),
          )
        );
        controller._createPdf();
      },
      backgroundColor: kDarkBlue3,
        child: Image.asset("assets/images/pdf.png", width: w * 0.07,color: kWhite,),
      ),

      body: Column(
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
                                          controller.monthofList.value = value.month.toString();
                                          controller.month.value = "${getMonthName(value.month)}, ${value.year}";
                                        },),
                                    ),


                                    InkWell(
                                      onTap: () {
                                        lightImpact();

                                        controller.PDFMonth.value = "${controller.yearofList.value}-${controller.monthofList.value.length == 1 ? '0${controller.monthofList.value}' : controller.monthofList.value}";
                                        controller.dataListMonthDays(controller.valDate.value);
                                        controller.dataListMonthlyLists("${controller.yearofList.value}-${controller.monthofList.value.length == 1 ? '0${controller.monthofList.value}' : controller.monthofList.value}");
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
          SizedBox(height: h * 0.01,),
          Obx(() => Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: h * 0.1,
                width: w * 0.95,
                decoration: BoxDecoration(
                    color: kDarkBlue3.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(10)
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(left: w * 0.05,),
                              child: textWidget(msg: "Total Income [ Credit ]", txtColor: kWhite, txtFontSize: h * 0.016, txtFontWeight: FontWeight.w600),
                            ),

                            Padding(
                              padding: EdgeInsets.only(left: w * 0.05, top: h * 0.01),
                              child: textWidget(msg: "₹ ${controller.MonthCreditTotal.value}/-", txtColor: kWhite, txtFontSize: h * 0.014, txtFontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(left: w * 0.05),
                              child: textWidget(msg: "Total Expense [ Debit ]", txtColor: kWhite, txtFontSize: h * 0.016, txtFontWeight: FontWeight.w600),
                            ),

                            Padding(
                              padding: EdgeInsets.only(left: w * 0.05, top: h * 0.01),
                              child: textWidget(msg: "₹ ${controller.MonthDebitTotal.value}/-", txtColor: kWhite, txtFontSize: h * 0.014, txtFontWeight: FontWeight.w500),
                            ),

                            Padding(
                              padding: EdgeInsets.only(left: w * 0.05,top: h * 0.01),
                              child: textWidget(msg: "Savings = ₹ ${controller.MonthSavings.value}/-", txtColor: kWhite, txtFontSize: h * 0.016, txtFontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                      ],
                    ),


                  ],
                ),
              )
            ],
          )),

          //List
          Obx(() => Expanded(
            child: controller.status.value
                ? controller.dates.isEmpty
            ? Center(child: textWidget(msg: "No Data Found", txtColor: kDarkBlue3, txtFontSize: h * 0.018, txtFontWeight: FontWeight.w600),)
             : ListView.builder(
              itemCount: controller.dates.length,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () async {
                    lightImpact();

                    controller.dataListMonthly(controller.dates[index]["dt"].toString());

                      await showDialog(context: context, builder: (context) {
                        return FrostedGlass(widget: monthCard(controller.DebitData, controller.CreditData, controller.CreditTotal.value, controller. DebitTotal.value, controller.savings.value, controller.dates[index]["dt"].toString()));
                      },);
                  },
                  child: Container(
                    height: h * 0.08,
                    width: w * 0.95,
                    margin: EdgeInsets.only(left: h * 0.01, top: h * 0.01, right: h * 0.01),
                    decoration: BoxDecoration(
                        color: kWhite,
                        borderRadius: BorderRadius.circular(15)
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          flex: 3,
                          child: Padding(
                            padding: EdgeInsets.only(left: w * 0.05),
                            child: textWidget(msg: "${controller.dates[index]["dt"]}", txtColor: kDarkBlue3, txtFontSize: h * 0.016, txtFontWeight: FontWeight.w600),
                          ),
                        ),
                        Expanded(flex: 1,child: SizedBox()),
                        Expanded(
                          flex: 5,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(right: w * 0.05),
                                child: textWidget(msg: "Credit Total : ₹ ${controller.ListCreditTotal[index]}/-", txtColor: kGreen, txtFontSize: h * 0.016, txtFontWeight: FontWeight.w500),
                              ),
                              Padding(
                                padding: EdgeInsets.only(right: w * 0.05),
                                child: textWidget(msg: "Debit Total : ₹ ${controller.ListDebitTotal[index]}/-", txtColor: kError, txtFontSize: h * 0.016, txtFontWeight: FontWeight.w500),
                              ),
                          
                              Padding(
                                padding: EdgeInsets.only(right: w * 0.05),
                                child: textWidget(msg: "Savings : ₹ ${controller.ListSavings[index]}/-", txtColor: kDarkBlue3, txtFontSize: h * 0.018, txtFontWeight: FontWeight.w600),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                );
              },
            )
                : Center(child: CircularProgressIndicator(color: kDarkBlue3,strokeWidth: 3,),),
          ))

        ],
      ),
    );
  }
}


class monthlyController extends GetxController{

  RxBool addNote = false.obs;

  RxString SelectedDate = "${DateTime.now().toString().substring(0, 10)}".obs;

  RxString PDFMonth = "${DateTime.now().year}-${DateTime.now().month.toString().length == 1 ? '0${DateTime.now().month.toString()}' : DateTime.now().month.toString()}".obs;

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

  RxString yearofList = "${DateTime.now().year}".obs;
  RxString monthofList = "${DateTime.now().month}".obs;

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
    dataListMonthDays(DateTime.now().month.toString().length == 1 ? "0${DateTime.now().month}" : DateTime.now().month.toString());
    dataListMonthlyLists("${yearofList.value}-${monthofList.value.length == 1 ? '0${monthofList.value}' : monthofList.value}");
    status.value = true;
  }


  RxList dates = [].obs;

  Future<List<Map<String, dynamic>>> dataListMonthDays(String dt) async {

    dates.value.clear();
    // Open the database connection
    final database = await Model().createDatabase();

    // Define the query to select all data from the "expenses" table
    final String query = "SELECT DISTINCT dt AS dt FROM expenses order by dt";

    // Execute the query and get the results as a list of maps
    final results = await database.rawQuery(query);

    for(int i = 0; i < results.length; i++){
      if(results[i]["dt"].toString().substring(5,7) == dt && results[i]["dt"].toString().substring(0,4) == "${yearofList.value}"){
        dates.add(results[i]);
      }
    }

    print("dates=== ${dates.value}");
    // Return the complete list of results
    return results;
  }



  RxList CreditData = [].obs;
  RxList DebitData = [].obs;
  RxDouble CreditTotal = 0.0.obs;
  RxDouble DebitTotal = 0.0.obs;
  RxDouble savings = 0.0.obs;

  RxBool statData=  false.obs;

  Future<List<Map<String, dynamic>>> dataListMonthly(String dt) async {

    statData.value = false;

    CreditTotal.value = 0.0;
    DebitTotal.value = 0.0;

    CreditData.clear();
    DebitData.clear();

    // Open the database connection
    final database = await Model().createDatabase();

    // Define the query to select all data from the "expenses" table
    final String query = "SELECT * FROM expenses order by dt";

    // Execute the query and get the results as a list of maps
    final List<Map<String, dynamic>> results = await database.rawQuery(query);

    // Separate data into CreditData and DebitData (optional)
    List CreditData1 = results.where((element) => element["mode"] == "Credit").toList();
    List DebitData1 = results.where((element) => element["mode"] == "Debit").toList();

    for(int i = 0; i < CreditData1.length; i++){
      if(CreditData1[i]["dt"].toString() == dt){
        CreditData.add(CreditData1[i]);
      }
    }

    for(int i = 0; i < DebitData1.length; i++){
      if(DebitData1[i]["dt"].toString() == dt){
        DebitData.add(DebitData1[i]);
      }
    }

    for(int i = 0; i < CreditData.length; i++){
      CreditTotal.value = CreditTotal.value + int.parse(CreditData[i]["amount"]);
    }

    for(int i = 0; i < DebitData.length; i++){
      DebitTotal.value = DebitTotal.value + int.parse(DebitData[i]["amount"]);
    }

    savings.value = CreditTotal.value - DebitTotal.value;

    // Print the results for debugging purposes
    print("Data: $results");
    print("CreditData: ${CreditData.value}");
    print("DebitData: ${DebitData.value}");


    // Return the complete list of results
    return results;
  }

  Future<List<Map<String, dynamic>>> dataListMonthlyPDF(String dt) async {

    statData.value = false;

    CreditTotal.value = 0.0;
    DebitTotal.value = 0.0;

    CreditData.clear();
    DebitData.clear();

    // Open the database connection
    final database = await Model().createDatabase();

    // Define the query to select all data from the "expenses" table
    final String query = "SELECT * FROM expenses order by dt";

    // Execute the query and get the results as a list of maps
    final List<Map<String, dynamic>> results = await database.rawQuery(query);

    // Separate data into CreditData and DebitData (optional)
    List CreditData1 = results.where((element) => element["mode"] == "Credit").toList();
    List DebitData1 = results.where((element) => element["mode"] == "Debit").toList();

    for(int i = 0; i < CreditData1.length; i++){
      if(CreditData1[i]["dt"].toString().substring(0,7) == dt){
        CreditData.add(CreditData1[i]);
      }
    }

    for(int i = 0; i < DebitData1.length; i++){
      if(DebitData1[i]["dt"].toString().substring(0,7) == dt){
        DebitData.add(DebitData1[i]);
      }
    }

    for(int i = 0; i < CreditData.length; i++){
      CreditTotal.value = CreditTotal.value + int.parse(CreditData[i]["amount"]);
    }

    for(int i = 0; i < DebitData.length; i++){
      DebitTotal.value = DebitTotal.value + int.parse(DebitData[i]["amount"]);
    }

    savings.value = CreditTotal.value - DebitTotal.value;

    // Print the results for debugging purposes
    print("Data: $results");
    print("CreditData: ${CreditData.value}");
    print("DebitData: ${DebitData.value}");


    // Return the complete list of results
    return results;
  }


  RxList ListCreditTotal = [].obs;
  RxList ListDebitTotal = [].obs;
  RxList ListSavings = [].obs;

  RxDouble MonthCreditTotal = 0.0.obs;
  RxDouble MonthDebitTotal = 0.0.obs;
  RxDouble MonthSavings = 0.0.obs;

  Future<List<Map<String, dynamic>>> dataListMonthlyLists(String s) async {

    statData.value = false;

    ListCreditTotal.clear();
    ListDebitTotal.clear();
    ListSavings.clear();

    MonthCreditTotal.value = 0.0;
    MonthDebitTotal.value = 0.0;
    MonthSavings.value = 0.0;

    // Open the database connection
    final database = await Model().createDatabase();

    print(s);
    // Define the query to select all data from the "expenses" table
    final String query = '''SELECT
  dt AS date,
  SUM(CASE WHEN mode = 'Credit' THEN amount ELSE 0 END) AS credit_total,
  SUM(CASE WHEN mode = 'Debit' THEN amount ELSE 0 END) AS debit_total,
  SUM(CASE WHEN mode = 'Savings' THEN amount ELSE 0 END) AS savings_total
  FROM expenses
  WHERE strftime('%Y-%m', dt) = '${s}'
  GROUP BY dt
  ORDER BY dt;
    ''';

    // Execute the query and get the results as a list of maps
    final List<Map<String, dynamic>> results = await database.rawQuery(query);

    print("result ==== $results");

    for(int i = 0; i < results.length; i++){
      ListCreditTotal.add(results[i]["credit_total"].toString());
      ListDebitTotal.add(results[i]["debit_total"].toString());

      RxDouble savi = 0.0.obs;
      savi.value = double.parse(ListCreditTotal[i]) - double.parse(ListDebitTotal[i]);

      ListSavings.add(savi.value.round().toString());

      MonthCreditTotal.value = MonthCreditTotal.value + double.parse(ListCreditTotal[i]);
      MonthDebitTotal.value = MonthDebitTotal.value + double.parse(ListDebitTotal[i]);

    }
    MonthSavings.value = MonthCreditTotal.value - MonthDebitTotal.value;
    print("Credit : ${ListCreditTotal}");
    print("Debit : ${ListDebitTotal}");
    print("Savings : ${ListSavings}");
    print("creTotal : ${MonthCreditTotal.value}");
    print("DebTotal : ${MonthDebitTotal.value}");
    print("SavingsTot : ${MonthSavings.value}");

    statData.value = true;

    // Return the complete list of results
    return results;
  }



  //Draws the invoice header
  PdfLayoutResult drawHeader(PdfPage page, Size pageSize, PdfGrid grid) {
    //Draw rectangle
    page.graphics.drawRectangle(
        brush: PdfSolidBrush(PdfColor(91, 126, 215)),
        bounds: Rect.fromLTWH(0, 0, pageSize.width - 115, 90));
    //Draw string
    page.graphics.drawString(
        'Day To Day', PdfStandardFont(PdfFontFamily.timesRoman, 30),
        brush: PdfBrushes.white,
        bounds: Rect.fromLTWH(25, 0, pageSize.width - 115, 90),
        format: PdfStringFormat(lineAlignment: PdfVerticalAlignment.middle));

    page.graphics.drawRectangle(
        bounds: Rect.fromLTWH(400, 0, pageSize.width - 400, 90),
        brush: PdfSolidBrush(PdfColor(65, 104, 205)));

    page.graphics.drawString(r'' +MonthSavings.value.toString() + '/- RS',
        PdfStandardFont(PdfFontFamily.timesRoman, 18),
        bounds: Rect.fromLTWH(400, 0, pageSize.width - 400, 100),
        brush: PdfBrushes.white,
        format: PdfStringFormat(
            alignment: PdfTextAlignment.center,
            lineAlignment: PdfVerticalAlignment.middle));

    final PdfFont contentFont = PdfStandardFont(PdfFontFamily.timesRoman, 9);
    //Draw string
    page.graphics.drawString('Savings', contentFont,
        brush: PdfBrushes.white,
        bounds: Rect.fromLTWH(400, 0, pageSize.width - 400, 33),
        format: PdfStringFormat(
            alignment: PdfTextAlignment.center,
            lineAlignment: PdfVerticalAlignment.bottom));
    //Create data foramt and convert it to text.
    final String invoiceNumber =
        'Date: ${DateTime.now().toString().substring(0,19)}';
    final Size contentSize = contentFont.measureString(invoiceNumber);
    // ignore: leading_newlines_in_multiline_strings
    String address = '''${name}, 
        \r\n\r\nProfession : ${profession}, 
        \r\n\r\nPurpose : ${purpose} \r\n\r\n${contact}''';

    PdfTextElement(text: invoiceNumber, font: contentFont).draw(
        page: page,
        bounds: Rect.fromLTWH(pageSize.width - (contentSize.width + 30), 120,
            contentSize.width + 30, pageSize.height - 120));

    return PdfTextElement(text: address, font: contentFont).draw(
        page: page,
        bounds: Rect.fromLTWH(30, 120,
            pageSize.width - (contentSize.width + 30), pageSize.height - 120))!;
  }

  //Draws the grid
  void drawGrid(PdfPage page, PdfGrid grid, PdfLayoutResult result) {
    Rect? totalPriceCellBounds;
    Rect? quantityCellBounds;
    //Invoke the beginCellLayout event.
    grid.beginCellLayout = (Object sender, PdfGridBeginCellLayoutArgs args) {
      final PdfGrid grid = sender as PdfGrid;
      if (args.cellIndex == grid.columns.count - 1) {
        totalPriceCellBounds = args.bounds;
      } else if (args.cellIndex == grid.columns.count - 2) {
        quantityCellBounds = args.bounds;
      }
    };
    //Draw the PDF grid and get the result.
    result = grid.draw(
        page: page, bounds: Rect.fromLTWH(0, result.bounds.bottom + 40, 0, 0))!;
    // GST
    page.graphics.drawString('Debit : ',
        PdfStandardFont(PdfFontFamily.timesRoman, 9, style: PdfFontStyle.bold),
        bounds: Rect.fromLTWH(
            quantityCellBounds!.left,
            result.bounds.bottom + 20,
            quantityCellBounds!.width,
            quantityCellBounds!.height));
    page.graphics.drawString(MonthDebitTotal.value.toString(),
        PdfStandardFont(PdfFontFamily.timesRoman, 9, style: PdfFontStyle.bold),
        bounds: Rect.fromLTWH(
            totalPriceCellBounds!.left,
            result.bounds.bottom + 20,
            totalPriceCellBounds!.width,
            totalPriceCellBounds!.height));
    //Draw total.
    page.graphics.drawString('Credit : ',
        PdfStandardFont(PdfFontFamily.timesRoman, 9, style: PdfFontStyle.bold),
        bounds: Rect.fromLTWH(
            quantityCellBounds!.left,
            result.bounds.bottom + 10,
            quantityCellBounds!.width,
            quantityCellBounds!.height));
    page.graphics.drawString(MonthCreditTotal.value.toString(),
        PdfStandardFont(PdfFontFamily.timesRoman, 9, style: PdfFontStyle.bold),
        bounds: Rect.fromLTWH(
            totalPriceCellBounds!.left,
            result.bounds.bottom + 10,
            totalPriceCellBounds!.width,
            totalPriceCellBounds!.height));

    //Draw Grand total.
    page.graphics.drawString('Savings : ',
        PdfStandardFont(PdfFontFamily.timesRoman, 9, style: PdfFontStyle.bold),
        bounds: Rect.fromLTWH(
            quantityCellBounds!.left,
            result.bounds.bottom + 50,
            quantityCellBounds!.width,
            quantityCellBounds!.height));
    page.graphics.drawString(MonthSavings.value.toString(),
        PdfStandardFont(PdfFontFamily.timesRoman, 9, style: PdfFontStyle.bold),
        bounds: Rect.fromLTWH(
            totalPriceCellBounds!.left,
            result.bounds.bottom + 50,
            totalPriceCellBounds!.width,
            totalPriceCellBounds!.height));
  }

  //Draw the invoice footer data.
  void drawFooter(PdfPage page, Size pageSize) {
    // final PdfPen linePen =
    // PdfPen(PdfColor(142, 170, 219), dashStyle: PdfDashStyle.custom);
    // linePen.dashPattern = <double>[3, 3];
    // //Draw line
    // page.graphics.drawLine(linePen, Offset(0, pageSize.height - 100),
    //     Offset(pageSize.width, pageSize.height - 100));
    //
    // const String footerContent =
    // // ignore: leading_newlines_in_multiline_strings
    // '''24 x 7\r\n\r\nVarachha, Surat,
    //      Gujarat, India\r\n\r\nAny Questions? Contact through app''';
    //
    // //Added 30 as a margin for the layout
    // page.graphics.drawString(
    //     footerContent, PdfStandardFont(PdfFontFamily.timesRoman, 9),
    //     format: PdfStringFormat(alignment: PdfTextAlignment.right),
    //     bounds: Rect.fromLTWH(pageSize.width - 30, pageSize.height - 70, 0, 0));
  }

  void addProducts(String id, String dt, String name, String creditTotal, String debitTotal, String savingsTotal, PdfGrid grid) {
    final PdfGridRow row = grid.rows.add();
    row.cells[0].value = id;
    row.cells[1].value = dt;
    row.cells[2].value = name;
    row.cells[3].value = creditTotal;
    row.cells[4].value = debitTotal;
    row.cells[5].value = savingsTotal;
  }
  
  PdfGrid getGrid() {
    //Create a PDF grid
    final PdfGrid grid = PdfGrid();
    //Secify the columns count to the grid.
    grid.columns.add(count: 6);
    //Create the header row of the grid.
    final PdfGridRow headerRow = grid.headers.add(1)[0];
    //Set style
    headerRow.style.backgroundBrush = PdfSolidBrush(PdfColor(68, 114, 196));
    headerRow.style.textBrush = PdfBrushes.white;
    headerRow.cells[0].value = 'ID';
    headerRow.cells[0].stringFormat.alignment = PdfTextAlignment.center;
    headerRow.cells[1].value = 'Date';
    headerRow.cells[2].value = 'Description';
    headerRow.cells[3].value = 'Credit';
    headerRow.cells[4].value = 'Debit';
    headerRow.cells[5].value = 'Savings';
    //Add rows
    for(int i = 0; i < (CreditData.length); i++){
      addProducts((i + 1).toString(), "${CreditData[i]["dt"]}", "${CreditData[i]["title"]}", "${CreditData.value[i]["amount"]}", "0", "", grid);
    }

    for(int i = 0; i < (DebitData.length); i++){
      addProducts((i + CreditData.length).toString(), "${DebitData[i]["dt"]}", "${DebitData[i]["title"]}", "0", "${DebitData.value[i]["amount"]}", "", grid);
    }
    // addProducts('CA-1098', 'AWC Logo Cap', 8.99, 2, 17.98, grid);
    // addProducts('LJ-0192', 'Long-Sleeve Logo Jersey,M', 49.99, 3, 149.97, grid);
    // addProducts('So-B909-M', 'Mountain Bike Socks,M', 9.5, 2, 19, grid);
    // addProducts('LJ-0192', 'Long-Sleeve Logo Jersey,M', 49.99, 4, 199.96, grid);
    // addProducts('FK-5136', 'ML Fork', 175.49, 6, 1052.94, grid);
    // addProducts('HL-U509', 'Sports-100 Helmet,Black', 34.99, 1, 34.99, grid);
    //Apply the table built-in style
    grid.applyBuiltInStyle(PdfGridBuiltInStyle.listTable4Accent5);
    //Set gird columns width
    grid.columns[1].width = 200;
    for (int i = 0; i < headerRow.cells.count; i++) {
      headerRow.cells[i].style.cellPadding =
          PdfPaddings(bottom: 5, left: 5, right: 5, top: 5);
    }
    for (int i = 0; i < grid.rows.count; i++) {
      final PdfGridRow row = grid.rows[i];
      for (int j = 0; j < row.cells.count; j++) {
        final PdfGridCell cell = row.cells[j];
        if (j == 0) {
          cell.stringFormat.alignment = PdfTextAlignment.center;
        }
        cell.style.cellPadding =
            PdfPaddings(bottom: 5, left: 5, right: 5, top: 5);
      }
    }
    return grid;
  }

  Future<void> _createPdf() async {
    PdfDocument document = PdfDocument();
    final page = document.pages.add();

    page.graphics.drawString(
        "Hello ${name}", PdfStandardFont(PdfFontFamily.timesRoman, 20));

//Get page client size
    final Size pageSize = page.getClientSize();
    //Draw rectangle
    page.graphics.drawRectangle(
        bounds: Rect.fromLTWH(0, 0, pageSize.width, pageSize.height),
        pen: PdfPen(PdfColor(142, 170, 219)));
    //Generate PDF grid.
    final PdfGrid grid = getGrid();
    //Draw the header section by creating text element
    final PdfLayoutResult result = drawHeader(page, pageSize, grid);
    //Draw grid
    drawGrid(page, grid, result);
    //Add invoice footer
    drawFooter(page, pageSize);

    generateAndSavePdf(document);



















  }

  Future<void> generateAndSavePdf(PdfDocument document) async {
    try {
      final bytes = await document.save();
      document.dispose();

      await saveAndLaunchFile(bytes, 'Bill${DateTime.now()}.pdf');
      Get.back();
    } catch (error) {
      // Handle error, e.g., show a snackbar to the user
      print("Error saving PDF: $error");
      Get.back();
    }
  }



}
