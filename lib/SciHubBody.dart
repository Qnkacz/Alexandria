import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: (){
        exitDialoge();
        return Future.value(false);
      },
      child: Scaffold(
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
                    onPressed: (){
                      return showDialog(
                        context: context,
                        builder: (context)=>BackdropFilter(filter: ImageFilter.blur(sigmaX: 3,sigmaY: 3),child: AlertDialog(
                          backgroundColor: Colors.blueGrey,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20),side: BorderSide(color: Color(0xffD9B7AB))),
                          title: Text("Instructions"),
                          content: Text("To use this site, you have to copy the URL, PMID or DOI link for the article you want to receive from Sci-Hub"),
                        actions: [
                          MaterialButton(onPressed: ()=>Navigator.of(context).pop(false),child: Text("OK",style: TextStyle(fontWeight: FontWeight.bold,color:Color(0xffD9B7AB),fontSize: 15))),
                          MaterialButton(onPressed: (){Navigator.of(context).pop(false);API_Manager.LaunchInBrowser("https://en.wikipedia.org/wiki/Digital_object_identifier");},child: Text("About DOI",style: TextStyle(fontWeight: FontWeight.bold,color:Color(0xffD9B7AB),fontSize: 15))),
                        ],
                        ),)
                      );
                    },
                    icon: Icon(Icons.info_outline,),
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
      ),
    );
  }
}

