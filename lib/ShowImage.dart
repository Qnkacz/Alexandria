import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:share/share.dart';
import 'package:z_lib_app/API_Management.dart';
import 'package:z_lib_app/Book.dart';

class ShowImage extends StatelessWidget {
  String url;
  ShowImage(this.url);
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xff4f6773),
      child: Center(
        child: Image.network(url)
      ),
    );
  }
}

class ShowMoreInfo extends StatelessWidget {
  LibGenBookInfo book;
  ShowMoreInfo(this.book);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          color: Colors.blueGrey[300],
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                height: 350,
                  child: Image.network(book.imageUrl)
              ),
              MoreInfoClickableInfo("title",book.title),
              MoreInfoClickableInfo("series",book.series),
              MoreInfoClickableInfo("publisher",book.publisher),
              MoreInfoClickableInfo("authors",book.authors.join(" ")),
              MoreInfoClickableInfo("ISBN",book.ISBN),
              MoreInfoClickableInfo("pages",book.pages),
              MoreInfoClickableInfo("file",book.size+" "+book.extention),
              MoreInfoClickableInfo("language",book.language),
              MoreInfoClickableInfo("year",book.year),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  MaterialButton(onPressed: ()=>Share.share(book.bookURL),child: Icon(Icons.share),),
                  MaterialButton(onPressed: ()async{
                    API_Manager.getSite(book.bookURL).then((value)async{
                      var Row = value.body.querySelectorAll('[rules="cols"][width="100%"][border="0"]');
                      print(Row[3].children[0].children[0].children[0].children[0].attributes['href']);
                      String downloadUrl = Row[3].children[0].children[0].children[0].children[0].attributes['href'];
                      final status = await Permission.storage.request();
                      if(status.isGranted){

                        final externalDir = await getExternalStorageDirectory();

                        final id = await FlutterDownloader.enqueue(url: downloadUrl, savedDir: externalDir.path,fileName: book.title+"."+book.extention,showNotification: true,openFileFromNotification: true);

                      }else{

                      }
                    });
                  },child: Icon(Icons.download_rounded),),
                  MaterialButton(onPressed: ()=>API_Manager.LaunchInBrowser(book.bookURL),child: Icon(Icons.web_asset_sharp),),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

class MoreInfoClickableInfo extends StatelessWidget {
  String what;
  String s;
  MoreInfoClickableInfo(this.what,this.s);
  @override
  Widget build(BuildContext context) {
    return Center(child: GestureDetector(
      onTap: (){
        Clipboard.setData(new ClipboardData(text: s));
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: Colors.blueGrey,
            duration: Duration(seconds: 1),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5),
            ),
            content: Text("Copied $s to cliboard")));
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

