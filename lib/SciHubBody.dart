import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:z_lib_app/API_Management.dart';
import 'package:z_lib_app/Book.dart';
import 'package:z_lib_app/ClassNames.dart';

class SciHubBody extends StatefulWidget {
  @override
  _SciHubBodyState createState() => _SciHubBodyState();
}

class _SciHubBodyState extends State<SciHubBody> {
  ScrollController scrollController;
  enterDOI(){
    setState(() {
      Utilities.pageNumber = 1;
      Utilities.sciHubAritcleList.clear();
    });
    FocusScope.of(context).unfocus();
    String providetURL =Utilities.sciHubRootSite+Utilities.sciHubTextController.text.trim();
    ApiManager.getSite(providetURL).then((value) => ApiManager.GetSciHubResult(value,context)).then((value) =>
    setState((){
      Utilities.sciHubAritcleList=value;
      print(Utilities.sciHubAritcleList.length);
    })
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: ListView.builder(
              itemCount: Utilities.sciHubAritcleList.length,
              itemBuilder: (context,index){
                final item = Utilities.sciHubAritcleList[index];
                return SciHubArticle(articleInfo: item);
          })
      ),
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
                      onEditingComplete: () {
                        if(Utilities.sciHubTextController.text.isEmpty) GlobalWidgets.showErrorFlushBar(context, "You have to search for something");
                        else enterDOI();
                      },
                        textAlign: TextAlign.center,
                        controller: Utilities.sciHubTextController,
                        cursorColor: Colors.white70,
                        style: TextStyle(color: Colors.white70,fontWeight: FontWeight.bold),
                        decoration: InputDecoration(
                        hintText: "enter URL, PMID / DOI",
                        hintStyle: TextStyle(color: Colors.white70,fontStyle: FontStyle.italic),
                        border: InputBorder.none,
                        ))
                        )
                        ),
                        Expanded(
                        flex: 2,
                        child: MaterialButton(onPressed: ()=>enterDOI(),child: Icon(
                      Icons.search),))
              ],
            ),
          ],
        ),
      ),
    );
  }
}

