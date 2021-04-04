import 'dart:ui';

import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:share/share.dart';
import 'package:z_lib_app/API_Management.dart';
import 'package:z_lib_app/Book.dart';

class Names {
  static String box = "searchResultBox";
  static String resItemBox = "resItemBox resItemBoxBooks exactMatch";
  static String resItemTable = "resItemTable";
}

class Utilities {
  static String siteRoot = "https://1lib.pl";
  static String search = "https://1lib.pl/s/";
  static String bookRoot = "https://1lib.pl/book/";
  static String sciHubRootSite = "https://sci-hub.se/";
  static List<LittlebookInfo> bookList = [];
  static List<SciHubArticleInfo> sciHubAritcleList = [];
  static String lastSearch;
  static int pageNumber = 1;

  static List appLanguages = [
    "Eng",
    "Pol",
    "Ger",
    "Rus",
  ];
  static String lastZlibSearch="Search phrase goes here!";
  static String lastLibGenSearch="Search phrase goes here!";
  static String lastSciHubSearch="Enter URL,PMID/DOI";

  static List<String> lastSearches=[
    "",
    "",
    ""
  ];
  static List<String> hints=[
    "Search phrase goes here!",
    "Search phrase goes here!",
    "Enter URL,PMID/DOI"
  ];
}

class LibGen {
  static TextEditingController libGenTextController =
      new TextEditingController();
  static String libGenRootSite = "http://libgen.rs";
  static String libGenSearchStart = "http://libgen.rs/search.php?req=";
  static String libGenSearchEnd = "&res=100&view=detailed";
  static String libGenSearchPage = "&sortmode=ASC&page=";
  static String lastSearch;

  static List<LibGenBookInfo> libGenbookList = [];

  static int pageNumber = 1;

  static List languages = [
    "all",
    "English",
    "Polish",
    "German",
    "Russian",
    "French"
  ];
  static List extensions = [
    "all",
    "pdf",
    "mobi",
    "epub",
    "rtf",
    "doc",
    "txt",
    "rar",
  ];
}

class zLibrary {
  static List languages = [
    "all",
    "english",
    "polish",
    "german",
    "russian",
    "french"
  ];
  static List extensions = [
    "all",
    "pdf",
    "mobi",
    "epub",
    "rtf",
    "doc",
    "txt",
    "rar",
  ];
}

class GlobalWidgets {
  static void showMessageFlushBar(BuildContext context, String text) =>
      Flushbar(
        backgroundColor: Color(0xff8c6f71).withOpacity(0.6),
        borderRadius: BorderRadius.circular(0),
        barBlur: 20,
        duration: Duration(seconds: 3),
        message: "$text",
        flushbarPosition: FlushbarPosition.TOP,
      )..show(context);

  static void showErrorFlushBar(BuildContext context, String msg) => Flushbar(
        backgroundColor: Colors.redAccent,
        duration: Duration(seconds: 3),
        message: msg,
        flushbarPosition: FlushbarPosition.TOP,
      )..show(context);
}
