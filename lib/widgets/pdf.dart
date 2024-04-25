
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:syncfusion_flutter_pdf/pdf.dart';
import 'package:flutter/material.dart';



class pdfGenerate{

  final pdf = pw.Document();

  Future<void> pdfGen() async {
    pdf.addPage(pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          return pw.Center(
            child: pw.Column(
                mainAxisAlignment: pw.MainAxisAlignment.start,
                children: [
                  pw.Container(
                      height: 200,
                      width: 180,
                      margin: pw.EdgeInsets.all(30),
                      decoration: pw.BoxDecoration(
                          borderRadius: pw.BorderRadius.circular(10),
                          border: pw.Border.all(color: PdfColors.black,width: 3)
                      ),
                      child: pw.Text("24 x 7\nSurat.",style: pw.TextStyle(color: PdfColors.black,fontSize: 16))
                  )
                ]
            ),
          ); // Center
        }));

    final output = await getTemporaryDirectory();
    final file = File('${output.path}/invoice.pdf');
    await file.writeAsBytes(await pdf.save());

  }

}