import 'package:carousel_extended/carousel_extended.dart';
import 'package:flutter/material.dart';
import 'package:sl/ui/view_paper.dart';
import 'dart:convert';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List data;
  String catagoryN = "Daily";
  String language = "Sinhala";

  Widget carousel() {
    return Center(
      child: SizedBox(
        height: 200.0,
        child: Carousel(
          pageController: PageController(),
          boxFit: BoxFit.cover,
          autoplay: true,
          animationCurve: Curves.fastOutSlowIn,
          animationDuration: Duration(milliseconds: 1000),
          dotSize: 6.0,
          dotIncreasedColor: Color(0xFFFF335C),
          dotBgColor: Colors.transparent,
          dotPosition: DotPosition.bottomCenter,
          dotVerticalPadding: 10.0,
          showIndicator: true,
          indicatorBgPadding: 7.0,
          images: [
            NetworkImage(
                'https://www.lakehouse.lk/sites/default/files/images/Newpapers.png'),
            NetworkImage(
                'https://www.navaliya.com/navaliya/img/banner4.jpg?v1.66'),
            NetworkImage(
                'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRDjGaH41jQ-Ps4ZFTBLCT_DWjFn8MMgNSuYQ&usqp=CAU'),
            //ExactAssetImage("assets/images/LaunchImage.jpg"),
          ],
        ),
      ),
    );
  }

  Widget catogoryButton(catagory, name) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: FlatButton(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18.0),
            side: BorderSide(color: Colors.red)),
        onPressed: () {
          setState(() {
            catagoryN = catagory;
          });
        },
        child: Text("$name"),
      ),
    );
  }

  Widget homeTile(name, des, siteUrl, imgUrl) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Card(
        child: ListTile(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ViewPaper(siteUrl)),
            );
          },
          title: Text("$name"),
          subtitle: Text("$des"),
          leading: Container(
            width: 150,
            child: Image.network('$imgUrl'),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          language == "English" ? "The Newspaper" : "Paththare - පත්තරේ",
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        actions: [
          FlatButton(
              onPressed: () {
                setState(() {
                  language == "English"
                      ? language = "Sinhala"
                      : language = "English";
                });
              },
              child: Text(language == "English" ? "Sinhala" : "English")),
        ],
      ),
      body: SingleChildScrollView(
        physics: ScrollPhysics(),
        child: Column(
          children: [
            Container(
              height: 10,
            ),
            Container(
              height: 200,
              width: MediaQuery.of(context).size.width - 40,
              child: carousel(),
            ),
            Container(
              height: 80,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Center(
                  child: Wrap(
                    children: [
                      catogoryButton(
                          "Daily",
                          language == "English"
                              ? "Daily Newspapers"
                              : "දවසේ පත්තර"),
                      catogoryButton(
                          "Sunday",
                          language == "English"
                              ? "Sunday Newspapers"
                              : "ඉරිදා පත්තර"),
                      catogoryButton(
                          "Science",
                          language == "English"
                              ? "Educational Newspapers"
                              : "අධ්‍යාපනික පත්තර"),
                      catogoryButton(
                          "Ladies",
                          language == "English"
                              ? "Ladies Newspapers"
                              : "කාන්තා පත්තර"),
                    ],
                  ),
                ),
              ),
            ),
            Center(
              child: FutureBuilder(
                future: DefaultAssetBundle.of(context)
                    .loadString('lib/data/$language/$catagoryN.json'),
                builder: (context, snapshot) {
                  // Decode the JSON
                  var newData = json.decode(snapshot.data.toString());

                  return ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: newData == null ? 0 : newData.length,
                      itemBuilder: (BuildContext context, int index) {
                        return homeTile(
                            newData[index]['name'],
                            newData[index]['des'],
                            newData[index]['siteUrl'],
                            newData[index]['imgUrl']);
                      });
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.person),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Home()),
            );
          }),
    );
  }
}
