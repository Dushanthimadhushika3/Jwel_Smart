import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:jwel_smart/logic/add_ad.dart';
import 'package:jwel_smart/logic/home_page_queries.dart';
import 'package:jwel_smart/logic/objects/ad.dart';
import 'package:jwel_smart/logic/objects/user.dart';
import 'package:jwel_smart/logic/reserve.dart';
import 'package:jwel_smart/views/add/add_ad.dart';
import 'package:jwel_smart/views/helpers/alert.dart';
import 'package:jwel_smart/views/helpers/handled_builders.dart';
import 'package:jwel_smart/views/home/home.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class AdView extends StatefulWidget {
  final Ad ad;
  final bool isMyReservedAd;

  AdView({Key key, this.ad, this.isMyReservedAd = false}) : super(key: key);

  @override
  _AdViewState createState() => _AdViewState(ad);
}

class _AdViewState extends State<AdView> {
  Ad ad;
  _AdViewState(this.ad);
  // _AdViewState(Ad newAd){
  //   ad = new Ad(newAd.name, newAd.description, newAd.price, newAd.ownerId, newAd.imageId, newAd.timestamp, newAd.verified, newAd.reserved, newAd.reservedBy);
  //   ad.id = newAd.id;
  // }

  @override
  Widget build(BuildContext context) {
    double mediaQueryWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
       // title: Text('data'),
        title: Text("About Ad"),
        centerTitle: true,
        actions: <Widget>[
          FutureBuilder<FirebaseUser>(
              future: FirebaseAuth.instance.currentUser(),
              builder: (context, snapshot) {
                if (snapshot != null &&
                    snapshot.hasData &&
                    snapshot.data != null &&
                    !widget.ad.reserved &&
                    snapshot.data.uid == widget.ad.ownerId) {
                  return IconButton(
                    icon: Icon(Icons.edit),
                    onPressed: () async {
                      //AppNavigator.push(context, (_) => AddAdView(this.ad));
                      Ad updatedAd = await Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => AddAdView(this.widget.ad)),
                      );
                      if (updatedAd != null)
                        setState(() {
                          this.ad = updatedAd;
                        });
                    },
                  );
                }
                return Container();//his ekak pennane..mge add ekak reserve kra nm
              }),
          FutureBuilder<FirebaseUser>(
              future: FirebaseAuth.instance.currentUser(),
              builder: (context, snapshot) {
                if (snapshot != null &&
                    snapshot.hasData &&
                    snapshot.data != null &&
                    !widget.ad.reserved &&
                    snapshot.data.uid == widget.ad.ownerId) {
                  return IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: (){
                      _showWarningDialog(context) ;
                    }
                  );
                }
                return Container();
              })
        ],
      ),
      body: ListView(
        children: <Widget>[
          Container(
            child: HandledFutureBuilder<String>(
              future: HomePageQueries.getImageUrl(ad),
              builder: (_, imageUrl) => ad.imageId == null
                  ? Container()
                  : Image.network(
                      imageUrl,
                      fit: BoxFit.cover,
                    ),
            ),
            height: mediaQueryWidth / 2,
            color: Theme.of(context).accentColor,
          ),
          Column(
            children: <Widget>[
              _buildListTile(MdiIcons.cart, ad.name, "Product", context),
              _buildListTile(
                  MdiIcons.coin, "LKR ${ad.price.toInt()}", "Price", context),
              _buildListTile(MdiIcons.text, "Description",
                  "Press here to see description", context, callback: () {
                Alert.showAlertBox(context, ad.description);
              }),
              _buildListTile(
                  MdiIcons.calendar,
                  // widget.ad.timestamp.toDate().toIso8601String(),
          ((widget.ad.timestamp.toDate()).toString()).substring(0,19),
                  "Order added on",
                  context),
              _buildListTile(
                  MdiIcons.information,
                  widget.ad.reserved ? "Reserved" : "Not Reserved",
                  "Ad state",
                  context),
              _buildListTile(
                  MdiIcons.checkboxMarkedCircle,
                  widget.ad.verified ? "Verified" : "Not Verified",
                  "Ad verification state",
                  context),
              if (widget.ad.reserved && !widget.isMyReservedAd) ...[
                Divider(),
                _buildTitle("Reserved By"),
                HandledFutureBuilder<User>(
                    future: Reserve.getReservedUser(widget.ad),
                    builder: (context, user) {
                      return Column(
                        children: <Widget>[
                          _buildListTile(MdiIcons.accountCircle, user.username,
                              "Reserved Person Username", context),
                          _buildListTile(
                              MdiIcons.phone,
                              user.phone,
                              "Reserved Person Phone Number",
                              context, callback: () {
                            _launchURL("tel:${user.phone}");//usege 4n ekta call ekak yna eka
                          }),
                          _buildListTile(MdiIcons.mail, user.email,
                              "Reserved Person Email", context, callback: () {
                            _launchURL("mailto:${user.email}");//mail ekat ynwa
                          }),
                        ],
                      );
                    }),
              ]
            ],
          ),
        ],
      ),
      floatingActionButton: FutureBuilder<FirebaseUser>(
          future: FirebaseAuth.instance.currentUser(),
          builder: (context, snapshot) {
            if (snapshot != null &&
                snapshot.hasData &&
                snapshot.data != null &&
                !widget.ad.reserved &&
                snapshot.data.uid != widget.ad.ownerId) {
              return FloatingActionButton.extended(
                icon: Icon(MdiIcons.coins),
                label: Text("Reserve"),
                onPressed: () async {
                  bool confirm = await Alert.showYesNoBox(
                      context, "Are you sure you want to reserve?");
                  if (!confirm) return;
                  try {
                    await Reserve.reserve(widget.ad, snapshot.data.uid);
                    Navigator.pop(context);
                  } catch (e) {
                    Alert.showAlertBox(context, e.toString());
                  }
                },
              );
            }
            if (widget.isMyReservedAd) {//reserve krla nam label eka wenas wenawa unresearved widihta
              return FloatingActionButton.extended(
               // backgroundColor:Colors.yellow,
                icon: Icon(MdiIcons.cancel),
                label: Text("Unreserve"),
                onPressed: () async {
                  bool confirm = await Alert.showYesNoBox(
                      context, "Are you sure you want to unreserve?");
                  if (!confirm) return;
                  try {
                    await Reserve.unreserve(widget.ad, snapshot.data.uid);
                    Navigator.pop(context);
                  } catch (e) {
                    Alert.showAlertBox(context, e.toString());
                  }
                },
              );
            }
            return Container();
          }),
    );
  }
  void _showDialog() {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Item is deleted"),
          // content: new Text("Alert Dialog body"),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("OK"),
              onPressed: () {
                Navigator.of(context).pop();

                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => HomePage()),
                );
              },
            ),
          ],
        );
      },
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
              content: Text('Do you want to delete this item?'),
              actions: <Widget>[
                FlatButton(
                  child: Text('Yes'),
                  onPressed: () async {
                      //AppNavigator.push(context, (_) => AddAdView(this.ad));
                      await DeleteAd.deleteAd(ad);
                      //Navigator.pop(context);
               _showDialog();
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
  Widget _buildTitle(String title) {
    return Padding(
      padding: EdgeInsets.only(left: 8.0, bottom: 0.0, top: 20.0),
      child: Text(
        title,
        style: TextStyle(color: Colors.indigo, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildListTile(
      IconData icon, String title, String subtitle, BuildContext context,
      {VoidCallback callback}) {
    return ListTile(
        leading: Icon(icon, color: Theme.of(context).accentColor),
        title: Text(
          title,
          style: TextStyle(fontWeight: FontWeight.w700),
        ),
        onTap: callback,
        subtitle: Text(subtitle),
        trailing: callback != null ? Icon(MdiIcons.chevronRight) : null);
  }

  void _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      print('Could not launch $url');
    }
  }
}
