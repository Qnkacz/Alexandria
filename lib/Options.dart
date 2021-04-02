import 'package:flutter/material.dart';

class Options extends StatefulWidget {
  @override
  _OptionsState createState() => _OptionsState();
}

class _OptionsState extends State<Options> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        color: Color(0xff8C6F71),
        child: Column(  
          children: [
            Text("Z lib options"),
            Text("LibGen options"),
          ],
        ),
      ),
    );
  }
}
