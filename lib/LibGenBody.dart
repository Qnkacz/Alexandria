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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: ListView.builder(
          itemCount: LibGen.LibGenbookList.length,
          itemBuilder: (context,index){
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
                            onEditingComplete: ()=>{},//enterDOI(),
                            textAlign: TextAlign.center,
                            controller: Utilities.SciHubTextController,
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
                    child: MaterialButton(onPressed: ()=>{},child: Icon(Icons.search))),//enterDOI(),))
              ],
            ),
          ],
        ),
      ),
    );
  }
}
