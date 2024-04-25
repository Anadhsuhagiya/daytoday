import 'package:daytoday/widgets/text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';

import '../global/globals.dart';
import '../global/variables.dart';

class yearCard extends StatefulWidget {

  List ListCredit;
  List ListDebit;
  List ListSavings;
  List dates;

  yearCard(this.ListCredit, this.ListDebit, this.ListSavings, this.dates);



  @override
  State<yearCard> createState() => _yearCardState();
}

class _yearCardState extends State<yearCard> {
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
            Expanded(
              child: widget.dates.isEmpty
              ? Center(child: textWidget(msg: "No Data Found", txtColor: kDarkBlue3, txtFontSize: h * 0.016, txtFontWeight: FontWeight.w600),)
              : ListView.builder(
                itemCount: widget.dates.length,
                itemBuilder: (context, index) {
                  return Container(
                    height: h * 0.05,
                    width: w,
                    margin: EdgeInsets.only(left: h * 0.01, top: h * 0.01, right: h * 0.01),
                    decoration: BoxDecoration(
                      color: kDarkBlue3,
                      borderRadius: BorderRadius.circular(15)
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(child: textWidget(msg: "${widget.dates[index]}", txtColor: kWhite, txtFontSize: h * 0.016, txtFontWeight: FontWeight.w500)),
                        Expanded(child: textWidget(msg: "${widget.ListCredit[index]}", txtColor: kWhite, txtFontSize: h * 0.016, txtFontWeight: FontWeight.w500)),
                        Expanded(child: textWidget(msg: "${widget.ListDebit[index]}", txtColor: kWhite, txtFontSize: h * 0.016, txtFontWeight: FontWeight.w500)),
                        Expanded(child: textWidget(msg: "${widget.ListSavings[index]}", txtColor: kWhite, txtFontSize: h * 0.016, txtFontWeight: FontWeight.w500)),
                      ],
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
