import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:z_lib_app/LibGenBody.dart';
import 'package:z_lib_app/MyThemes.dart';
import 'package:z_lib_app/SciHubBody.dart';
import 'ZLibBody.dart';

void main() async => {

      WidgetsFlutterBinding.ensureInitialized(),
      await FlutterDownloader.initialize(
          debug: true // optional: set false to disable printing logs to console
          ),
      runApp(MaterialApp(
        themeMode: ThemeMode.system,
        theme: MyThemes.darkTheme,
        darkTheme: MyThemes.darkTheme,
        home: DefaultTabController(
          length: 3,
          child: Scaffold(
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
        )
      ))
    };


