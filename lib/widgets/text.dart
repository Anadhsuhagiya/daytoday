
import 'package:flutter/cupertino.dart';

class textWidget extends StatelessWidget {
  textWidget(
      {Key? key,
        required this.msg, this.txaln = TextAlign.center , this.ovrflw = TextOverflow.fade,
        required this.txtColor,
        required this.txtFontSize,
        required this.txtFontWeight})
      : super(key: key);

  final String msg;
  final Color txtColor;
  final double txtFontSize;
  final FontWeight txtFontWeight;
  final TextOverflow ovrflw;
  final TextAlign txaln;

  @override
  Widget build(BuildContext context) {
    return Text(
      msg,
      overflow: ovrflw,
      textAlign: txaln,
      style: TextStyle(color: txtColor,fontSize: txtFontSize,fontWeight: txtFontWeight,),
    );
  }
}
