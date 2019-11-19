import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:jwel_smart/logic/authentication.dart';
import 'package:jwel_smart/views/helpers/alert.dart';
import 'package:jwel_smart/views/helpers/app_navigator.dart';
import 'package:jwel_smart/views/splash.dart';

import 'register.dart';

class LoginView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: Colors.red[600],
      //   title: Text("Welcome "),
      //   centerTitle: true,
      //   automaticallyImplyLeading: false,
      // ),
      body: LoginForm(),
    );
  }
}

class LoginForm extends StatefulWidget {
  LoginForm();

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final GlobalKey<FormBuilderState> _fbKey = GlobalKey<FormBuilderState>();
  bool processing;

  @override
  void initState() {
    super.initState();
    processing = false;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
          child: Center(
        child: Container(
          decoration: BoxDecoration(
           // image: DecorationImage(image: AssetImage('assets/t.jpg'),fit: BoxFit.cover),
            gradient: new LinearGradient(
              colors: [Colors.black87, Colors.indigo[900]],
              begin: FractionalOffset.topCenter,
              end: FractionalOffset.bottomCenter,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(18.0),
            child: FormBuilder(
              key: _fbKey,
              child: Theme(
                data: Theme.of(context)
                    .copyWith(primaryColor: Theme.of(context).accentColor),
                child: ListView(
                  children: <Widget>[
                    SizedBox(
                      height: 30,
                    ),
                    Image.asset(
                      "assets/logo.png",
                      height: MediaQuery.of(context).size.height * 0.25,
                      fit: BoxFit.contain,
                    ),
                     SizedBox(
                      height: 10,
                    ),
                    _buildTitle("Email"),
                    _email,
                    _buildTitle("Password"),
                    _password,
                    SizedBox(
                      height: 30,
                    ),
                    Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            width: 200,
                            height: 40,
                            child: RaisedButton(
                              
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15)),
                              color: Colors.pink,
                              textColor: Colors.white,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                mainAxisSize: MainAxisSize.max,
                                children: <Widget>[
                                  new Icon(Icons.unarchive),
                                  Text("Login"),
                                ],
                              ),
                              onPressed: () => _handleFormSubmit(),
                            ),
                          ),
                        ),
                        SizedBox(
                      height: 15,
                    ),
                        new Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            new Text(
                              '   Don\'t have an account yet? ',
                              style:
                                  new TextStyle(fontSize: 18, color: Colors.white),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 0.0, right: 10.0, top: 0.0),
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => RegisterView(),
                                      ));
                                },
                                child: new Container(
                                    alignment: Alignment.center,
                                    height: 40.0,
                                    decoration: new BoxDecoration(
                                        color: Colors.transparent,
                                        borderRadius:
                                            new BorderRadius.circular(9.0)),
                                    child: new Text("Create one",
                                        style: new TextStyle(
                                            fontSize: 18.0, color: Colors.blue))),
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<bool> _onWillPop() {
    // if (now.difference(currentBackPressTime) > Duration(seconds: 2))
    //   currentBackPressTime = now;
    return showDialog(
      context: context,
      builder: (context) => new Theme(
        data: Theme.of(context).copyWith(
            dialogBackgroundColor: Colors.grey[100],
            backgroundColor: Colors.white),
        child: AlertDialog(
          title: new Text('Are you sure?'),
          content: new Text('Do you want to exit from this App?'),
          actions: <Widget>[
            new FlatButton(
              onPressed: () => exit(0),
              child: new Text('Yes'),
            ),
            new FlatButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: new Text('No'),
            ),
          ],
        ),
      ),
    );
  }

  Widget get _email => Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          //height: 50,
          child: FormBuilderTextField(
            validators: [
              FormBuilderValidators.required(),
              FormBuilderValidators.email(),
            ],

            keyboardType: TextInputType.emailAddress,
            attribute: "email",
            maxLines: 1,
            decoration: InputDecoration(
              filled: true,
              //prefix: Icon(Icons.mail,color: Colors.black,),
             // icon: Icon(Icons.mail,color: Colors.white,),
                hintText: "abc@gmail.com",
                errorStyle: TextStyle(color: Colors.white),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
                fillColor: Colors.white70
                ),
          ),
        ),
      );

  Widget get _password => Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          //height: 50,
          child: FormBuilderTextField(
            validators: [
              FormBuilderValidators.required(),
            ],
            obscureText: true,
            attribute: "password",
            maxLines: 1,
            decoration: InputDecoration(
              filled: true,
             // icon: Icon(Icons.vpn_key,color: Colors.white,),
              hintText: "Password",
              errorStyle: TextStyle(color: Colors.white),
              fillColor: Colors.white70,
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
            ),
          ),
        ),
      );

  Widget _buildTitle(String title) {
    return Padding(
      padding: EdgeInsets.only(left: 8.0, bottom: 0.0, top: 20.0),
      child: Text(
        title,
        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),//email pw font color
      ),
    );
  }

  void _handleFormSubmit() async {
    _fbKey.currentState.save();
    if (_fbKey.currentState.validate()) {
      setState(() {
        processing = true;
      });
      bool isLoggedIn = await Authentication.login(
          _fbKey.currentState.value['email'],
          _fbKey.currentState.value['password'], (e) {
        if (mounted) {
          Alert.showAlertBox(context, e.toString());
        }
      });

      if (mounted) {
        setState(() {
          processing = false;
        });
        if (isLoggedIn) {
          AppNavigator.pushAsFirst(context, (_) => SplashScreen());
        }
      }
    }
  }
}
