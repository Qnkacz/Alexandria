import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:z_lib_app/API_Management.dart';
import 'package:z_lib_app/LibGenBody.dart';
import 'package:z_lib_app/Options.dart';
import 'package:z_lib_app/SciHubBody.dart';
import 'package:z_lib_app/ZLibBody.dart';

import 'ClassNames.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen>with SingleTickerProviderStateMixin {

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final GlobalKey _textfieldkey= new GlobalKey();
  TextEditingController mainTextEditingController;
  TabController tabController;
  List<Widget> screens = [

  ];
  enterBookNameZLib(){
    setState(() {
      Utilities.pageNumber = 1;
      Utilities.bookList.clear();
    });
    FocusScope.of(context).unfocus();
    String bookName = mainTextEditingController.text;
    GlobalWidgets.showMessageFlushBar(context, "Searching for: $bookName");
    ApiManager.getSearchSite(bookName, 1)
        .then((value) => ApiManager.getBookList(value))
        .then(
          (value) => setState(() {
        Utilities.bookList = value;
        if(Utilities.bookList.length==0){
          GlobalWidgets.showErrorFlushBar(context, "Sorry, couldn't find $bookName, :(");
        }
        else{
          mainTextEditingController.notifyListeners();
          Utilities.lastZlibSearch=mainTextEditingController.text;
          if(Utilities.bookList.length>=50){
            GlobalWidgets.showMessageFlushBar(context, "Found at least "+Utilities.bookList.length.toString()+" books");
          }
          else{
            GlobalWidgets.showMessageFlushBar(context, "Found "+Utilities.bookList.length.toString()+" books");
          }
        }
      }),
    );
  }
  enterBookNameLibGen(){
    setState(() {
      LibGen.pageNumber = 1;
      LibGen.libGenbookList.clear();
    });
    FocusScope.of(context).unfocus();
    String bookname = mainTextEditingController.text.trim();
    GlobalWidgets.showMessageFlushBar(context, "Searching for: $bookname");
    LibGen.lastSearch=bookname;
    ApiManager.getLibGenSearchSite(bookname, 1).then((value) => ApiManager.getLibgenBookList(value)).then((value) => setState((){
      LibGen.libGenbookList=value;
      if(value.length==0){
        GlobalWidgets.showErrorFlushBar(context, "Sorry, we couldn't find $bookname");
      }
    })).then((value) {
      if(LibGen.libGenbookList.length!=0){
        mainTextEditingController.notifyListeners();
        Utilities.lastLibGenSearch=mainTextEditingController.text;
        if(LibGen.libGenbookList.length>=100) {GlobalWidgets.showMessageFlushBar(context, "Found at least "+LibGen.libGenbookList.length.toString()+" books");}
        else{GlobalWidgets.showMessageFlushBar(context, "Found "+LibGen.libGenbookList.length.toString()+" books");}
      }
    });
  }
  enterDOI(){
    setState(() {
      Utilities.pageNumber = 1;
      Utilities.sciHubAritcleList.clear();
    });
    FocusScope.of(context).unfocus();
    String providetURL =Utilities.sciHubRootSite+mainTextEditingController.text.trim();
    print(providetURL);
    ApiManager.getSite(providetURL).then((value) => ApiManager.GetSciHubResult(value,context)).then((value) =>
        setState((){
          Utilities.sciHubAritcleList=value;
          print(Utilities.sciHubAritcleList.length);
          mainTextEditingController.notifyListeners();
          Utilities.lastSciHubSearch=mainTextEditingController.text;
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
  void initState(){
    super.initState();
    tabController=new TabController(length: 3, vsync: this);

    mainTextEditingController = new TextEditingController();
    tabController.addListener(() {
      setState(() {
        mainTextEditingController.text = Utilities.lastSearches[tabController.index];
      });
    });
    screens.add(zLibBody(controler: mainTextEditingController));
    screens.add(LibGenBody(controler: mainTextEditingController));
    screens.add(SciHubBody(controler: mainTextEditingController));
  }
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: (){
        exitDialoge();
        return Future.value(false);
      },
      child: DefaultTabController(
        length: 3,
        child: Scaffold(
          key: _scaffoldKey,
          drawer: Drawer(
            elevation: 0,
              child: Options()
          ),
          bottomSheet: Container(
            color: Colors.blueGrey[900],
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                    color: Color(0xffd9b7ab),
                    child:
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Row(
                          children: [
                            IconButton(
                              onPressed: (){
                                FocusScope.of(context).unfocus();
                                _scaffoldKey.currentState.openDrawer();
                              },
                              icon: FaIcon(FontAwesomeIcons.alignLeft,color: Color(0xff273840),),
                            ),
                            Expanded(
                                flex: 8,
                                child: Container(
                                  color: Color(0xff8c6f72),
                                  child: TextField(
                                    key: _textfieldkey,
                                    onEditingComplete: (){
                                      if(tabController.index==0){
                                        enterBookNameZLib();
                                        Utilities.lastSearches[0] = mainTextEditingController.text;
                                      }if(tabController.index==1){
                                        enterBookNameLibGen();
                                        Utilities.lastSearches[1] = mainTextEditingController.text;
                                      }if(tabController.index==2){
                                        enterDOI();
                                        Utilities.lastSearches[2] = mainTextEditingController.text;
                                      }
                                    }, //text
                                    textAlign: TextAlign.center,
                                    controller: mainTextEditingController,
                                    cursorColor: Colors.white70,
                                    style: TextStyle(color: Colors.white70,fontWeight: FontWeight.bold),
                                    decoration: InputDecoration(
                                      hintText: Utilities.hints[tabController.index],
                                      hintStyle: TextStyle(color: Colors.white70),
                                      border: InputBorder.none,
                                    ),
                                  ),
                                )),
                            Expanded(
                                flex: 2,
                                child: MaterialButton(
                                    onPressed: (){
                                      if(tabController.index==0){
                                        enterBookNameZLib();
                                      }if(tabController.index==1){
                                        enterBookNameLibGen();
                                      }if(tabController.index==2){
                                        enterDOI();
                                      }
                                    },
                                    child: Icon(
                                        Icons.search,
                                        color: Color(0xff263740)
                                    )))
                          ],
                        )
                      ],
                    )
                ),
                TabBar(
                  controller: tabController,
                  indicatorColor: Color(0xFFD9B7AB),
                  tabs: [
                    Container(
                      height: 40,
                        child: Center(child: Text("Z-lib", style: TextStyle(fontSize: 15,color: Colors.white70,fontStyle: FontStyle.italic),))),
                    Text("LibGen",style: TextStyle(fontSize: 15,color: Colors.white70,fontStyle: FontStyle.italic),),
                    Text("Sci-hub",style: TextStyle(fontSize: 15,color: Colors.white70,fontStyle: FontStyle.italic),),
                  ],
                ),
              ],
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.fromLTRB(0,0,0,90),
            child: TabBarView(
              controller:tabController,
              children: [
                screens[0],
                screens[1],
                screens[2],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
