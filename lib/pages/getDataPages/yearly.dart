import 'package:daytoday/global/globals.dart';
import 'package:daytoday/global/haptic.dart';
import 'package:daytoday/pages/home.dart';
import 'package:daytoday/widgets/yearCard.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:sqflite/sqflite.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';

import '../../global/Model.dart';
import '../../global/variables.dart';
import '../../widgets/frostedGlass.dart';
import '../../widgets/mobile.dart';
import '../../widgets/monthCard.dart';
import '../../widgets/text.dart';

class yearly extends StatefulWidget {
  const yearly({super.key});

  @override
  State<yearly> createState() => _yearlyState();
}

class _yearlyState extends State<yearly> {

  final controller = Get.put(yearlyController());

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
    setState(() {

    });
  }

  @override
  Widget build(BuildContext context) {



    return Scaffold(
      backgroundColor: kHomeBG,

        floatingActionButton: FloatingActionButton(onPressed: () async {
      lightImpact();

      controller.dataListYearlyPDF(controller.year.value.toString());


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
          child: Image.asset("assets/images/pdf.png", width: w * 0.07,color: kWhite,),),

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
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [

                    IconButton(onPressed: () {
                      lightImpact();
                      controller.year.value -= 1;
                      controller.dataListMonthlyLists(controller.year.value.toString());
                      setState(() {

                      });
                    }, icon: Icon(CupertinoIcons.left_chevron, color: kWhite,)),

                    InkWell(
                      onTap: () {

                      },
                      child: Obx(() => Container(
                        width: w * 0.5,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [

                            textWidget(msg: "${controller.year.value}", txtColor: kWhite, txtFontSize: h * 0.015, txtFontWeight: FontWeight.w500)
                          ],
                        ),
                      )),
                    ),

                    IconButton(onPressed: () {
                      lightImpact();

                      controller.year.value += 1;
                      controller.dataListMonthlyLists(controller.year.value.toString());

                      setState(() {

                      });
                    }, icon: Icon(CupertinoIcons.right_chevron, color: kWhite,)),

                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: h * 0.01,),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: h * 0.05,
                width: w * 0.95,
                decoration: BoxDecoration(
                  color: kDarkBlue3.withOpacity(0.4),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    textWidget(msg: "Months", txtColor: kWhite, txtFontSize: h * 0.016, txtFontWeight: FontWeight.w600),
                    textWidget(msg: "Credit", txtColor: kWhite, txtFontSize: h * 0.016, txtFontWeight: FontWeight.w600),
                    textWidget(msg: "Debit", txtColor: kWhite, txtFontSize: h * 0.016, txtFontWeight: FontWeight.w600),
                    textWidget(msg: "Savings", txtColor: kWhite, txtFontSize: h * 0.016, txtFontWeight: FontWeight.w600),
                  ],
                ),
              ),
            ],
          ),
          Expanded(
            child: Obx(() => controller.status.value
              ? controller.ListCreditTotal.isNotEmpty
            ? ListView.builder(
              itemCount: controller.ListCreditTotal.length,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () async {
                    lightImpact();

                    controller.dataListMonthlyListsData("${controller.ListMonths[index]["month"]}");

                    Get.bottomSheet(
                      Container(
                        height: h * 0.6,
                        width: w,
                        decoration: BoxDecoration(
                            color: kHomeBG,
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(50),
                                topRight: Radius.circular(50))),
                        child: Column(
                          children: [
                            SizedBox(height: h * 0.04,),

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

                                      textWidget(msg: "${controller.ListMonths[index]["month"]}", txtColor: kWhite, txtFontSize: h * 0.015, txtFontWeight: FontWeight.w500)
                                    ],
                                  ),
                                ),
                              ],
                            ),
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
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Expanded(child: textWidget(msg: "Months", txtColor: kWhite, txtFontSize: h * 0.016, txtFontWeight: FontWeight.w600)),
                                      Expanded(child: textWidget(msg: "Credit", txtColor: kWhite, txtFontSize: h * 0.016, txtFontWeight: FontWeight.w600)),
                                      Expanded(child: textWidget(msg: "Debit", txtColor: kWhite, txtFontSize: h * 0.016, txtFontWeight: FontWeight.w600)),
                                      Expanded(child: textWidget(msg: "Savings", txtColor: kWhite, txtFontSize: h * 0.016, txtFontWeight: FontWeight.w600)),
                                    ],
                                  ),
                                ),
                              ],
                            ),

                            Obx(() => Expanded(
                              child: controller.statData.value
                              ? controller.ListSavings1.isEmpty
                                  ? Center(child: textWidget(msg: "No Data Found", txtColor: kDarkBlue3, txtFontSize: h * 0.016, txtFontWeight: FontWeight.w600),)
                                  : ListView.builder(
                                itemCount: controller.ListSavings1.length,
                                itemBuilder: (context, index) {
                                  return Container(
                                    height: h * 0.05,
                                    width: w * 0.95,
                                    margin: EdgeInsets.only(left: h * 0.01, top: h * 0.01, right: h * 0.01),
                                    decoration: BoxDecoration(
                                        color: kWhite,
                                        borderRadius: BorderRadius.circular(10)
                                    ),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      children: [

                                        Expanded(child: textWidget(msg: "${controller.dates[index]}", txtColor: kDarkBlue3, txtFontSize: h * 0.014, txtFontWeight: FontWeight.w500)),
                                        Expanded(child: textWidget(msg: "₹ ${controller.ListCreditTotal1[index]}/-", txtColor: kGreen, txtFontSize: h * 0.014, txtFontWeight: FontWeight.w500)),
                                        Expanded(child: textWidget(msg: "₹ ${controller.ListDebitTotal1[index]}/-", txtColor: kError, txtFontSize: h * 0.014, txtFontWeight: FontWeight.w500)),
                                        Expanded(child: textWidget(msg: "₹ ${controller.ListSavings1[index]}/-", txtColor: kDarkBlue3, txtFontSize: h * 0.014, txtFontWeight: FontWeight.w500)),

                                      ],
                                    ),
                                  ) ;
                                },
                              )
                              : Center(child: CircularProgressIndicator(color: kDarkBlue3,strokeWidth: 3,),),
                            ))
                          ],
                        ),
                      )
                    );
                  },
                  child: Container(
                    height: h * 0.06,
                    width: w * 0.95,
                    margin: EdgeInsets.only(left: h * 0.01, top: h * 0.01, right: h * 0.01),
                    decoration: BoxDecoration(
                      color: kWhite,
                      borderRadius: BorderRadius.circular(15)
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                          child: textWidget(msg: "${controller.ListMonths[index]["month"]}", txtColor: kDarkBlue3, txtFontSize: h * 0.016, txtFontWeight: FontWeight.w600),
                        ),
                        Expanded(
                          child: textWidget(msg: "₹ ${controller.ListCreditTotal[index]}/-", txtColor: kGreen, txtFontSize: h * 0.016, txtFontWeight: FontWeight.w600),
                        ),
                        Expanded(
                          child: textWidget(msg: "₹ ${controller.ListDebitTotal[index]}/-", txtColor: kError, txtFontSize: h * 0.016, txtFontWeight: FontWeight.w600),
                        ),
                        Expanded(
                          child: textWidget(msg: "₹ ${controller.ListSavings[index]}/-", txtColor: kDarkBlue3, txtFontSize: h * 0.016, txtFontWeight: FontWeight.w600),
                        )
                      ],
                    ),
                  ),
                );
              },
            )
            : Center(child: textWidget(msg: "No Data Found", txtColor: kDarkBlue3, txtFontSize: h * 0.016, txtFontWeight: FontWeight.w600),)
            : Center(child: CircularProgressIndicator(color: kDarkBlue3,strokeWidth: 3,),)),
          )
        ],
      ),
    );
  }
}

class yearlyController extends GetxController{

  RxInt year = DateTime.now().year.obs;

  Database? db;
  RxBool status = false.obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();

    Model().createDatabase().then((value) {
      db = value;
    });

    status.value = false;
    dataListMonthDays(DateTime.now().month.toString().length == 1 ? "0${DateTime.now().month}" : DateTime.now().month.toString());
    dataListMonthlyLists("${DateTime.now().year}");
    dataListmonthsofYear(DateTime.now().year.toString());
    status.value = true;

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

    // Define the query to select all data from the "expenses" table
      final String query = '''SELECT
  strftime('%Y', dt) AS year,
  strftime('%Y-%m', dt) AS month,
  SUM(CASE WHEN mode = 'Credit' THEN amount ELSE 0 END) AS credit_total,
  SUM(CASE WHEN mode = 'Debit' THEN amount ELSE 0 END) AS debit_total,
  SUM(CASE WHEN mode = 'Savings' THEN amount ELSE 0 END) AS savings_total
FROM expenses
WHERE strftime('%Y', dt) = '$s'
GROUP BY strftime('%Y', dt), strftime('%Y-%m', dt)
ORDER BY strftime('%Y', dt) ASC, strftime('%Y-%m', dt) ASC;

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
      if(results[i]["dt"].toString().substring(5,7) == dt && results[i]["dt"].toString().substring(0,4) == "${year.value.toString()}"){
        dates.add(results[i]);
      }
    }

    print("dates=== ${dates.value}");
    // Return the complete list of results
    return results;
  }

  RxList ListMonths = [].obs;

  Future<List<Map<String, dynamic>>> dataListmonthsofYear(String dt) async {

    ListMonths.clear();
    status.value = false;
    // Open the database connection
    final database = await Model().createDatabase();

    // Define the query to select all data from the "expenses" table
    final String query = "SELECT DISTINCT strftime('%Y-%m', dt) AS month FROM expenses WHERE strftime('%Y', dt) = '$dt' order by month";

    // Execute the query and get the results as a list of maps
    final results = await database.rawQuery(query);

    ListMonths.value = results;
    print("RESULT === $results");

    status.value = true;
    // Return the complete list of results
    return results;
  }



  RxList ListCreditTotal1 = [].obs;
  RxList ListDebitTotal1 = [].obs;
  RxList ListSavings1 = [].obs;


  Future<List<Map<String, dynamic>>> dataListMonthlyListsData(String s) async {

    statData.value = false;

    ListCreditTotal1.clear();
    ListDebitTotal1.clear();
    ListSavings1.clear();
    dates.clear();

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

    print("result =+=== $results");

    for(int i = 0; i < results.length; i++){
      dates.add(results[i]["date"].toString());
      ListCreditTotal1.add(results[i]["credit_total"].toString());
      ListDebitTotal1.add(results[i]["debit_total"].toString());

      RxDouble savi = 0.0.obs;
      savi.value = double.parse(ListCreditTotal1[i]) - double.parse(ListDebitTotal1[i]);

      ListSavings1.add(savi.value.round().toString());

    }

    print("Dates : ${dates}");
    print("Credit : ${ListCreditTotal1}");
    print("Debit : ${ListDebitTotal1}");
    print("Savings : ${ListSavings1}");

    statData.value = true;

    // Return the complete list of results
    return results;
  }


  RxList ListMonths2 = [].obs;

  RxList ListCreditTotal2 = [].obs;
  RxList ListDebitTotal2 = [].obs;
  RxList ListSavings2 = [].obs;

  RxDouble MonthCreditTotal2 = 0.0.obs;
  RxDouble MonthDebitTotal2 = 0.0.obs;
  RxDouble MonthSavings2 = 0.0.obs;

  Future<List<Map<String, dynamic>>> dataListYearlyPDF(String s) async {

    statData.value = false;

    ListCreditTotal2.clear();
    ListDebitTotal2.clear();
    ListSavings2.clear();

    MonthCreditTotal2.value = 0.0;
    MonthDebitTotal2.value = 0.0;
    MonthSavings2.value = 0.0;

    // Open the database connection
    final database = await Model().createDatabase();

    // Define the query to select all data from the "expenses" table
    final String query = '''SELECT
  strftime('%Y', dt) AS year,
  strftime('%Y-%m', dt) AS month,
  SUM(CASE WHEN mode = 'Credit' THEN amount ELSE 0 END) AS credit_total,
  SUM(CASE WHEN mode = 'Debit' THEN amount ELSE 0 END) AS debit_total,
  SUM(CASE WHEN mode = 'Savings' THEN amount ELSE 0 END) AS savings_total
FROM expenses
WHERE strftime('%Y', dt) = '$s'
GROUP BY strftime('%Y', dt), strftime('%Y-%m', dt)
ORDER BY strftime('%Y', dt) ASC, strftime('%Y-%m', dt) ASC;

    ''';

    // Execute the query and get the results as a list of maps
    final List<Map<String, dynamic>> results = await database.rawQuery(query);

    print("result ==== $results");

    for(int i = 0; i < results.length; i++){
      ListMonths2.add(results[i]["month"].toString());
      ListCreditTotal2.add(results[i]["credit_total"].toString());
      ListDebitTotal2.add(results[i]["debit_total"].toString());

      RxDouble savi = 0.0.obs;
      savi.value = double.parse(ListCreditTotal2[i]) - double.parse(ListDebitTotal2[i]);

      ListSavings2.add(savi.value.round().toString());

      MonthCreditTotal2.value = MonthCreditTotal2.value + double.parse(ListCreditTotal2[i]);
      MonthDebitTotal2.value = MonthDebitTotal2.value + double.parse(ListDebitTotal2[i]);

    }
    MonthSavings2.value = MonthCreditTotal2.value - MonthDebitTotal2.value;
    print("Credit : ${ListCreditTotal2}");
    print("Debit : ${ListDebitTotal2}");
    print("Savings : ${ListSavings2}");
    print("creTotal : ${MonthCreditTotal2.value}");
    print("DebTotal : ${MonthDebitTotal2.value}");
    print("SavingsTot : ${MonthSavings2.value}");

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

    page.graphics.drawString(r'' +MonthSavings2.value.round().toString() + '/- RS',
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
    page.graphics.drawString(MonthDebitTotal2.value.round().toString(),
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
    page.graphics.drawString(MonthCreditTotal2.value.round().toString(),
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
    page.graphics.drawString(MonthSavings2.value.round().toString(),
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

  void addProducts(String id, String dt, String creditTotal, String debitTotal, PdfGrid grid) {
    final PdfGridRow row = grid.rows.add();
    row.cells[0].value = id;
    row.cells[1].value = dt;
    row.cells[2].value = creditTotal;
    row.cells[3].value = debitTotal;
  }

  PdfGrid getGrid() {
    //Create a PDF grid
    final PdfGrid grid = PdfGrid();
    //Secify the columns count to the grid.
    grid.columns.add(count: 4);
    //Create the header row of the grid.
    final PdfGridRow headerRow = grid.headers.add(1)[0];
    //Set style
    headerRow.style.backgroundBrush = PdfSolidBrush(PdfColor(68, 114, 196));
    headerRow.style.textBrush = PdfBrushes.white;
    headerRow.cells[0].value = 'ID';
    headerRow.cells[0].stringFormat.alignment = PdfTextAlignment.center;
    headerRow.cells[1].value = 'Date';
    headerRow.cells[2].value = 'Credit';
    headerRow.cells[3].value = 'Debit';
    //Add rows
    for(int i = 0; i < (ListCreditTotal2.length); i++){
      addProducts((i + 1).toString(), "${ListMonths2[i].toString()}", "${ListCreditTotal2.value[i].toString()}", "0", grid);
    }

    for(int i = 0; i < (ListDebitTotal2.length); i++){
      addProducts((i + ListCreditTotal2.length).toString(), "${ListMonths2[i].toString()}", "0", "${ListDebitTotal2.value[i].toString()}", grid);
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
