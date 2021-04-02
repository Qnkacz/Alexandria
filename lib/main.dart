import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:z_lib_app/MainScreen.dart';
import 'package:z_lib_app/MyThemes.dart';

void main() async => {

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
    };


