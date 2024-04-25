import 'dart:io';

var h, w;

String ApiKey = "6de7f39d3eaa41549ec84e44a020a4d0";
String ApiString = "https://newsapi.org/v2/top-headlines?country=in&category=health&apiKey=$ApiKey";

String DoctorPhotoUrl = "https://flutteranadh.000webhostapp.com/Hospital/";

String id = "";
String img = "";
String name = "";
String profession = "";
String purpose = "";
String contact = "";
String email = "";
String additional = "";

bool face = false;

List cat = [];

File? pdfFile;

int colorCode = 0;