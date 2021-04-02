import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:z_lib_app/API_Management.dart';
import 'package:z_lib_app/Book.dart';
import 'package:z_lib_app/ClassNames.dart';

class LibGenBody extends StatefulWidget {
  @override
  _LibGenBodyState createState() => _LibGenBodyState();
}

class _LibGenBodyState extends State<LibGenBody> {
  ScrollController scrollController;
  enterName(){
    setState(() {
      LibGen.PageNumber = 1;
      LibGen.LibGenbookList.clear();
    });
    FocusScope.of(context).unfocus();
    String bookname = LibGen.LibGenTextController.text.trim();
    GlobalWidgets.showMessageFlushBar(context, "Searching for: $bookname");
    LibGen.lastSearch=bookname;
    API_Manager.getLibGenSearchSite(bookname, 1).then((value) => API_Manager.getLibgenBookList(value)).then((value) => setState((){
      LibGen.LibGenbookList=value;
      if(value.length==0){
        GlobalWidgets.showErrorFlushBar(context, "Sorry, we couldn't find $bookname");
      }
    }));
  }
  searchPublisher(String name){
    setState(() {
      LibGen.PageNumber = 1;
      LibGen.LibGenbookList.clear();
    });
    FocusScope.of(context).unfocus();
    String bookname = name.trim();
    GlobalWidgets.showMessageFlushBar(context, "Searching for: $bookname");
    LibGen.lastSearch=bookname;
    print(bookname);
    API_Manager.getLibGenSearchSite(bookname, 1).then((value) => API_Manager.getLibgenBookList(value)).then((value) => setState((){
      LibGen.LibGenbookList=value;
      if(value.length==0){
        GlobalWidgets.showErrorFlushBar(context, "Sorry, couldn't find $bookname, :(");
      }
    }));
  }
  @override
  void initState() {
    scrollController = new ScrollController()..addListener(_loadMore);
    super.initState();
  }
  void enterBookNameWithpage(int index) {
    FocusScope.of(context).unfocus();
    print(LibGen.lastSearch);
    API_Manager.getLibGenSearchSite(LibGen.lastSearch,index)
        .then((value) => API_Manager.getLibgenBookList(value))
        .then(
          (value) => setState(() {
        LibGen.LibGenbookList.addAll(value);
      }),
    )
        .then((value) => print(Utilities.bookList.length));
  }
  void _loadMore() {
    //todo: review and do
    if (scrollController.position.pixels ==
        scrollController.position.maxScrollExtent) {
        LibGen.PageNumber++;
         enterBookNameWithpage(LibGen.PageNumber);
    }
  }
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: ListView.builder(
          itemCount: LibGen.LibGenbookList.length,
          controller: scrollController,
          itemBuilder: (context,index){
            if (LibGen.LibGenbookList.length == 0) {
              return Container();
            }
            if (index == LibGen.LibGenbookList.length) {
              if(LibGen.LibGenbookList.length>=100){
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

            final item = LibGen.LibGenbookList[index];
            return LibGenBookCard(
              book: LibGen.LibGenbookList[index],
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
                Expanded(
                    flex: 8,
                    child: Container(
                        color: Color(0xff8c6f72),
                        child: TextField(
                            onEditingComplete: ()=>enterName(),//enterDOI(),
                            textAlign: TextAlign.center,
                            controller: LibGen.LibGenTextController,
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
