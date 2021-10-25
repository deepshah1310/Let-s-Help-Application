import 'package:chat_app/Authenticate/Methods.dart';
import 'package:chat_app/Screens/HomeScreen.dart';
import 'package:chat_app/group_chats/create_group/add_members.dart';
import 'package:chat_app/group_chats/group_chat_room.dart';
import 'package:chat_app/group_chats/technical_room.dart';
import 'package:chat_app/group_chats/vehicle_room.dart';
import 'package:chat_app/payment_gateway.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'financial_room.dart';
import 'medical_room.dart';

class GroupChatHomeScreen extends StatefulWidget {
  const GroupChatHomeScreen({Key? key}) : super(key: key);

  @override
  _GroupChatHomeScreenState createState() => _GroupChatHomeScreenState();
}

class _GroupChatHomeScreenState extends State<GroupChatHomeScreen> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool isLoading = true;

  List groupList = [];

  @override
  void initState() {
    super.initState();
    getAvailableGroups();
  }

  void getAvailableGroups() async {
    String uid = _auth.currentUser!.uid;

    await _firestore
        .collection('users')
        .doc(uid)
        .collection('groups')
        .get()
        .then((value) {
      setState(() {
        groupList = value.docs;
        isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Color(0xFFB2DFDB),
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text("Groups"),
        actions: [
          IconButton(icon: Icon(Icons.logout), onPressed: () => logOut(context))
        ],
      ),
      body: isLoading
          ? Container(
              height: size.height,
              width: size.width,
              alignment: Alignment.center,
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              itemCount: groupList.length,
              itemBuilder: (context, index) {
                return ListTile(
                  onTap: () {
                    if (groupList[index]['name'] == "Technical") {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) =>
                              TechnicalRoom(
                                groupName: groupList[index]['name'],
                                groupChatId: groupList[index]['id'],
                              ),
                        ),
                      );
                    };
                    if (groupList[index]['name'] == "Vehicle") {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) =>
                              VehicleRoom(
                                groupName: groupList[index]['name'],
                                groupChatId: groupList[index]['id'],
                              ),
                        ),
                      );
                    };
                    if (groupList[index]['name'] == "Medical") {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) =>
                              MedicalRoom(
                                groupName: groupList[index]['name'],
                                groupChatId: groupList[index]['id'],
                              ),
                        ),
                      );
                    };
                    if (groupList[index]['name'] == "Financial") {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) =>
                              FinancialRoom(
                                groupName: groupList[index]['name'],
                                groupChatId: groupList[index]['id'],
                              ),
                        ),
                      );
                    };
                  },

                  leading: Icon(Icons.group),
                  title: Text(groupList[index]['name']),
                );
              },
            ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [FloatingActionButton(
          backgroundColor: Colors.black,
        child: Icon(Icons.create),
        onPressed: () => Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => AddMembersInGroup(),
          ),
        ),
        tooltip: "Create Group",
      ),
          SizedBox(
            width: size.width / 29,
          ),
          FloatingActionButton(
            backgroundColor: Colors.black,
            child: Icon(Icons.chat),
            onPressed: () => Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => HomeScreen(),
              ),
            ),
            tooltip: "Chat",
          ),
          SizedBox(
            height: size.height / 200,
          ),
    ],
    ),
    );
  }
}
