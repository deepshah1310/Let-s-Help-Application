import 'package:chat_app/Authenticate/CreateAccount.dart';
import 'package:chat_app/Authenticate/shadowContainer.dart';
import 'package:chat_app/Authenticate/signup.dart';
import 'package:chat_app/Screens/HomeScreen.dart';
import 'package:chat_app/Authenticate/Methods.dart';
import 'package:chat_app/group_chats/group_chat_screen.dart';
import 'package:flutter/material.dart';

import '../constants.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  bool isLoading = false;


  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey,
            blurRadius: 10.0,
            spreadRadius: 1.0,
            offset: Offset(
              4.0,
              4.0,
            ),
          )
        ],
      ),
      child: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 8.0),
            child: Text(
              "Log In",
              style: TextStyle(
                color: Colors.black,
                fontSize: 25.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          TextFormField(
            controller: _email,
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.email),
              enabledBorder: kEnabledBorder,
              focusedBorder: kFocusedBorder,
              errorBorder: kErrorBorder,
              focusedErrorBorder: kErrorBorder,
              hintText: "Email",
            ),
          ),
          SizedBox(
            height: 20.0,
          ),
          TextFormField(
            controller: _password,
            decoration: InputDecoration(
              enabledBorder: kEnabledBorder,
              focusedBorder: kFocusedBorder,
              errorBorder: kErrorBorder,
              focusedErrorBorder: kErrorBorder,
              prefixIcon: Icon(Icons.lock_outline),
              hintText: "Password",
            ),
            obscureText: true,
          ),
          SizedBox(
            height: 20.0,
          ),
          // ignore: deprecated_member_use
          RaisedButton(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)),
            color: Colors.black,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 100),
              child: Text(
                "Log In",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0,
                ),
              ),
            ),
            onPressed: () {
              if (_email.text.isNotEmpty && _password.text.isNotEmpty) {
                setState(() {
                  isLoading = true;
                });

                logIn(_email.text, _password.text).then((user) {
                  if (user != null) {
                    print("Login Successful");
                    setState(() {
                      isLoading = false;
                    });
                    Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => GroupChatHomeScreen()));
                  } else {
                    print("Login Failed");
                    setState(() {
                      isLoading = false;
                    });
                  }
                });
              } else {
                print("Invalid login credentials!!!");
              }
            },
          ),
          // ignore: deprecated_member_use
          FlatButton(
            child: Text("Don't have an account? Sign up here"),
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => SignUp(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
