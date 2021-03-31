import 'package:flutter/cupertino.dart';
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