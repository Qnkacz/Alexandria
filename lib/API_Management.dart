import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:html/parser.dart' as parser;
import 'package:html/dom.dart' as dom;
import 'package:url_launcher/url_launcher.dart';
import 'package:z_lib_app/Book.dart';
import 'package:z_lib_app/ClassNames.dart';
class API_Manager{
  static Future<dom.Document> getSite(String website) async
  {
    http.Response response = await http.get(Uri.parse(website));
    dom.Document document = parser.parse(response.body);
    return document;
  }

  static Future<dom.Document> getSearchSite(String bookName, int pageNumber) async {
    String site = Utilities.search+bookName;
    Utilities.lastSearch=site;
    http.Response response = await http.get(Uri.parse(site));
    dom.Document document = parser.parse(response.body);
    return document;
  }
  static Future<dom.Document> goToSearchSite(int pageNumber) async {
    String site = Utilities.lastSearch+"?page=$pageNumber";
    http.Response response = await http.get(Uri.parse(site));
    dom.Document document = parser.parse(response.body);
    return document;
  }
  ///Gets book list from search site, always work with getSearchSite
  static Future<dynamic> getBookList(dom.Document document) async{
    var bookListBox = document.getElementById(Names.box);
    var bookList = bookListBox.getElementsByClassName(Names.resItemBox);


    List<LittlebookInfo> bookInfoList = [];
    bookList.forEach((element) {
      var url_obj;
      var url;
      url_obj = element.getElementsByClassName("cover lazy");
      if(url_obj.length==0){
        url = element.getElementsByClassName("cover").first.attributes['src'];
      }
      else{
        url =url_obj.first.attributes['data-src'];
      }
      var name = element.getElementsByClassName(Names.resItemTable).first.children[0].children[0].children[1].children[0].children[0].children[0].children[0].children[0].text.trim();
      var bookID = element.getElementsByClassName(Names.resItemTable).first.children[0].children[0].children[1].children[0].children[0].children[0].children[0].children[0].children[0].attributes['href'];
      var authorsLenght = element.getElementsByClassName(Names.resItemTable).first.getElementsByClassName("authors").first.children.length;
      List<String> authors=[];
      List<String> authorsURL=[];
      for(int i=0;i<authorsLenght;i++){
       authors.add(element.getElementsByClassName(Names.resItemTable).first.getElementsByClassName("authors").first.children[i].text);
       authorsURL.add(element.getElementsByClassName(Names.resItemTable).first.getElementsByClassName("authors").first.children[i].attributes['href'].trim());
      }
      var year="not given";
      if(element.getElementsByClassName(Names.resItemTable).first.getElementsByClassName("bookProperty property_year").isNotEmpty){
        year = element.getElementsByClassName(Names.resItemTable).first.getElementsByClassName("bookProperty property_year").first.children[1].text;
      }
      var language="not given";
      if(element.getElementsByClassName(Names.resItemTable).first.getElementsByClassName("bookProperty property_language").isNotEmpty)
        {
          language = element.getElementsByClassName(Names.resItemTable).first.getElementsByClassName("bookProperty property_language").first.children[1].text;
        }
      var file = element.getElementsByClassName(Names.resItemTable).first.getElementsByClassName("bookProperty property__file").first.children[1].text;

      var publisher=element.querySelector('div[title="Publisher"]');
      var publisherText="not given";
      var publisherURL="not given";
      if(publisher!=null){
        publisherText=publisher.text;
        publisherURL=publisher.firstChild.attributes['href'];
      }



      LittlebookInfo littlebookInfo = new LittlebookInfo(
        title: name,
        imageUrl: url,
        authors: authors,
        year: year,
        leanguage: language,
        file: file,
        bookID: bookID,
        publisher: publisherText,
        publisherURL: publisherURL,
        authorsURL: authorsURL
      );
      bookInfoList.add(littlebookInfo);
    });
    return bookInfoList;
  }

  ///gets the website with the specific book id
  static Future<dom.Document> getBookSiteFromId(String bookID) async {
    String url = Utilities.siteRoot+bookID;
    http.Response response = await http.get(Uri.parse(url));
    dom.Document document = parser.parse(response.body);
    return document;
  }
  static Future<void> LaunchInBrowser(String url) async {
    if (await canLaunch(url)) {
      await launch(
        url,
        forceSafariVC: false,
        forceWebView: false,
        headers: <String, String>{'my_header_key': 'my_header_value'},
      );
    } else {
      throw 'Could not launch $url';
    }
  }
  static Future<dynamic> GetSciHubResult(dom.Document document,dynamic context) async{
    String share;
    String dlLink;
    List<SciHubArticleInfo> list =[];
    var s = document.getElementById("link");
    var shareObj;
    var dlobj;
    if(s==null){
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
          duration: Duration(milliseconds: 1000),
            content: Text("couldn't find anything :("),
          backgroundColor: Colors.redAccent,
          behavior: SnackBarBehavior.floating,
        )
      );
    }
    else{
      shareObj=s.children[1].attributes['href'];
      dlobj=document.getElementById("buttons").children[0].children[0].children[0].attributes['onclick'].replaceAll("?download=true", "").trim().replaceAll("location.href='//", "").replaceAll("'", "").trim();
      list.add(SciHubArticleInfo(shareURL: shareObj,downloadURL: dlobj));
      return list;
    }
    return list;
  }

  static Future<dom.Document> getLibGenSearchSite(String bookName, int pageNumber) async {
    String site = LibGen.LibGenSearchStart+bookName+LibGen.LibGenSearchEnd+LibGen.LibGenSearchPage+LibGen.PageNumber.toString();
    print(site);
    LibGen.lastSearch=site;
    http.Response response = await http.get(Uri.parse(site));
    dom.Document document = parser.parse(response.body);
    return document;
  }

  static Future<dynamic> getLibgenBookList(dom.Document document)async{
    List<LibGenBookInfo> bookInfoList = [];


    List<dom.Element> allThings = document.querySelectorAll('[rules="cols"][width="100%"][border="0"]');
    print(allThings.length);
    List<dom.Element> bookObjs = [];
    for(int i=0;i<allThings.length;i+=2){
      bookObjs.add(allThings[i]);
    }
    print(bookObjs.length);
    bookObjs.forEach((element) {
      List<dom.Element> content = element.querySelectorAll('[valign="top"]');
      content.removeAt(0);

    });

  }
  static Future<dynamic> GetLibGenResult(dom.Document document,dynamic context) async{

  }

}