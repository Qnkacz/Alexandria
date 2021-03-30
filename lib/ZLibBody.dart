import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:z_lib_app/API_Management.dart';
import 'package:z_lib_app/Book.dart';
import 'package:z_lib_app/ClassNames.dart';

class zLibBody extends StatefulWidget {
  @override
  _zLibBodyState createState() => _zLibBodyState();
}

ScrollController scrollController;

class _zLibBodyState extends State<zLibBody> {
  @override
  void initState() {
    scrollController = new ScrollController()..addListener(_loadMore);
    super.initState();
  }

  void enterBookName() {
    setState(() {
      Utilities.PageNumber = 1;
      Utilities.bookList.clear();
    });
    FocusScope.of(context).unfocus();
    String bookName = Utilities.textEditingController.text;
    API_Manager.getSearchSite(bookName, 1)
        .then((value) => API_Manager.getBookList(value))
        .then(
          (value) => setState(() {
            Utilities.bookList = value;
          }),
        )
        .then((value) => print(Utilities.bookList.length));
  }

  void enterBookNameWithpage(int index) {
    FocusScope.of(context).unfocus();
    API_Manager.goToSearchSite(index)
        .then((value) => API_Manager.getBookList(value))
        .then(
          (value) => setState(() {
            Utilities.bookList.addAll(value);
          }),
        )
        .then((value) => print(Utilities.bookList.length));
  }

  void _loadMore() {
    if (scrollController.position.pixels ==
        scrollController.position.maxScrollExtent) {
      Utilities.PageNumber++;
      print(Utilities.PageNumber);
      enterBookNameWithpage(Utilities.PageNumber);
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(

        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 0, 50),
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

                  final item = Utilities.bookList[index];
                  return LittleBookCard(
                    bookInfo: Utilities.bookList[index],
                    publisher: () {
                      //klikanie w wydawce
                      String bookName;
                      setState(() {
                        Utilities.PageNumber=1;
                        bookName = Utilities.bookList[index].publisher;
                        Utilities.lastSearch = Utilities.search + bookName;
                        Utilities.lastSearch =
                            Utilities.lastSearch.replaceAll("+", " ");
                        //print(Utilities.lastSearch);
                        Utilities.bookList.clear();
                      });
                      API_Manager.goToSearchSite(1)
                          .then((value) => API_Manager.getBookList(value))
                          .then((value) => setState(() {
                                Utilities.bookList = value;
                              }));
                    }, //klikanie po autorze
                    authorSearch: (String val) {
                      setState(() {

                        Utilities.PageNumber=1;
                        String siteUrl = Utilities.siteRoot + val;
                        Utilities.lastSearch = siteUrl;
                        Utilities.bookList.clear();
                      });
                      API_Manager.goToSearchSite(1)
                          .then((value) => API_Manager.getBookList(value))
                          .then((value) => setState(() {
                                Utilities.bookList = value;
                              }));
                    },
                  );
                }),
          ),
        ),
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
                            onEditingComplete: () => enterBookName(), //text
                            textAlign: TextAlign.center,
                            controller: Utilities.textEditingController,
                            cursorColor: Colors.white70,
                            style: TextStyle(color: Colors.white70,fontWeight: FontWeight.bold),
                            decoration: InputDecoration(
                              hintText: "Book name goes here!",
                              hintStyle: TextStyle(color: Colors.white70),
                              border: InputBorder.none,
                            ),
                          ),
                        )),
                    Expanded(
                        flex: 2,
                        child: MaterialButton(
                            onPressed: ()=>enterBookName(),
                            child: Icon(
                              Icons.search,
                              color: Color(0xff263740)
                            )))
                  ],
                )
              ],
            )));
  }
}
