import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:jwel_smart/logic/authentication.dart';
import 'package:jwel_smart/views/helpers/alert.dart';
import 'package:jwel_smart/views/helpers/app_navigator.dart';

import '../splash.dart';

class RegisterView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Create Account"),
        centerTitle: true,
        backgroundColor: Colors.black87,
      ),
      body: RegisterForm(),
    );
  }
}

class RegisterForm extends StatefulWidget {
  RegisterForm();

  @override
  _RegisterFormState createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm>
    with AutomaticKeepAliveClientMixin {
  final GlobalKey<FormBuilderState> _fbKey = GlobalKey<FormBuilderState>();
  bool _isSaving;
  TextEditingController _pass;

  @override
  void initState() {
    _isSaving = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return _isSaving
        ? Center(
            child: SpinKitChasingDots(color: Theme.of(context).accentColor),
          )
        : Center(
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
                    child: Column(
                      children: <Widget>[
                        Expanded(
                          child: SingleChildScrollView(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  _buildTitle("Username"),
                                  _username,
                                  _buildTitle("Phone"),
                                  _phone,
                                  _buildTitle("Email"),
                                  _email,
                                  _buildTitle("Password"),
                                  _password,
                                  _buildTitle("Confirm Password"),
                                  _confirmPassword,
                                ],
                              ),
                            ),
                          ),
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: RaisedButton(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15)),
                                color: Colors.indigo,
                                textColor: Colors.white,
                                child: Text("Register"),
                                onPressed: () => _handleFormSubmit(),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: RaisedButton(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15)),
                                color: Colors.red,
                                textColor: Colors.white,
                                child: Text("Cancel"),
                                onPressed: () {
                                 Navigator.pop(context);//ekaparak back wenawa
                                // Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginView())); wena page ekakta ynwa nm meka
                                },
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
  }

  Widget get _username => Padding(
        padding: const EdgeInsets.all(8.0),
        child: FormBuilderTextField(
          autovalidate: true, //type krna tanama error eka penwa
          validators: [
            FormBuilderValidators.required(),
            FormBuilderValidators.minLength(4),
          ],
          attribute: "username",
          maxLines: 1,
          decoration: InputDecoration(
            hintText: 'Your\'s name',
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
            fillColor: Colors.white70,
            filled: true,
            
          ),
        ),
      );

  Widget get _email => Padding(
        padding: const EdgeInsets.all(8.0),
        child: FormBuilderTextField(
          autovalidate: true,
          validators: [
            FormBuilderValidators.required(),
            FormBuilderValidators.email(),
          ],
          keyboardType: TextInputType.emailAddress,
          attribute: "email",
          maxLines: 1,
          decoration: InputDecoration(
            hintText: "email@website.com",
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
            fillColor: Colors.white70,
            filled: true,
          ),
        ),
      );

  Widget get _phone => Padding(
        padding: const EdgeInsets.all(8.0),
        child: FormBuilderTextField(
          autovalidate: true,
          validators: [
            FormBuilderValidators.required(),
            FormBuilderValidators.pattern(r"^\d{10}$"),
          ],
          keyboardType: TextInputType.phone,
          attribute: "phone",
          maxLines: 1,
          decoration: InputDecoration(
            hintText: "0771234567",
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
            fillColor: Colors.white70,
            filled: true,
          ),
        ),
      );

  Widget get _password => Padding(
        padding: const EdgeInsets.all(8.0),
        child: FormBuilderTextField(
           autovalidate: true,
          validators: [
            FormBuilderValidators.required(errorText: 'Password length must be at least 6'),
            FormBuilderValidators.minLength(6),
          ],
          controller: _pass,
          obscureText: true,
          attribute: "password",
          maxLines: 1,
          decoration: InputDecoration(
            hintText: "Password",
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
            fillColor: Colors.white70,
            filled: true,
          ),
        ),
      );

  Widget get _confirmPassword => Padding(
        padding: const EdgeInsets.all(8.0),
        child: FormBuilderTextField(
           autovalidate: true,
          validators: [
            FormBuilderValidators.required(errorText: 'Didn\'t match with the above password'),

          ],
          obscureText: true,
          maxLines: 1,
          attribute: "confirm_password",
          decoration: InputDecoration(
            hintText: "Confirm Password",
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
            fillColor: Colors.white70,
            filled: true,
          ),
        ),
      );

  Widget _buildTitle(String title) {
    return Padding(
      padding: EdgeInsets.only(left: 8.0, bottom: 0.0, top: 20.0),
      child: Text(
        title,
        style: TextStyle(
            color: Theme.of(context).accentColor, fontWeight: FontWeight.bold),
      ),
    );
  }

  void _handleFormSubmit() async {
    _fbKey.currentState.save();
    if (_fbKey.currentState.validate()) {
      setState(() {
        _isSaving = true;
      });

      bool isLoggedIn = await Authentication.signup(
          _fbKey.currentState.value['username'],
          _fbKey.currentState.value['phone'],
          _fbKey.currentState.value['email'],
          _fbKey.currentState.value['password'],
          _fbKey.currentState.value['confirm_password'], (e) {
        if (mounted) {
          Alert.showAlertBox(context, e.toString());
        }
      });

      if (mounted) {
        setState(() {
          _isSaving = false;
        });
        if (isLoggedIn) {
          AppNavigator.pushAsFirst(context, (_) => SplashScreen());
        }
      }
    }
  }

  @override
  bool get wantKeepAlive => true;
}
