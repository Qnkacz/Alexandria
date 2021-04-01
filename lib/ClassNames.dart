import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:z_lib_app/Book.dart';

class Names{
  static String box = "searchResultBox";
  static String resItemBox = "resItemBox resItemBoxBooks exactMatch";
  static String resItemTable = "resItemTable";
}
class Utilities{
  static String siteRoot= "https://1lib.pl";
  static String search = "https://1lib.pl/s/";
  static String bookRoot = "https://1lib.pl/book/";
  static String SciHubRootSite = "https://sci-hub.se/";
  static TextEditingController textEditingController =new TextEditingController();
  static TextEditingController SciHubTextController = new TextEditingController();
  static List<LittlebookInfo> bookList = [];
  static List<SciHubArticleInfo> SciHubAritcleList=[];
  static String lastSearch;
  static int PageNumber=1;
}
class LibGen{
  static TextEditingController LibGenTextController = new TextEditingController();
  static String LibGenRootSite = "http://libgen.rs";
  static String LibGenSearchStart = "http://libgen.rs/search.php?req=";
  static String LibGenSearchEnd = "&res=100&view=detailed";
  static String LibGenSearchPage = "&sortmode=ASC&page=";
  static String lastSearch;

  static List<LibGenBookInfo> LibGenbookList =[];

  static int PageNumber=1;
}
class GlobalWidgets{
  static void showMessageFlushBar(BuildContext context,String text)=>Flushbar(
    backgroundColor: Color(0xff8c6f71).withOpacity(0.6),
    borderRadius: BorderRadius.circular(0),
    barBlur: 20,
    duration: Duration(seconds: 3),
    message: "$text",
    flushbarPosition: FlushbarPosition.TOP,
  )..show(context);

  static void showErrorFlushBar(BuildContext context, String msg)=>Flushbar(
    backgroundColor: Colors.redAccent,
    duration: Duration(seconds: 3),
    message: msg,
    flushbarPosition: FlushbarPosition.TOP,
  )..show(context);
}