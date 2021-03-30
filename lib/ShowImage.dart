import 'package:flutter/material.dart';

class ShowImage extends StatelessWidget {
  String url;
  ShowImage(this.url);
  @override
  Widget build(BuildContext context) {
    print("cum: "+url);
    return Container(
      child: Center(
        child: Image.network(url)
      ),
    );
  }
}
