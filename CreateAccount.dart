import 'package:chat_app/Authenticate/Methods.dart';
import 'package:chat_app/Authenticate/login.dart';
import 'package:chat_app/group_chats/group_chat_screen.dart';
import 'package:flutter/material.dart';

import '../Screens/HomeScreen.dart';
import '../constants.dart';

class CreateAccount extends StatefulWidget {
  @override
  _CreateAccountState createState() => _CreateAccountState();
}

class _CreateAccountState extends State<CreateAccount> {
  final TextEditingController _name = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final TextEditingController _confirmPassword = TextEditingController();
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
              "Sign Up",
              style: TextStyle(
                color: Colors.black,
                fontSize: 25.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          TextFormField(
            controller: _name,
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.person_outline),
              hintText: "Name",
              enabledBorder: kEnabledBorder,
              focusedBorder: kFocusedBorder,
              errorBorder: kErrorBorder,
              focusedErrorBorder: kErrorBorder,
            ),
          ),
          SizedBox(
            height: 20.0,
          ),
          TextFormField(
            controller: _email,
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.email),
              hintText: "Email",
              enabledBorder: kEnabledBorder,
              focusedBorder: kFocusedBorder,
              errorBorder: kErrorBorder,
              focusedErrorBorder: kErrorBorder,
            ),
          ),
          SizedBox(
            height: 20.0,
          ),
          TextFormField(
            controller: _password,
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.lock_outline),
              hintText: "Password",
              enabledBorder: kEnabledBorder,
              focusedBorder: kFocusedBorder,
              errorBorder: kErrorBorder,
              focusedErrorBorder: kErrorBorder,
            ),
            obscureText: true,
          ),
          SizedBox(
            height: 20.0,
          ),
          TextFormField(
            controller: _confirmPassword,
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.lock_open),
              hintText: "Confirm Password",
              enabledBorder: kEnabledBorder,
              focusedBorder: kFocusedBorder,
              errorBorder: kErrorBorder,
              focusedErrorBorder: kErrorBorder,
            ),
            obscureText: true,
          ),
          SizedBox(
            height: 20.0,
          ),
          RaisedButton(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)),            color: Colors.black,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 100),
              child: Text(
                "Sign Up",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0,
                ),
              ),
            ),
            onPressed: () {
    if (_password.text == _confirmPassword.text) {
    createAccount(_name.text, _email.text, _password.text).then((user) {
    if (user != null) {
    setState(() {
    isLoading = false;
    });
    Navigator.push(
    context, MaterialPageRoute(builder: (_) => GroupChatHomeScreen()));
    print("Account Created Sucessfully");
    }
    else {
    Scaffold.of(context).showSnackBar(
    SnackBar(
    content: Text("Passwords do not match"),
    duration: Duration(seconds: 2),
    ),
    );
    }
    },
    );
    };
    },
      ),
          FlatButton(
            child: Text("Already Registered? Log In here"),
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => Login(),
                ),
              );
            },
          ),
    ],
    )
    );
  }
}
