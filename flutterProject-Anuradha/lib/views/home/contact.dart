import 'package:flutter/material.dart';

class ContactUs extends StatefulWidget {
  @override
  _ContactUsState createState() => _ContactUsState();
}

class _ContactUsState extends State<ContactUs> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Contact us'),
        centerTitle: true,
      ),
      body: Container(
        child: Center(
          child: new Column(
            children: <Widget>[
              SizedBox(
                height: 40,
              ),
              Image.asset(
                'assets/logo.png',
                fit: BoxFit.contain,
                height: MediaQuery.of(context).size.height * 0.25,
              ),
              SizedBox(
                height: 40,
              ),
              SizedBox(
                height: 30,
              ),
              Center(
                child: Text(
                  "Tp.No : 0711353507/0774604739", //methanata oyalage phone no ekk dnna
                  style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Text(
                " Email :jwelsmarty@gmail.com", //methanata oyalage email ela dnna
                style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
