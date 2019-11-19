import 'package:flutter/material.dart';

class AboutUsScreen extends StatefulWidget {
  @override
  _AboutUsScreenState createState() => _AboutUsScreenState();
}

class _AboutUsScreenState extends State<AboutUsScreen> {
  @override
  Widget build(BuildContext context) {
    final double deviceWidth = MediaQuery.of(context).size.width;
    final double targetWidth = deviceWidth > 550.0 ? 500.0 : deviceWidth;
    final double deviceHeight = MediaQuery.of(context).size.height;
    return Scaffold(
        appBar: AppBar(
          title: Text('About us'),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Container(
              width: targetWidth,
              height: deviceHeight,
              // decoration: BoxDecoration(
              //   gradient: new LinearGradient(
              //     colors: [ Color(0xFFD1C4E9),  Color(0xFFB2DFDB)],
              //     begin: FractionalOffset.topCenter,
              //     end: FractionalOffset.bottomCenter,
              //   ),
              // ), 
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(
                    height: 5.0,
                  ),
                  new Row(
                    children: <Widget>[
          new CircleAvatar(
            backgroundImage: new ExactAssetImage(
                "assets/paba.jpg"), 
            minRadius: 30,
            maxRadius: 50,
          ),
          SizedBox(
            height: 5.0,
          ),
          new Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                " Pabasara Patabendi", 
                style: TextStyle(
                    fontSize: 20.0, fontWeight: FontWeight.bold),
              ),
              Text(
                "  Software Developer", 
                style: TextStyle(
                  fontSize: 15.0,
                ),
              ),
              Text(
                "   n.p.l.patabendi@gmail.com  ", 
                style: TextStyle(
                  fontSize: 12.0,
                ),
              ),
            ],
          ),
                    ],
                  ),
                  SizedBox(
                    height: 15.0,
                  ),
                  new Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
          SizedBox(
            height: 5.0,
          ),
          new Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              Text(
                "Anuradha Divyanjalie",
                style: TextStyle(
                    fontSize: 20.0, fontWeight: FontWeight.bold),
              ),
              Text(
                " Software Developer  ",
                style: TextStyle(
                  fontSize: 15.0,
                ),
              ),
              Text(
                "anuradhadivyanjalie97@gmail.com  ",
                style: TextStyle(
                  fontSize: 12.0,
                ),
              ),
            ],
          ),
          new CircleAvatar(
            backgroundImage: new ExactAssetImage("assets/anu.jpg"), 
            minRadius: 30,
            maxRadius: 50,
          ),
                    ],
                  ),
                  SizedBox(
                    height: 15.0,
                  ),
                  new Row(
                    children: <Widget>[
          new CircleAvatar(
            backgroundImage: new ExactAssetImage("assets/sachii.jpeg"),
            minRadius: 30,
            maxRadius: 50,
          ),
          SizedBox(                 
            height: 5.0,
          ),
          new Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                "  Sachini Nisansala",
                style: TextStyle(
                    fontSize: 20.0, fontWeight: FontWeight.bold),
              ),
              Text(
                "   Software Developer",
                style: TextStyle(
                  fontSize: 15.0,
                ),
              ),
              Text(
                "sachi123@gmail.com",
                style: TextStyle(
                  fontSize: 12.0,
                ),
              ),
            ],
          ),
                    ],
                  ),
                  SizedBox(
                    height: 15.0,
                  ),
                  new Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
          SizedBox(
            height: 5.0,
          ),
          new Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              Text(
                "Kaushika kavindi ",
                style: TextStyle(
                    fontSize: 20.0, fontWeight: FontWeight.bold),
              ),
              Text(
                "Software Developer  ",
                style: TextStyle(
                  fontSize: 15.0,
                ),
              ),
              Text(
                "kau@gmail.com  ",
                style: TextStyle(
                  fontSize: 12.0,
                ),
              ),
            ],
          ),
          new CircleAvatar(
            backgroundImage: new ExactAssetImage("assets/kau.jpg"),
            minRadius: 30,
            maxRadius: 50,
          ),
                    ],
                  ),
                  SizedBox(
                    height: 15.0,
                  ),
                  new Row(
                    children: <Widget>[
          new CircleAvatar(
            backgroundImage:
                new ExactAssetImage("assets/kavi.jpg"),
            minRadius: 30,
            maxRadius: 50,
          ),
          SizedBox(
            height: 5.0,
          ),
          new Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                "  kavithra",
                style: TextStyle(
                    fontSize: 20.0, fontWeight: FontWeight.bold),
              ),
              Text(
                "  Software Developer ",
                style: TextStyle(
                  fontSize: 15.0,
                ),
              ),
              Text(
                " kavi@gmail.com  ",
                style: TextStyle(
                  fontSize: 12.0,
                ),
              ),
            ],
          ),
                    ],
                  ),
                  SizedBox(height: 18.0),
                ],
              ),
            ),
        ));
  }
}
