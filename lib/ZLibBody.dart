import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:z_lib_app/API_Management.dart';
import 'package:z_lib_app/Book.dart';
import 'package:z_lib_app/ClassNames.dart';

class zLibBody extends StatefulWidget {
  TextEditingController controler;
  zLibBody({this.controler});
  @override
  _zLibBodyState createState() => _zLibBodyState();
}

ScrollController scrollController;

class _zLibBodyState extends State<zLibBody> {
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
  @override
  void initState() {
    scrollController = new ScrollController()..addListener(_loadMore);
    widget.controler.addListener(refresh);
    super.initState();
  }
  @override
  void dispose() {
    widget.controler.removeListener(refresh);
    super.dispose();
  }
  void enterBookNameWithpage(int index) {
    FocusScope.of(context).unfocus();
    ApiManager.goToSearchSite(index)
        .then((value) => ApiManager.getBookList(value))
        .then(
          (value) => setState(() {
            Utilities.bookList.addAll(value);
          }),
        )
        .then((value) => print(Utilities.bookList.length));
  }
  void refresh(){
    if(mounted)
      {
        setState(() {

        });
      }
  }
  void _loadMore() {
    if (scrollController.position.pixels ==
        scrollController.position.maxScrollExtent) {
      Utilities.pageNumber++;
      print(Utilities.pageNumber);
      enterBookNameWithpage(Utilities.pageNumber);
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(

        body: SafeArea(
          child: RawScrollbar(
            controller: scrollController,
            isAlwaysShown: true,
            radius: Radius.circular(20),
            thumbColor: Color(0xffD9B7AB).withOpacity(0.7),
            child: ListView.builder(
                controller: scrollController,
                itemCount: Utilities.bookList.length + 1,
                itemBuilder: (context, index) {
                  if (Utilities.bookList.length == 0) {
                    return Container();
                  }
                  if (index == Utilities.bookList.length) {
                    if(Utilities.bookList.length>=50){
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

                  //final item = Utilities.bookList[index];
                  return LittleBookCard(
                    bookInfo: Utilities.bookList[index],
                    publisher: () {
                      ///klikanie w wydawce
                      String bookName;
                      setState(() {
                        FocusScope.of(context).unfocus();
                        Utilities.pageNumber=1;
                        bookName = Utilities.bookList[index].publisher;
                        GlobalWidgets.showMessageFlushBar(context, "Searching for: $bookName");
                        Utilities.lastSearch = Utilities.search + bookName;
                        Utilities.lastSearch =
                            Utilities.lastSearch.replaceAll("+", " ");
                        print(Utilities.lastSearch);
                        Utilities.bookList.clear();
                      });
                      ApiManager.goToSearchSite(1)
                          .then((value) => ApiManager.getBookList(value))
                          .then((value) => setState(() {
                                Utilities.bookList = value;
                                if(value.length==0){
                                  GlobalWidgets.showErrorFlushBar(context, "Sorry, couldn't find $bookName, :(");
                                }
                              }));
                    }, ///klikanie po autorze
                    authorSearch: (String val) {
                      setState(() {
                        FocusScope.of(context).unfocus();
                        Utilities.pageNumber=1;
                        String siteUrl = Utilities.siteRoot +"/g/"+ val;
                        GlobalWidgets.showMessageFlushBar(context, "Searching for: $val");
                        Utilities.lastSearch = siteUrl;
                        Utilities.bookList.clear();
                      });
                      ApiManager.goToSearchSite(1)
                          .then((value) => ApiManager.getBookList(value))
                          .then((value) => setState(() {
                                Utilities.bookList = value;
                                if(value.length==0){
                                  GlobalWidgets.showErrorFlushBar(context, "Sorry, couldn't find $val, :(");
                                }
                              }));
                    },
                  );
                }),
          ),
        ),
    );
  }
}
