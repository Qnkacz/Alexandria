import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:z_lib_app/ClassNames.dart';

class MoreInfoClickableInfo extends StatelessWidget {
  String what;
  String s;
  MoreInfoClickableInfo(this.what,this.s);
  @override
  Widget build(BuildContext context) {
    return Center(child: GestureDetector(
      onTap: (){
        Clipboard.setData(new ClipboardData(text: s));
        GlobalWidgets.showMessageFlushBar(context, "Copied $s to cliboard");
      },
      child: Card(
          color: Colors.blueGrey[700],
          child: Padding(
            padding: const EdgeInsets.all(2.0),
            child: Text("$what: "+s,textAlign: TextAlign.center,style: TextStyle(color: Colors.white60,fontWeight: FontWeight.bold),),
          )),
    ));
  }
}

