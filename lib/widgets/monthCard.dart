import 'package:daytoday/widgets/text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../global/Model.dart';
import '../global/globals.dart';
import '../global/variables.dart';

class monthCard extends StatefulWidget {

  RxList debitData;
  RxList creditData;
  double creditTotal;
  double debitTotal;
  double savings;
  String dt;

  monthCard(this.debitData, this.creditData, this.creditTotal, this.debitTotal, this.savings, this.dt);




  @override
  State<monthCard> createState() => _monthCardState();
}

class _monthCardState extends State<monthCard> {
  @override
  Widget build(BuildContext context) {
    
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      backgroundColor: kWhite,

      content: Container(
        height: h * 0.7,
        width: w,
        child: Column(
          children: [
            textWidget(msg: "${widget.dt}", txtColor: kDarkBlue3, txtFontSize: h * 0.018, txtFontWeight: FontWeight.w600),
            SizedBox(height: h * 0.01,),

            Container(
              height: h * 0.04,
              width: w,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: kDarkBlue3,
                borderRadius: BorderRadius.circular(10)
              ),
              child: textWidget(msg: "Income [ Credit ]", txtColor: kWhite, txtFontSize: h * 0.016, txtFontWeight: FontWeight.w600),
            ),

            Obx(() => Expanded(
              child: widget.creditData.isNotEmpty
                  ? ListView.builder(
                itemCount: widget.creditData.length,
                itemBuilder: (context, index) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      textWidget(msg: "${widget.creditData[index]["title"]}", txtColor: kDarkBlue3, txtFontSize: h * 0.016, txtFontWeight: FontWeight.w500),
                      textWidget(msg: "₹ ${widget.creditData[index]["amount"]}/-", txtColor: kDarkBlue3, txtFontSize: h * 0.016, txtFontWeight: FontWeight.w500),
                    ],
                  );
                },
              )
                  : Center(child: textWidget(msg: "No Data Found", txtColor: kDarkBlue3, txtFontSize: h * 0.016, txtFontWeight: FontWeight.w600),)

            )),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: EdgeInsets.only(left: h * 0.005, top: h * 0.01),
                  child: textWidget(msg: "Total :", txtColor: kGreen, txtFontSize: h * 0.016, txtFontWeight: FontWeight.w500),
                ),
                Padding(
                  padding: EdgeInsets.only(right: h * 0.005, top: h * 0.01),
                  child: textWidget(msg: "₹ ${widget.creditTotal}/-", txtColor: kGreen, txtFontSize: h * 0.016, txtFontWeight: FontWeight.w500),
                ),
              ],
            ),

            SizedBox(height: h * 0.01,),

            Container(
              height: h * 0.04,
              width: w,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: kDarkBlue3,
                  borderRadius: BorderRadius.circular(10)
              ),
              child: textWidget(msg: "Expense [ Debit ]", txtColor: kWhite, txtFontSize: h * 0.016, txtFontWeight: FontWeight.w600),
            ),
            
            Obx(() => Expanded(
              child: widget.debitData.isNotEmpty
                  ? ListView.builder(
                itemCount: widget.debitData.length,
                itemBuilder: (context, index) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: h * 0.005, top: h * 0.01),
                        child: textWidget(msg: "${widget.debitData[index]["title"]}", txtColor: kDarkBlue3, txtFontSize: h * 0.016, txtFontWeight: FontWeight.w500),
                      ),
                      Padding(
                        padding: EdgeInsets.only(right: h * 0.005, top: h * 0.01),
                        child: textWidget(msg: "₹ ${widget.debitData[index]["amount"]}/-", txtColor: kDarkBlue3, txtFontSize: h * 0.016, txtFontWeight: FontWeight.w500),
                      ),
                    ],
                  );
                },
              )
                  : Center(child: textWidget(msg: "No Data Found", txtColor: kDarkBlue3, txtFontSize: h * 0.016, txtFontWeight: FontWeight.w600),)

            ),
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: EdgeInsets.only(left: h * 0.005, top: h * 0.01),
                  child: textWidget(msg: "Total :", txtColor: kError, txtFontSize: h * 0.016, txtFontWeight: FontWeight.w500),
                ),
                Padding(
                  padding: EdgeInsets.only(right: h * 0.005, top: h * 0.01),
                  child: textWidget(msg: "₹ ${widget.debitTotal}/-", txtColor: kError, txtFontSize: h * 0.016, txtFontWeight: FontWeight.w500),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}


