import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:jwel_smart/views/home/home.dart';
import 'package:jwel_smart/views/intro.dart';

import 'helpers/app_navigator.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  String userEmail;

  @override
  void initState() {
    super.initState();
    _authenticate();
  }

  void _authenticate() async {
    String currentUserEmail = await _getCurrentEmail();
    setState(() {
      userEmail = currentUserEmail;
    });
    await Future.delayed(Duration(seconds: 1));

    if (mounted) {
      if (currentUserEmail == null) {
        AppNavigator.pushAsFirst(context, (_) => App());
      } else {
        AppNavigator.pushAsFirst(context, (_) => HomePage());
      }
    }
  }

  Future<String> _getCurrentEmail() async {
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    return user?.email;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          SpinKitChasingDots(
            color: Theme.of(context).accentColor,
            size: MediaQuery.of(context).size.height * 0.1,
          ),
        ],
      ),
    );
  }
}
