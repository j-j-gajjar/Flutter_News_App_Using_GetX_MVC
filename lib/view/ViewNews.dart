import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ViewNews extends StatelessWidget {
  final newsUrl;

  const ViewNews({Key? key, this.newsUrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(centerTitle: true, title: Text("News")),
      body: Container(child: WebView(initialUrl: newsUrl, javascriptMode: JavascriptMode.unrestricted)),
    );
  }
}
