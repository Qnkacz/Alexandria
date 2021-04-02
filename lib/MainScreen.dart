import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:z_lib_app/LibGenBody.dart';
import 'package:z_lib_app/Options.dart';
import 'package:z_lib_app/SciHubBody.dart';
import 'package:z_lib_app/ZLibBody.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {

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
      child: DefaultTabController(
        length: 3,
        child: Scaffold(
          drawer: Drawer(
              child: Options()
          ),
          bottomSheet: Container(
            color: Colors.blueGrey[900],
            child: TabBar(
              indicatorColor: Color(0xFFD9B7AB),
              tabs: [
                Text("Z-lib", style: TextStyle(fontSize: 15,color: Colors.white70,fontStyle: FontStyle.italic),),
                Text("Sci-hub",style: TextStyle(fontSize: 15,color: Colors.white70,fontStyle: FontStyle.italic),),
                Text("LibGen",style: TextStyle(fontSize: 15,color: Colors.white70,fontStyle: FontStyle.italic),),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(0,0,0,20),
                child: zLibBody(),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0,0,0,20),
                child: SciHubBody(),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0,0,0,20),
                child: LibGenBody(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}