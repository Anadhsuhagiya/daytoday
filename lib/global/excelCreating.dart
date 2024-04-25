import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:syncfusion_flutter_xlsio/xlsio.dart';

class excel{

  Future<void> createExcel(RxList dates, List ListCreditTotal, List ListDebitTotal, List ListSavingsTotal, double MonthCreditTotal, double MonthDebitTotal, double MonthSavingTotal) async {

    final Workbook workbook = Workbook();
    final Worksheet sheet = workbook.worksheets[0];

    sheet.getRangeByName("A1").setText("ID");
    sheet.getRangeByName("B1").setText("Date");
    sheet.getRangeByName("C1").setText("Credit [ Income ]");
    sheet.getRangeByName("D1").setText("Debit [ Expense ]");
    sheet.getRangeByName("E1").setText("Savings");

    for(int i = 1; i <= ListCreditTotal.length; i++){

      sheet.getRangeByName("A${i+1}").setText("${i+1}");
      sheet.getRangeByName("B${i+1}").setText("${dates[i-1]["dt"]}");
      sheet.getRangeByName("C${i+1}").setText("${ListCreditTotal[i-1]}");
      sheet.getRangeByName("D${i+1}").setText("${ListDebitTotal[i-1]}");
      sheet.getRangeByName("E${i+1}").setText("${ListSavingsTotal[i-1]}");

    }

    sheet.getRangeByName("A${ListCreditTotal.length + 2}").setText("");
    sheet.getRangeByName("B${ListCreditTotal.length + 2}").setText("Total");
    sheet.getRangeByName("C${ListCreditTotal.length + 2}").setText("${MonthCreditTotal}");
    sheet.getRangeByName("D${ListCreditTotal.length + 2}").setText("${MonthDebitTotal}");
    sheet.getRangeByName("E${ListCreditTotal.length + 2}").setText("${MonthSavingTotal}");

    final List<int> bytes = workbook.saveAsStream();
    workbook.dispose();

    final String path = (await getApplicationSupportDirectory()).path;
    final String fileName = "$path/Output.xlsx";
    final File file = File(fileName);
    await file.writeAsBytes(bytes, flush: true);
    OpenFile.open(fileName);

  }


  Future<void> createYearExcel(List dates, List ListCreditTotal, List ListDebitTotal, List ListSavingsTotal, double MonthCreditTotal, double MonthDebitTotal, double MonthSavingTotal) async {

    final Workbook workbook = Workbook();
    final Worksheet sheet = workbook.worksheets[0];

    sheet.getRangeByName("A1").setText("ID");
    sheet.getRangeByName("B1").setText("Month");
    sheet.getRangeByName("C1").setText("Credit [ Income ]");
    sheet.getRangeByName("D1").setText("Debit [ Expense ]");
    sheet.getRangeByName("E1").setText("Savings");

    for(int i = 1; i <= ListCreditTotal.length; i++){

      sheet.getRangeByName("A${i+1}").setText("${i+1}");
      sheet.getRangeByName("B${i+1}").setText("${dates[i-1]}");
      sheet.getRangeByName("C${i+1}").setText("${ListCreditTotal[i-1]}");
      sheet.getRangeByName("D${i+1}").setText("${ListDebitTotal[i-1]}");
      sheet.getRangeByName("E${i+1}").setText("${ListSavingsTotal[i-1]}");

    }

    sheet.getRangeByName("A${ListCreditTotal.length + 2}").setText("");
    sheet.getRangeByName("B${ListCreditTotal.length + 2}").setText("Total");
    sheet.getRangeByName("C${ListCreditTotal.length + 2}").setText("${MonthCreditTotal}");
    sheet.getRangeByName("D${ListCreditTotal.length + 2}").setText("${MonthDebitTotal}");
    sheet.getRangeByName("E${ListCreditTotal.length + 2}").setText("${MonthSavingTotal}");

    final List<int> bytes = workbook.saveAsStream();
    workbook.dispose();

    final String path = (await getApplicationSupportDirectory()).path;
    final String fileName = "$path/Output.xlsx";
    final File file = File(fileName);
    await file.writeAsBytes(bytes, flush: true);
    OpenFile.open(fileName);

  }


  Future<void> createAllExcel(List dates, List ListCreditTotal, List ListDebitTotal, List ListSavingsTotal, double MonthCreditTotal, double MonthDebitTotal, double MonthSavingTotal) async {



    final Workbook workbook = Workbook();
    final Worksheet sheet = workbook.worksheets[0];

    sheet.getRangeByName("A1").setText("ID");
    sheet.getRangeByName("B1").setText("Date");
    sheet.getRangeByName("C1").setText("Credit [ Income ]");
    sheet.getRangeByName("D1").setText("Debit [ Expense ]");
    sheet.getRangeByName("E1").setText("Savings");

    for(int i = 0; i < dates.length; i++){

      sheet.getRangeByName("A${i+2}").setText("${i+1}");
      sheet.getRangeByName("B${i+2}").setText("${dates[i]}");
      sheet.getRangeByName("C${i+2}").setText("${ListCreditTotal[i]}");
      sheet.getRangeByName("D${i+2}").setText("${ListDebitTotal[i]}");
      sheet.getRangeByName("E${i+2}").setText("${double.parse(ListCreditTotal[i]).round() - double.parse(ListDebitTotal[i]).round()}");

    }

    sheet.getRangeByName("A${ListCreditTotal.length + 2}").setText("");
    sheet.getRangeByName("B${ListCreditTotal.length + 2}").setText("Total");
    sheet.getRangeByName("C${ListCreditTotal.length + 2}").setText("${MonthCreditTotal}");
    sheet.getRangeByName("D${ListCreditTotal.length + 2}").setText("${MonthDebitTotal}");
    sheet.getRangeByName("E${ListCreditTotal.length + 2}").setText("${MonthSavingTotal}");

    final List<int> bytes = workbook.saveAsStream();
    workbook.dispose();

    final String path = (await getApplicationSupportDirectory()).path;
    final String fileName = "$path/Output.xlsx";
    final File file = File(fileName);
    await file.writeAsBytes(bytes, flush: true);
    OpenFile.open(fileName);

  }

}