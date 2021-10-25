import 'package:chat_app/group_chats/group_info.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../constants.dart';

class MedicalRoom extends StatelessWidget {
  final String groupChatId, groupName;

  MedicalRoom({required this.groupName, required this.groupChatId, Key? key})
      : super(key: key);

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final _formKey = GlobalKey<FormState>();
  TextEditingController issueValue = TextEditingController();
  TextEditingController detailValue = TextEditingController();
  TextEditingController historyValue = TextEditingController();

  void onSend() async {
    Map<String, dynamic> data = {
      "issue": issueValue.text,
      "detail": detailValue.text,
      "history": historyValue.text,
      "sendBy": _auth.currentUser!.displayName,
      "type": "text",
      "time": FieldValue.serverTimestamp(),
    };

    issueValue.clear();
    detailValue.clear();
    historyValue.clear();

    await _firestore
        .collection('groups')
        .doc(groupChatId)
        .collection('chats')
        .add(data);
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return DefaultTabController(
        length:2,
        child: Scaffold(
          backgroundColor: Color(0xFFB2DFDB),
        appBar: AppBar(
          backgroundColor: Colors.black,
          bottom: TabBar(indicatorColor: Colors.white,tabs: [
        Tab(text: 'Need Help'),
    Tab(text: 'Help Requests'),
    ]),
    title: Text(groupName),
        actions: [
          IconButton(
              onPressed: () => Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => GroupInfo(
                    groupName: groupName,
                    groupId: groupChatId,
                  ),
                ),
              ),
              icon: Icon(Icons.more_vert)),
        ],
      ),
      body: SafeArea(
        child: TabBarView( children: [
          Container(
            padding: EdgeInsets.all(20.0),
            decoration: BoxDecoration(
              color: Color(0xFFB2DFDB),
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
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  height: 10.0,
                ),
                TextFormField(
                  controller: issueValue,
                  decoration: InputDecoration(
                    labelText: 'Your issue is related to',
                    prefixIcon: Icon(Icons.info_outline),
                    enabledBorder: kEnabledBorder,
                    focusedBorder: kFocusedBorder,
                    errorBorder: kErrorBorder,
                    focusedErrorBorder: kErrorBorder,
                  ),
                  onTap: () {
                  },
                  // The validator receives the text that the user has entered.
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your issue is related to';
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 20.0,
                ),
                TextFormField(
                  controller: detailValue,
                  decoration: InputDecoration(
                    labelText: 'Enter your issue in detail',
                    prefixIcon: Icon(Icons.info_outline),
                    enabledBorder: kEnabledBorder,
                    focusedBorder: kFocusedBorder,
                    errorBorder: kErrorBorder,
                    focusedErrorBorder: kErrorBorder,
                  ),
                  onTap: () {
                  },
                  // The validator receives the text that the user has entered.
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your issue in detail';
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 20.0,
                ),
                TextFormField(
                  controller: historyValue,
                  decoration: InputDecoration(
                    labelText: 'Enter your history',
                    prefixIcon: Icon(Icons.history),
                    enabledBorder: kEnabledBorder,
                    focusedBorder: kFocusedBorder,
                    errorBorder: kErrorBorder,
                    focusedErrorBorder: kErrorBorder,
                  ),
                  onTap: () {
                  },
                  // The validator receives the text that the user has entered.
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your history';
                    }
                    return null;
                  },
                ),

                SizedBox(
                  height: kInputSpacing,
                ),
                SizedBox(
                  width: double.infinity,
                  child: FlatButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0)),
                    color: Colors.black,
                    textColor: Colors.white,
                    padding: EdgeInsets.only(top: 16.0, bottom: 16.0),
                    onPressed: onSend,
                    child: Text(
                      'SEND',
                      style: kButtonTextStyle,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.all(20.0),
            decoration: BoxDecoration(
              color: Color(0xFFB2DFDB),
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

            height: size.height / 1.27,
            width: size.width,
            child: StreamBuilder<QuerySnapshot>(
              stream: _firestore
                  .collection('groups')
                  .doc(groupChatId)
                  .collection('chats')
                  .orderBy('time')
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      Map<String, dynamic> data =
                      snapshot.data!.docs[index].data()
                      as Map<String, dynamic>;

                      return messageTile(size, data);
                    },
                  );
                } else {
                  return Container();
                }
              },
            ),
          ),
        ]),
      ),
        ),
    );
  }
  Widget messageTile(Size size, Map<String, dynamic> data) {
    return Builder(builder: (_) {
      if (data['type'] == "text") {
        return Container(
          width: size.width,
          alignment: data['sendBy'] == _auth.currentUser!.displayName
              ? Alignment.centerRight
              : Alignment.centerLeft,
          child: Container(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 26),
              margin: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Colors.black,
              ),
              child: Column(
                children: [
                  SizedBox(
                    height: size.height / 200,
                  ),
                  Text(
                    data['sendBy'],
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Colors.yellow,
                    ),
                  ),
                  SizedBox(
                    height: size.height / 200,
                  ),
                  Text(
                    "Issue: "+
                        data['issue'],
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(
                    height: size.height / 200,
                  ),
                  Text(
                    "Detail: "+
                        data['detail'],
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(
                    height: size.height / 200,
                  ),
                  Text(
                    "History: "+
                        data['history'],
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    ),
                  ),
                ],
              )),
        );
        /* child: Column(
                children: [
                  Card(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20))),
                    margin: EdgeInsets.symmetric(horizontal: 68, vertical: 8),
                    elevation: 8,
                    child: ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      child: Column(
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.all(16),
                            color: Colors.blue,
                            child: Column(
                              children: <Widget>[
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Text(data['sendBy'],
                                      style: TextStyle(
                                        fontSize: 13,
                                        color: Colors.grey[300],
                                      ),
                                    ),
                                  ],
                                ),


                              ],
                            ),
                          ),
                          Container(
                              padding: EdgeInsets.all(16),
                              color: Colors.white,
                              child: Column(
                                children: <Widget>[
                                  Row(
                                    children: <Widget>[
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Text( 'Amount: '+
                                  data['amount'],
                                              style: TextStyle(
                                                  color: kIndigoDark,
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w600
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),

                                ],
                              )
                          ),
                        ],

                      ),
                    ),
                  ),
                ],
              ),*/
      } else if (data['type'] == "img") {
        return Container(
          width: size.width,
          alignment: data['sendBy'] == _auth.currentUser!.displayName
              ? Alignment.centerRight
              : Alignment.centerLeft,
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 14),
            margin: EdgeInsets.symmetric(vertical: 5, horizontal: 8),
            height: size.height / 2,
            child: Image.network(
              data['amount'],
            ),
          ),
        );
      } else if (data['type'] == "notify") {
        return Container(
          width: size.width,
          alignment: Alignment.center,
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
            margin: EdgeInsets.symmetric(vertical: 5, horizontal: 8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: Colors.black38,
            ),
            child: Text(
              data['message'],
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        );
      } else {
        return SizedBox();
      }
    });
  }
}
