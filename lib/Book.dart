import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:share/share.dart';
import 'package:z_lib_app/API_Management.dart';
import 'package:z_lib_app/ClassNames.dart';
import 'package:z_lib_app/ShowImage.dart';

class LittlebookInfo {
  String title;
  String imageUrl;
  List<String> authors;
  List<String> authorsURL;
  String publisher;
  String publisherURL;
  String year;
  String leanguage;
  String file;

  String bookID;

  LittlebookInfo(
      {this.title,
      this.imageUrl,
      this.authors,
      this.year,
      this.leanguage,
      this.file,
      this.bookID,
      this.publisher,
      this.publisherURL,
      this.authorsURL});
}

class BigBookInfo {
  String title;
  List<String> authors;
  String imageUrl;
  String year;
  String language;
  String categories;
  String categoriesURL;
  String pages;
  String file;
  String fileUrl;
  BigBookInfo(
      {this.title,
      this.authors,
      this.year,
      this.language,
      this.categories,
      this.categoriesURL,
      this.pages,
      this.imageUrl,
      this.file,
      this.fileUrl});
}

class LittleBookCard extends StatelessWidget {
  LittlebookInfo bookInfo;
  final Function publisher;
  final Function(String) authorSearch;
  LittleBookCard({this.bookInfo, this.publisher, this.authorSearch});

  @override
  Widget build(BuildContext context) {
     if(bookInfo.imageUrl=="/img/cover-not-exists.png"){
      bookInfo.imageUrl="https://i.imgur.com/1mECa0I.png";
    }
    bool visiblepublisher = true;
    if (bookInfo.publisher == "not given") {
      visiblepublisher = false;
    }
    String result;
    String dlLink;
    return Row(
      children: [
        GestureDetector(
            onTap: () => {
              if(bookInfo.imageUrl!="https://i.imgur.com/1mECa0I.png"){
                API_Manager.getBookSiteFromId(bookInfo.bookID)
                    .then((value) =>
                {
                  result = value
                      .getElementsByClassName(
                      "lightbox details-book-cover checkBookDownloaded")
                      .first
                      .attributes['href'],
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ShowImage(result)))
                })
              }
                },
            child: Image.network(bookInfo.imageUrl)),
        Expanded(
          child: Slidable(
            actionPane: SlidableStrechActionPane(),
            actions: [
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
                child: IconSlideAction(
                    color: Color(0xff6a8999),
                    icon: Icons.share,
                    onTap: () {
                      Share.share(Utilities.siteRoot + bookInfo.bookID);
                    }),
              ),
              Padding(
                //todo download
                padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
                child: IconSlideAction(
                  color: Color(0xff6a8999),
                  icon: Icons.download_rounded,
                  onTap: () async{
                    ///proper way of downloading
                    // API_Manager.getBookSiteFromId(bookInfo.bookID)
                    //     .then((value) => {
                    //           dlLink=Utilities.siteRoot+ value.getElementsByClassName("btn btn-primary dlButton addDownloadedBook").first.attributes['href'],
                    //           print(dlLink),
                    //         }).then((value) async{
                    //   final status = await Permission.storage.request();
                    //   if(status.isGranted){
                    //
                    //     final externalDir = await getExternalStorageDirectory();
                    //
                    //     final id = await FlutterDownloader.enqueue(url: dlLink, savedDir: externalDir.path,fileName: bookInfo.title,showNotification: true,openFileFromNotification: true);
                    //
                    //   }else{
                    //
                    //   }
                    // });
                    /// just open it in a fucking browser bro
                    // API_Manager.getBookSiteFromId(bookInfo.bookID)
                    //     .then((value) => {
                    //   dlLink=Utilities.siteRoot+ value.getElementsByClassName("btn btn-primary dlButton addDownloadedBook").first.attributes['href'],
                    //   print(dlLink),
                    // }).then((value) => API_Manager.LaunchInBrowser(dlLink));

                    ///just open the fucking website at least
                    print(Utilities.siteRoot+bookInfo.bookID);
                    API_Manager.LaunchInBrowser(Utilities.siteRoot+bookInfo.bookID);
                  },
                ),
              ),
            ],
            child: Card(
              color: Color(0xff4f6773),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    child: Text(bookInfo.title,style: TextStyle(color: Colors.white60),),
                  ),
                  Visibility(
                    visible: visiblepublisher,
                    child: GestureDetector(
                      onTap: publisher,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
                        child: Container(
                          child: Text(bookInfo.publisher,style: TextStyle(color: Colors.white60,fontStyle: FontStyle.italic),),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: bookInfo.authors.length,
                        itemBuilder: (context, index) {
                          return LittleBookAuthors(bookInfo.authors[index],
                              bookInfo.authorsURL[index], authorSearch);
                        }),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        "Year: " + bookInfo.year,
                        overflow: TextOverflow.fade,
                        style: TextStyle(fontSize: 10,color: Colors.white60),
                      ),
                      Text(
                        "Language: " + bookInfo.leanguage,
                        overflow: TextOverflow.fade,
                        style: TextStyle(fontSize: 10,color: Colors.white60),
                      ),
                      Text(
                        "FIle: " + bookInfo.file,
                        overflow: TextOverflow.fade,
                        style: TextStyle(fontSize: 10,color: Colors.white60),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        )
      ],
    );
  }
}

class LittleBookAuthors extends StatelessWidget {
  String author;
  String authorURL;
  final Function(String) search;
  LittleBookAuthors(this.author, this.authorURL, this.search);
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.blueGrey[700],
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20))),
      child: GestureDetector(
        onTap: () => search(authorURL),
        child: Container(margin: EdgeInsets.all(3), child: Text(author,style: TextStyle(color: Colors.white60),)),
      ),
    );
  }
}
class SciHubArticleInfo {
 String shareURL;
 String downloadURL;
 SciHubArticleInfo({this.shareURL,this.downloadURL});
}
class SciHubArticle extends StatelessWidget {
  SciHubArticleInfo articleInfo;
  SciHubArticle({this.articleInfo});
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.blueGrey,
      child: Column(
        children: [
          Center(child: Text("Found your item!")),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              MaterialButton(onPressed: () async{

                  final status = await Permission.storage.request();
                  if(status.isGranted){

                    final externalDir = await getExternalStorageDirectory();

                    final id = await FlutterDownloader.enqueue(url: "https://"+articleInfo.downloadURL, savedDir: externalDir.path,fileName: "article.pdf",showNotification: true,openFileFromNotification: true);

                  }else{

                  }
                }
                //API_Manager.LaunchInBrowser(articleInfo.downloadURL);
              ,child: Icon(Icons.download_rounded),),
              MaterialButton(onPressed: ()=>Share.share(articleInfo.shareURL),child: Icon(Icons.share),),
              MaterialButton(onPressed: ()=>API_Manager.LaunchInBrowser(Utilities.SciHubRootSite+Utilities.SciHubTextController.text),
                child: Icon(Icons.chrome_reader_mode),),
            ],
          )
        ],
      ),
    );
  }
}

class LibGenBookInfo{
String title;
String bookURL;
String series;
String seriesURL;
String publisher;
String year;
String language;
String ISBN;
String size;
String pages;
String id;
String extention;
}