import 'package:chat_app/Authenticate/LoginScreen.dart';
import 'package:flutter/material.dart';

class Login extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFB2DFDB),
      body: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Expanded(
            child: ListView(
              padding: EdgeInsets.all(20.0),
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(40.0),
                  child: Image.asset("assets/logo.jpg"),
                ),
                SizedBox(
                  height: 20.0,
                ),
                LoginScreen(),
              ],
            ),
          )
        ],
      ),
    );
  }
}
