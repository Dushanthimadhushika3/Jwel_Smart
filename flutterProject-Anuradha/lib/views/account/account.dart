import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:jwel_smart/logic/authentication.dart';
import 'package:jwel_smart/logic/objects/user.dart';
import 'package:jwel_smart/views/account/login.dart';
import 'package:jwel_smart/views/helpers/app_navigator.dart';
import 'package:jwel_smart/views/helpers/handled_builders.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class AccountView extends StatelessWidget {
  AccountView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double mediaQueryWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text("Account"),
        centerTitle: true,
      ),
      body: ListView(
        children: <Widget>[
          Container(
            height: mediaQueryWidth / 2.5,
            padding: const EdgeInsets.all(16.0),
            alignment: Alignment.center,
            child: Icon(
              MdiIcons.accountCircleOutline,
              size: mediaQueryWidth / 4,
              color: Theme.of(context).accentColor,
            ),
          ),
          HandledFutureBuilder<FirebaseUser>(
              future: FirebaseAuth.instance.currentUser(),
              builder: (context, fuser) {
                return HandledStreamBuilder<User>(
                    stream: Firestore.instance
                        .collection("Users")
                        .document(fuser.uid)
                        .snapshots()
                        .map((v) => User.fromMap(v.data)),
                    builder: (context, user) {
                      return Column(
                        children: <Widget>[
                          /*_buildListTile(
                              MdiIcons.key, fuser.uid, "User ID", context)*/
                          _buildListTile(MdiIcons.accountDetails, user.username,
                              "Name", context),
                          _buildListTile(
                              MdiIcons.email, user.email, "Email", context),
                          _buildListTile(MdiIcons.phone, user.phone,
                              "Phone Number", context),
                          _buildListTile(
                              MdiIcons.callMerge,
                              user.isAdmin ? "Admin Profile" : "Normal Profile",
                              "Account Type",
                              context),
                        ],
                      );
                    });
              }),
          OutlineButton(
            onPressed: () {
              _showWarningDialog(context);
              // Authentication.logout();
              // AppNavigator.pushAsFirst(context, (_) => SplashScreen());
            },
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text(
                'Logout',
                style: TextStyle(
                  fontSize: 18,
                  color: Theme.of(context).accentColor,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  _showWarningDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) => new Theme(
            data: Theme.of(context).copyWith(
                dialogBackgroundColor: Colors.grey[100],
                backgroundColor: Colors.white),
            child: AlertDialog(
              title: Text('Are you sure?'),
              content: Text('Do you want to log out from this account?'),
              actions: <Widget>[
                FlatButton(
                  child: Text('Yes'),
                  onPressed: () {
                    Authentication.logout();
                    AppNavigator.pushAsFirst(context, (_) => LoginView());
                  },
                ),
                FlatButton(
                  child: Text('No'),
                  onPressed: () {
                    Navigator.pop(context, true);
                  },
                ),
              ],
            )));
  }

  Widget _buildListTile(
      IconData icon, String title, String subtitle, BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: Theme.of(context).accentColor),
      title: Text(
        title,
        style: TextStyle(fontWeight: FontWeight.w700),
      ),
      subtitle: Text(subtitle),
    );
  }
}
