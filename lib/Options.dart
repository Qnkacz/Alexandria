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
  void zLibRemoveLanguage(String language){
    setState(() {
      Utilities.bookList.removeWhere((element) => (element.leanguage!=language));
    });
    GlobalWidgets.showMessageFlushBar(context, "Removed listed books that didn't match the language");
  }
  void zLibRemoveExtensiion(String extension){
    setState(() {
      Utilities.bookList.removeWhere((element) => (!element.file.contains(extension.toUpperCase())));
    });
    GlobalWidgets.showMessageFlushBar(context, "Removed listed books that didn't match the extension");
  }
  void zLibRemoveBookBelowYear(String year){
    setState(() {
      Utilities.bookList.removeWhere((element) => int.parse(element.year) <int.parse(year));
    });
    GlobalWidgets.showMessageFlushBar(context, "Removed listed books that where older than $year");
  }
  void zLibRemoveBookAboveYear(String year){
    setState(() {
      Utilities.bookList.removeWhere((element) => int.parse(element.year) >int.parse(year));
    });
    GlobalWidgets.showMessageFlushBar(context, "Removed listed books that where younger than $year");
  }

  void LibGenRemoveBooks(){

  }
  String zLibchosenLanguage;
  String zLibchosenExt;
  String zlibYearFrom;
  String zlibYearTo;

  String libGenOption;

  String appLanguage;
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
                  Card(
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
                  Card(
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
                            value: appLanguage,
                            onChanged: (value) {
                              setState(() {
                                appLanguage = value;
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
                                  value: zLibchosenLanguage,
                                  onChanged: (value) {
                                    setState(() {
                                      zLibchosenLanguage = value;
                                      zLibRemoveLanguage(zLibchosenLanguage);
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
                                  value: zLibchosenExt,
                                  onChanged: (value) {
                                    setState(() {
                                      zLibchosenExt = value;
                                      zLibRemoveExtensiion(zLibchosenExt);
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
                                    keyboardType: TextInputType.number,
                                    style: TextStyle(color: Colors.white70,fontWeight: FontWeight.bold),
                                    cursorColor: Colors.white70,
                                    decoration: InputDecoration(
                                        hintText: "year",
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
                                    keyboardType: TextInputType.number,
                                    style: TextStyle(color: Colors.white70,fontWeight: FontWeight.bold),
                                    cursorColor: Colors.white70,
                                    decoration: InputDecoration(
                                        hintText: "year",
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
                    padding: const EdgeInsets.fromLTRB(25,0,25,0),
                    child: Row(
                      children: [
                        Text("LibGen search for: ",style: TextStyle(fontWeight: FontWeight.bold),),
                        Spacer(),
                        DropdownButton(
                            dropdownColor: Color(0xffD9B7AB),
                            icon: Icon(Icons.settings,color: Colors.black54,),
                            hint: Text("option"),
                            value: libGenOption,
                            onChanged: (value) {
                              setState(() {
                                libGenOption = value;
                              });
                            },
                            items: LibGen.options.map((e) {
                              return DropdownMenuItem(
                                value: e,
                                child: Text(e),
                              );
                            }).toList())
                      ],
                    ),
                  ),

                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
