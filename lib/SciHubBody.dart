import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
      Utilities.PageNumber = 1;
      Utilities.SciHubAritcleList.clear();
    });
    FocusScope.of(context).unfocus();
    String providetURL =Utilities.SciHubRootSite+Utilities.SciHubTextController.text.trim();
    API_Manager.getSite(providetURL).then((value) => API_Manager.GetSciHubResult(value,context)).then((value) =>
    setState((){
      Utilities.SciHubAritcleList=value;
      print(Utilities.SciHubAritcleList.length);
    })
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: ListView.builder(
              itemCount: Utilities.SciHubAritcleList.length,
              itemBuilder: (context,index){
                final item = Utilities.SciHubAritcleList[index];
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
                  onPressed: ()=> Scaffold.of(context).openDrawer(),
                  icon: FaIcon(FontAwesomeIcons.alignLeft,color: Color(0xff273840),),
                ),
                Expanded(
                    flex: 8,
                    child: Container(
                    color: Color(0xff8c6f72),
                    child: TextField(
                      onEditingComplete: ()=>enterDOI(),
                        textAlign: TextAlign.center,
                        controller: Utilities.SciHubTextController,
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
                    child: MaterialButton(onPressed: ()=>enterDOI(),child: Icon(Icons.search),))
              ],
            ),
          ],
        ),
      ),
    );
  }
}

