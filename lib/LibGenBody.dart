import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:z_lib_app/API_Management.dart';
import 'package:z_lib_app/Book.dart';
import 'package:z_lib_app/ClassNames.dart';

class LibGenBody extends StatefulWidget {
  @override
  _LibGenBodyState createState() => _LibGenBodyState();
}

class _LibGenBodyState extends State<LibGenBody> {
  enterName(){
    setState(() {
      LibGen.PageNumber = 1;
      LibGen.LibGenbookList.clear();
    });
    FocusScope.of(context).unfocus();
    //String providerURL =LibGen.LibGenSearchStart+LibGen.LibGenTextController.text.trim()+LibGen.LibGenSearchEnd+LibGen.LibGenSearchPage+LibGen.PageNumber.toString();
    String bookname = LibGen.LibGenTextController.text.trim();
    print(bookname);
    API_Manager.getLibGenSearchSite(bookname, 1).then((value) => API_Manager.getLibgenBookList(value));
    // API_Manager.getSite(providetURL).then((value) => API_Manager.GetSciHubResult(value,context)).then((value) =>
    //     setState((){
    //       Utilities.SciHubAritcleList=value;
    //       print(Utilities.SciHubAritcleList.length);
    //     })
    // );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            return Text("cum");
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
