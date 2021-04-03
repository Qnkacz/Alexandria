import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:z_lib_app/API_Management.dart';
import 'package:z_lib_app/ClassNames.dart';

class Options extends StatefulWidget {
  @override
  _OptionsState createState() => _OptionsState();
}

class _OptionsState extends State<Options> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  void zLibRemoveLanguage(String language){
    setState(() {
      Utilities.bookList.removeWhere((element) => (element.leanguage!=language));
    });
    if(language!=null) GlobalWidgets.showMessageFlushBar(context, "Showing only $language books");
    else GlobalWidgets.showMessageFlushBar(context, "Reseted the language filter");
  }
  void zLibRemoveExtensiion(String extension){
    setState(() {
      Utilities.bookList.removeWhere((element) => (!element.file.contains(extension.toUpperCase())));
    });
    if(extension!=null)GlobalWidgets.showMessageFlushBar(context, "Showing only $extension books");
    else GlobalWidgets.showMessageFlushBar(context, "Reseted the extension filter");
  }
  void zLibRemoveBookBelowYear(String year){
    if(SavedOptions.zlibYearFrom.isEmpty || SavedOptions.zlibYearFrom=="year"){
      GlobalWidgets.showMessageFlushBar(context, "Reseted year from filter");
    }
    else{
      setState(() {
        Utilities.bookList.removeWhere((element) => element.year=="not given" || int.parse(element.year) <int.parse(year));
      });
      GlobalWidgets.showMessageFlushBar(context, "Showing only books from $year and younger");
    }

  }
  void zLibRemoveBookAboveYear(String year){
    if(SavedOptions.zlibYearTo.isEmpty || SavedOptions.zlibYearTo=="year"){
      GlobalWidgets.showMessageFlushBar(context, "Reseted year from filter");
    }
    else{
      setState(() {
        Utilities.bookList.removeWhere((element) => int.parse(element.year) >int.parse(year));
      });
      GlobalWidgets.showMessageFlushBar(context, "Showing only books till $year and older");
    }

  }

  //todo: review this functions
  void LibGenRemoveLanguage(String language){
    setState(() {
      LibGen.LibGenbookList.removeWhere((element) => (element.language!=language));
    });
    if(language!=null) GlobalWidgets.showMessageFlushBar(context, "Showing only $language books");
    else GlobalWidgets.showMessageFlushBar(context, "Reseted the language filter");
  }
  void LibGenRemoveExtensiion(String extension){
    setState(() {
      LibGen.LibGenbookList.removeWhere((element) => (element.extention != extension));
    });
    if(extension!=null)GlobalWidgets.showMessageFlushBar(context, "Showing only $extension books");
    else GlobalWidgets.showMessageFlushBar(context, "Reseted the extension filter");
  }
  void LibGenRemoveBookBelowYear(String year){
    if(SavedOptions.zlibYearFrom.isEmpty || SavedOptions.zlibYearFrom=="year"){
      GlobalWidgets.showMessageFlushBar(context, "Reseted year from filter");
    }
    else{
      setState(() {
        LibGen.LibGenbookList.removeWhere((element) => element.year=="not given" || int.parse(element.year) <int.parse(year));
      });
      GlobalWidgets.showMessageFlushBar(context, "Showing only books from $year and younger");
    }

  }
  void LibGenRemoveBookAboveYear(String year){
    if(SavedOptions.zlibYearTo.isEmpty || SavedOptions.zlibYearTo=="year"){
      GlobalWidgets.showMessageFlushBar(context, "Reseted year from filter");
    }
    else{
      setState(() {
        LibGen.LibGenbookList.removeWhere((element) => int.parse(element.year) >int.parse(year));
      });
      GlobalWidgets.showMessageFlushBar(context, "Showing only books till $year and older");
    }

  }


  TextEditingController zLibYearFromController = new TextEditingController();
  TextEditingController zLibYearToController = new TextEditingController();
  TextEditingController libGenYearFromController = new TextEditingController();
  TextEditingController libGenYearToController = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        color: Color(0xff8C6F71),
        child: Theme(
          data: ThemeData(
              dividerColor: Colors.transparent,
              accentColor: Color(0xffD9B7AB),
              cardColor: Color(0xffD9B7AB),
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                ///header
                Container(
                  padding: EdgeInsets.zero,
                  color: Color(0xffE8E8E8),
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(10,0,0,0),
                        child: Container(
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage('assets/A_test.png'),
                                    fit: BoxFit.fill))),
                      ),
                      Spacer(),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 0, 13, 0),
                        child: Text(
                          "Alexandria",
                          textAlign: TextAlign.center,
                          style: GoogleFonts.sofia(
                            textStyle: TextStyle(fontSize: 30)
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                ///info o mnie
                Container(
                  padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                  color: Color(0xff8C6F71),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Container(
                              width: 50,
                              height: 50,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                  image: DecorationImage(
                                      image: AssetImage('assets/glowa.png'),
                                      fit: BoxFit.fill))),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(8.0, 0, 8, 0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Created by:"),
                                Divider(),
                                Text("Bartosz Wąsik",style: GoogleFonts.inconsolata(
                                  textStyle: TextStyle(fontWeight: FontWeight.bold)
                                ),)
                              ],
                            ),
                          ),
                          Spacer(),
                          GestureDetector(
                            onTap: () {
                              Clipboard.setData(new ClipboardData(
                                  text: "wasik.bartosz@outlook.com"));
                              GlobalWidgets.showMessageFlushBar(
                                  context, "Copied contact mail to cliboard");
                            },
                            child: Container(
                              child: Card(
                                elevation: 0,
                                child: Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: Text("Mail"),
                                ),
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              API_Manager.LaunchInBrowser(
                                  "https://github.com/Qnkacz");
                            },
                            child: Container(
                              child: Card(
                                elevation: 0,
                                child: Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: Text("GitHub"),
                                ),
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                ///donejty
                ExpansionTile(
                  trailing: Icon(Icons.money),
                  title: Text(
                    "Donations",
                    style: TextStyle(color: Colors.black87),
                  ),
                  expandedCrossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    GestureDetector(
                      onTap: (){
                        GlobalWidgets.showMessageFlushBar(context, "Copied PayPal address");
                      },
                      child: Card(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              FaIcon(
                                FontAwesomeIcons.paypal,
                                color: Colors.black87,
                              ),
                              Text(
                                "PayPal",
                                textAlign: TextAlign.center,
                              ),
                              FaIcon(
                                FontAwesomeIcons.paypal,
                                color: Colors.black87,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: (){
                        Clipboard.setData(new ClipboardData(text: "47U3sbXxJqZhPR4q69S61QfWWgm7YHhZN3hGAv2TDHPFXg384Xr56E4VQ9uJfsUmQ6cNx17tDdQ2p4CVEz7mZJ1qQRuD6Zq"));
                        GlobalWidgets.showMessageFlushBar(context, "Copied monero address to clipboard");
                        },
                      child: Card(
                        child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                FaIcon(
                                  FontAwesomeIcons.monero,
                                  color: Colors.black87,
                                ),
                                Text(
                                  "Monero",
                                  textAlign: TextAlign.center,
                                ),
                                FaIcon(
                                  FontAwesomeIcons.monero,
                                  color: Colors.black87,
                                ),
                              ],
                            )),
                      ),
                    ),
                  ],
                ),
                ///strony
                ExpansionTile(
                  title: Text("Visit the websites manualy",
                      style: TextStyle(color: Colors.black87)),
                  trailing: Icon(Icons.web),
                  children: [
                    GestureDetector(
                      onTap: () =>
                          API_Manager.LaunchInBrowser("https://z-lib.org/"),
                      child: Card(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(
                                "Z-library",
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () =>
                          API_Manager.LaunchInBrowser("https://sci-hub.se/"),
                      child: Card(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(
                                "Sci-hub",
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () =>
                          API_Manager.LaunchInBrowser("http://libgen.rs/"),
                      child: Card(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(
                                "Liblary genesis",
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                ///opcje
                ExpansionTile(
                  title: Text(
                    "Options",
                    style: TextStyle(color: Colors.black87),
                  ),
                  trailing: FaIcon(FontAwesomeIcons.cog),
                  children: [
                    ///app language
                    Padding(
                      padding: const EdgeInsets.fromLTRB(25,0,25,0),
                      child: Row(
                        children: [
                          Text("App language"),
                          Spacer(),
                          DropdownButton(
                              dropdownColor: Color(0xffD9B7AB),
                              icon: Icon(Icons.language,color: Colors.black54,),
                              hint: Text("language"),
                              value: SavedOptions.appLanguage,
                              onChanged: (value) {
                                setState(() {
                                  SavedOptions.appLanguage = value;
                                });
                              },
                              items: Utilities.appLanguages.map((e) {
                                return DropdownMenuItem(
                                  value: e,
                                  child: Text(e),
                                );
                              }).toList())
                        ],
                      ),
                    ),
                    /// Z liblary options
                    Padding(
                      padding: const EdgeInsets.fromLTRB(10,0,10,0),
                      child: ExpansionTile(title: Text("Z-library"),
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(30.0,0,30,0),
                            child: Row(
                              children: [
                                Text("Language: "),
                                Spacer(),
                                DropdownButton(
                                    dropdownColor: Color(0xffD9B7AB),
                                    icon: Icon(Icons.language,color: Colors.black54,),
                                    hint: Text("lang"),
                                    value: SavedOptions.zLibchosenLanguage,
                                    onChanged: (value) {
                                      setState(() {
                                        SavedOptions.zLibchosenLanguage = value;
                                        if(SavedOptions.zLibchosenLanguage=="all"){
                                          SavedOptions.zLibchosenLanguage=null;
                                        }
                                        zLibRemoveLanguage(SavedOptions.zLibchosenLanguage);
                                      });
                                    },
                                    items: zLibrary.languages.map((e) {
                                      return DropdownMenuItem(
                                        value: e,
                                        child: Text(e),
                                      );
                                    }).toList())
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(30.0,0,30,0),
                            child: Row(
                              children: [
                                Text("Extension: "),
                                Spacer(),
                                DropdownButton(
                                    dropdownColor: Color(0xffD9B7AB),
                                    icon: Icon(Icons.extension_outlined,color: Colors.black54,),
                                    hint: Text("ext"),
                                    value: SavedOptions.zLibchosenExt,
                                    onChanged: (value) {
                                      setState(() {
                                        SavedOptions.zLibchosenExt = value;
                                        if(SavedOptions.zLibchosenExt=="all"){
                                          SavedOptions.zLibchosenExt=null;
                                        }
                                        zLibRemoveExtensiion(SavedOptions.zLibchosenExt);
                                      });
                                    },
                                    items: zLibrary.extensions.map((e) {
                                      return DropdownMenuItem(
                                        value: e,
                                        child: Text(e),
                                      );
                                    }).toList())
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(30.0,0,30,0),
                            child: Row(
                              children: [
                                Text("Year from: "),
                                Spacer(),
                                SizedBox(
                                    width: 40,
                                    height: 30,
                                    child: TextField(
                                      onEditingComplete: (){
                                        if(zLibYearFromController.text==null || zLibYearFromController.text.isEmpty){
                                          SavedOptions.zlibYearFrom = "year";
                                        }
                                        else{
                                          SavedOptions.zlibYearFrom = zLibYearFromController.text;
                                        }
                                        zLibRemoveBookBelowYear(SavedOptions.zlibYearFrom);
                                      },
                                      controller: zLibYearFromController,
                                      keyboardType: TextInputType.number,
                                      style: TextStyle(color: Colors.white70,fontWeight: FontWeight.bold),
                                      cursorColor: Colors.white70,
                                      decoration: InputDecoration(
                                          hintText: SavedOptions.zlibYearFrom,
                                          hintStyle: TextStyle(color: Colors.white70,fontWeight: FontWeight.bold),
                                          focusColor: Colors.black54,
                                          border: InputBorder.none
                                      ),
                                    ))
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(30.0,0,30,0),
                            child: Row(
                              children: [
                                Text("Year to: "),
                                Spacer(),
                                SizedBox(
                                    width: 40,
                                    height: 30,
                                    child: TextField(
                                      onEditingComplete: (){
                                        if(zLibYearToController.text==null || zLibYearToController.text.isEmpty){
                                          SavedOptions.zlibYearTo="year";
                                        }
                                        else{
                                          SavedOptions.zlibYearTo = zLibYearToController.text;
                                        }
                                        zLibRemoveBookAboveYear(SavedOptions.zlibYearTo );
                                      },
                                      controller: zLibYearToController,
                                      keyboardType: TextInputType.number,
                                      style: TextStyle(color: Colors.white70,fontWeight: FontWeight.bold),
                                      cursorColor: Colors.white70,
                                      decoration: InputDecoration(
                                          hintText: SavedOptions.zlibYearTo,
                                          hintStyle: TextStyle(color: Colors.white70,fontWeight: FontWeight.bold),
                                          focusColor: Colors.black54,
                                          border: InputBorder.none
                                      ),
                                    ))
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    ///LibGen options
                    Padding(
                      padding: const EdgeInsets.fromLTRB(10,0,10,0),
                      child: ExpansionTile(title: Text("Z-library"),
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(30.0,0,30,0),
                            child: Row(
                              children: [
                                Text("Language: "),
                                Spacer(),
                                DropdownButton(
                                    dropdownColor: Color(0xffD9B7AB),
                                    icon: Icon(Icons.language,color: Colors.black54,),
                                    hint: Text("lang"),
                                    value: SavedOptions.libGenchosenLanguage,
                                    onChanged: (value) {
                                      setState(() {
                                        SavedOptions.libGenchosenLanguage = value;
                                        LibGenRemoveLanguage(SavedOptions.libGenchosenLanguage);
                                      });
                                    },
                                    items: LibGen.languages.map((e) {
                                      return DropdownMenuItem(
                                        value: e,
                                        child: Text(e),
                                      );
                                    }).toList())
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(30.0,0,30,0),
                            child: Row(
                              children: [
                                Text("Extension: "),
                                Spacer(),
                                DropdownButton(
                                    dropdownColor: Color(0xffD9B7AB),
                                    icon: Icon(Icons.extension_outlined,color: Colors.black54,),
                                    hint: Text("ext"),
                                    value: SavedOptions.libGenchosenExt,
                                    onChanged: (value) {
                                      setState(() {
                                        SavedOptions.libGenchosenExt = value;
                                        zLibRemoveExtensiion(SavedOptions.libGenchosenExt);
                                      });
                                    },
                                    items: LibGen.extensions.map((e) {
                                      return DropdownMenuItem(
                                        value: e,
                                        child: Text(e),
                                      );
                                    }).toList())
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(30.0,0,30,0),
                            child: Row(
                              children: [
                                Text("Year from: "),
                                Spacer(),
                                SizedBox(
                                    width: 40,
                                    height: 30,
                                    child: TextField(
                                      onEditingComplete: (){
                                        if(libGenYearFromController.text==null || libGenYearFromController.text.isEmpty){
                                          SavedOptions.libGenYearFrom = "year";
                                        }
                                        else{
                                          SavedOptions.libGenYearFrom = zLibYearFromController.text;
                                        }
                                        zLibRemoveBookBelowYear(SavedOptions.libGenYearFrom);
                                      },
                                      controller: libGenYearFromController,
                                      keyboardType: TextInputType.number,
                                      style: TextStyle(color: Colors.white70,fontWeight: FontWeight.bold),
                                      cursorColor: Colors.white70,
                                      decoration: InputDecoration(
                                          hintText: SavedOptions.zlibYearFrom,
                                          hintStyle: TextStyle(color: Colors.white70,fontWeight: FontWeight.bold),
                                          focusColor: Colors.black54,
                                          border: InputBorder.none
                                      ),
                                    ))
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(30.0,0,30,0),
                            child: Row(
                              children: [
                                Text("Year to: "),
                                Spacer(),
                                SizedBox(
                                    width: 40,
                                    height: 30,
                                    child: TextField(
                                      onEditingComplete: (){
                                        if(libGenYearToController.text==null || libGenYearToController.text.isEmpty){
                                          SavedOptions.libGenYearTo="year";
                                        }
                                        else{
                                          SavedOptions.libGenYearTo = libGenYearToController.text;
                                        }
                                        zLibRemoveBookAboveYear(SavedOptions.libGenYearTo );
                                      },
                                      controller: libGenYearToController,
                                      keyboardType: TextInputType.number,
                                      style: TextStyle(color: Colors.white70,fontWeight: FontWeight.bold),
                                      cursorColor: Colors.white70,
                                      decoration: InputDecoration(
                                          hintText: SavedOptions.zlibYearTo,
                                          hintStyle: TextStyle(color: Colors.white70,fontWeight: FontWeight.bold),
                                          focusColor: Colors.black54,
                                          border: InputBorder.none
                                      ),
                                    ))
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),

                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class SavedOptions {
  static String zLibchosenLanguage;
  static String zLibchosenExt;
  static String zlibYearFrom = "year";
  static String zlibYearTo = "year";

  static String appLanguage;

  static String libGenchosenLanguage;
  static String libGenchosenExt;
  static String libGenYearFrom = "year";
  static String libGenYearTo = "year";
}
