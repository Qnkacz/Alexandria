import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:z_lib_app/API_Management.dart';
import 'package:z_lib_app/Book.dart';
import 'package:z_lib_app/ClassNames.dart';

class SciHubBody extends StatefulWidget {
  TextEditingController controler;
  SciHubBody({this.controler});
  @override
  _SciHubBodyState createState() => _SciHubBodyState();
}

class _SciHubBodyState extends State<SciHubBody> {
  ScrollController scrollController;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    widget.controler.addListener(refresh);
  }
  @override
  void dispose() {
    widget.controler.removeListener(refresh);
    super.dispose();
  }
  void refresh(){
    if(mounted)
    {
      setState(() {

      });
    }
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
    );
  }
}

