import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:z_lib_app/API_Management.dart';
import 'package:z_lib_app/Book.dart';
import 'package:z_lib_app/ClassNames.dart';
import 'package:z_lib_app/ShowImage.dart';

class LibGenBody extends StatefulWidget {
  @override
  _LibGenBodyState createState() => _LibGenBodyState();
}

class _LibGenBodyState extends State<LibGenBody> {
  ScrollController scrollController;
  enterName(){
    setState(() {
      LibGen.pageNumber = 1;
      LibGen.libGenbookList.clear();
    });
    FocusScope.of(context).unfocus();
    String bookname = LibGen.libGenTextController.text.trim();
    GlobalWidgets.showMessageFlushBar(context, "Searching for: $bookname");
    LibGen.lastSearch=bookname;
    ApiManager.getLibGenSearchSite(bookname, 1).then((value) => ApiManager.getLibgenBookList(value)).then((value) => setState((){
      LibGen.libGenbookList=value;
      if(value.length==0){
        GlobalWidgets.showErrorFlushBar(context, "Sorry, we couldn't find $bookname");
      }
    })).then((value) => {
      if(LibGen.libGenbookList.length!=0){
        if(LibGen.libGenbookList.length>=100) {GlobalWidgets.showMessageFlushBar(context, "Found at least "+LibGen.libGenbookList.length.toString()+" books")}
        else{GlobalWidgets.showMessageFlushBar(context, "Found "+LibGen.libGenbookList.length.toString()+" books")}
      }
    });
  }
  searchPublisher(String name){
    setState(() {
      LibGen.pageNumber = 1;
      LibGen.libGenbookList.clear();
    });
    FocusScope.of(context).unfocus();
    String bookname = name.trim();
    GlobalWidgets.showMessageFlushBar(context, "Searching for: $bookname");
    LibGen.lastSearch=bookname;
    print(bookname);
    ApiManager.getLibGenSearchSite(bookname, 1).then((value) => ApiManager.getLibgenBookList(value)).then((value) => setState((){
      LibGen.libGenbookList=value;
      if(value.length==0){
        GlobalWidgets.showErrorFlushBar(context, "Sorry, couldn't find $bookname, :(");
      }
    })).then((value) => {
      if(LibGen.libGenbookList.length!=0){
        if(LibGen.libGenbookList.length>=100) {GlobalWidgets.showMessageFlushBar(context, "Found at least "+LibGen.libGenbookList.length.toString()+" books")}
        else{GlobalWidgets.showMessageFlushBar(context, "Found "+LibGen.libGenbookList.length.toString()+" books")}
      }
    });
  }
  @override
  void initState() {
    scrollController = new ScrollController()..addListener(_loadMore);
    super.initState();
  }
  void enterBookNameWithpage(int index) {
    FocusScope.of(context).unfocus();
    print(LibGen.lastSearch);
    ApiManager.getLibGenSearchSite(LibGen.lastSearch,index)
        .then((value) => ApiManager.getLibgenBookList(value))
        .then(
          (value) => setState(() {
        LibGen.libGenbookList.addAll(value);
      }),
    )
        .then((value) => print(Utilities.bookList.length));
  }
  void _loadMore() {
    if (scrollController.position.pixels ==
        scrollController.position.maxScrollExtent) {
        LibGen.pageNumber++;
         enterBookNameWithpage(LibGen.pageNumber);
    }
  }
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: ListView.builder(
          itemCount: LibGen.libGenbookList.length,
          controller: scrollController,
          itemBuilder: (context,index){
            if (LibGen.libGenbookList.length == 0) {
              return Container();
            }
            if (index == LibGen.libGenbookList.length) {
              if(LibGen.libGenbookList.length>=100){
                return LinearProgressIndicator(
                  backgroundColor: Colors.grey[900],
                  valueColor:
                  new AlwaysStoppedAnimation<Color>(Colors.grey),
                );
              }
              else{
                return Container();
              }
            }

            //final item = LibGen.libGenbookList[index];
            return LibGenBookCard(
              book: LibGen.libGenbookList[index],
              publisherSearch: (String val)=>searchPublisher(val),
            );
          })),
      bottomSheet: Container(
        color: Color(0xffd9b7ab),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                IconButton(
                  onPressed: (){
                    FocusScope.of(context).unfocus();
                    Scaffold.of(context).openDrawer();
                  },
                  icon: FaIcon(FontAwesomeIcons.alignLeft,color: Color(0xff273840),),
                ),
                Expanded(
                    flex: 8,
                    child: Container(
                        color: Color(0xff8c6f72),
                        child: TextField(
                            onEditingComplete: (){
                              if(LibGen.libGenTextController.text.isEmpty) GlobalWidgets.showErrorFlushBar(context, "You have to search for something");
                              else enterName();
                            },//enterDOI(),
                            textAlign: TextAlign.center,
                            controller: LibGen.libGenTextController,
                            cursorColor: Colors.white70,
                            style: TextStyle(color: Colors.white70,fontWeight: FontWeight.bold),
                            decoration: InputDecoration(
                              hintText: "Searched phrase goes here",
                              hintStyle: TextStyle(color: Colors.white70,fontStyle: FontStyle.italic),
                              border: InputBorder.none,
                            ))
                    )
                ),
                Expanded(
                    flex: 2,
                    child: MaterialButton(onPressed: ()=>enterName(),child: Icon(Icons.search))),//enterDOI(),))
              ],
            ),
          ],
        ),
      ),
    );
  }
}
