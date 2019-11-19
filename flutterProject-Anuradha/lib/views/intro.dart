import 'package:flutter/material.dart';
import 'package:intro_views_flutter/Models/page_view_model.dart';
import 'package:intro_views_flutter/intro_views_flutter.dart';
import 'package:jwel_smart/views/account/login.dart';


class App extends StatelessWidget {
  //making list of pages needed to pass in IntroViewsFlutter constructor.
  final pages = [
    PageViewModel(
        pageColor: Colors.indigo,
        // iconImageAssetPath: 'assets/air-hostess.png',
        bubble: Image.asset('assets/air-hostess.png'),
        body: Text(
          'Join us to post your latest gems and jewelleries',
        ),
        title: Text(
          'Jewel Smart', 
        ),
        titleTextStyle: TextStyle(fontFamily: 'Manjari', color: Colors.white,fontStyle: FontStyle.normal),
        bodyTextStyle: TextStyle(fontFamily: 'Manjari', color: Colors.white),
        mainImage: Image.asset(
          'assets/first.png',
          height: 285.0,
          width: 285.0,
          alignment: Alignment.center,
        )),
    PageViewModel(
      pageColor: const Color(0xFF607D8B),
      iconImageAssetPath: 'assets/bus-driver.png',
      body: Text(
        'No more waitings.Let\'s get started.',
      ),
      title: Text('Get started!'),
      mainImage: Image.asset(
        'assets/p.png',
        height: 285.0,
        width: 285.0,
        alignment: Alignment.center,
      ),
      titleTextStyle: TextStyle(fontFamily: 'Manjari', color: Colors.white),
      bodyTextStyle: TextStyle(fontFamily: 'Manjari', color: Colors.white),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      // title: 'IntroViews Flutter', //title of app
      theme: ThemeData(
        fontFamily: 'Manjari',
        primarySwatch: Colors.indigo,
      ), //ThemeData
      home: Builder(
        builder: (context) => IntroViewsFlutter(
          pages,
          showNextButton: true,
          showBackButton: true,
          onTapDoneButton: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => LoginView(),
              ), //MaterialPageRoute
            );
          },
          pageButtonTextStyles: TextStyle(
            color: Colors.white,
            fontSize: 18.0,
          ),
        ), //IntroViewsFlutter
      ), //Builder
    ); //Material App
  }
}

