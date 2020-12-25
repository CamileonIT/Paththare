import 'package:flutter/material.dart';
import 'package:sl/ui/home.dart';
import 'package:web_browser/web_browser.dart';

class ViewPaper extends StatelessWidget {
  ViewPaper(this.siteUrl);

  final String siteUrl;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: WebBrowser(
          initialUrl: '$siteUrl',
          allowFullscreen: true,
          javascript: true,
        ),
      ),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.home),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Home()),
            );
          }),
    );
  }
}
