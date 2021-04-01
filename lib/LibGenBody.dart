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
    print(bookname);
    API_Manager.getLibGenSearchSite(bookname, 1).then((value) => API_Manager.getLibgenBookList(value)).then((value) => setState((){
      LibGen.LibGenbookList=value;
      print(LibGen.LibGenbookList.length);
    }));
  }
  searchPublisher(String name){
    setState(() {
      LibGen.PageNumber = 1;
      LibGen.LibGenbookList.clear();
    });
    FocusScope.of(context).unfocus();
    String bookname = name.trim();
    print(bookname);
    API_Manager.getLibGenSearchSite(bookname, 1).then((value) => API_Manager.getLibgenBookList(value)).then((value) => setState((){
      LibGen.LibGenbookList=value;
      print(LibGen.LibGenbookList.length);
    }));
  }
  @override
  Future<bool> exitDialoge() {
    return showDialog(
        context: context,
        builder: (context)=>BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 3,sigmaY: 3),
          child: new AlertDialog(
            backgroundColor: Colors.blueGrey,
            elevation: 0,
            title: Text("You sure?"),
            content: Text("You really wanna leave so soon?"),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20),side: BorderSide(color: Color(0xffD9B7AB))),
            actions: [
              MaterialButton(onPressed: (){
                SystemNavigator.pop();
              },
                child: Text("EXIT",style: TextStyle(color: Color(0xffD9B7AB)),),
              ),
              MaterialButton(onPressed: (){
                Navigator.of(context).pop(false);
              },
                child: Text("CANCEL",style: TextStyle(color: Color(0xffD9B7AB))),
              ),
            ],
          ),
        )
    );
  }
  void initState() {
    scrollController = new ScrollController()..addListener(_loadMore);
    super.initState();
  }
  void _loadMore() {
    //todo: review and do
    // if (scrollController.position.pixels ==
    //     scrollController.position.maxScrollExtent) {
    //   Utilities.PageNumber++;
    //   print(Utilities.PageNumber);
    //   enterBookNameWithpage(Utilities.PageNumber);
    // }
  }
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: (){
        exitDialoge();
        return Future.value(false);
      },
      child: Scaffold(
        body: SafeArea(child: ListView.builder(
            itemCount: LibGen.LibGenbookList.length,
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
      ),
    );
  }
}
