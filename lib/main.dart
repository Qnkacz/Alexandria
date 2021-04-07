import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:z_lib_app/MainScreen.dart';
import 'package:z_lib_app/MyThemes.dart';

void main() async => {

  if(Platform.isAndroid){
    WidgetsFlutterBinding.ensureInitialized(),
    await FlutterDownloader.initialize(
        debug: true // optional: set false to disable printing logs to console
    ),
    runApp(MaterialApp(
        themeMode: ThemeMode.system,
        theme: MyThemes.darkTheme,
        darkTheme: MyThemes.darkTheme,
        home: MainScreen()
    ))
  }
  else if(Platform.isLinux || Platform.isWindows || Platform.isMacOS){
    runApp(MaterialApp(
        themeMode: ThemeMode.system,
        theme: MyThemes.darkTheme,
        darkTheme: MyThemes.darkTheme,
        home: MainScreen()
    ))
  }

    };


