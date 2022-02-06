// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unused_import, curly_braces_in_flow_control_structures

import 'package:flutter/material.dart';
import '../CustomUI/ContactCard.dart';
import '../CustomUI/ButtonCard.dart';
import '../model/Chatmodel.dart';
import './CreateGroup.dart';

class SelectContact extends StatefulWidget {
  const SelectContact({Key key}) : super(key: key);

  @override
  _SelectContactState createState() => _SelectContactState();
}

class _SelectContactState extends State<SelectContact> {
  @override
  Widget build(BuildContext context) {
    List<ChatModel> contacts = [
      ChatModel(
        name: "Balram",
        status: "A Mern developer",
      ),
      ChatModel(
        name: "Krishna",
        status: "A java developer",
      ),
      ChatModel(
        name: "Suman",
        status: "A App developer",
      ),
      ChatModel(
        name: "Darun",
        status: "A React developer",
      ),
      ChatModel(
        name: "Sunil",
        status: "A Flutter developer",
      ),
      ChatModel(
        name: "Balram",
        status: "A Mern developer",
      ),
      ChatModel(
        name: "Krishna",
        status: "A java developer",
      ),
      ChatModel(
        name: "Suman",
        status: "A App developer",
      ),
      ChatModel(
        name: "Darun",
        status: "A React developer",
      ),
      ChatModel(
        name: "Sunil",
        status: "A Flutter developer",
      ),
    ];
    return Scaffold(
      appBar: AppBar(
        title: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Select Contact",
              style: TextStyle(
                fontSize: 19,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              "256 contacts",
              style: TextStyle(
                fontSize: 19,
                fontWeight: FontWeight.bold,
              ),
            )
          ],
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.search,
              size: 26,
            ),
          ),
          PopupMenuButton<String>(
            onSelected: (value) {
              print(value);
            },
            itemBuilder: (BuildContext context) {
              return [
                PopupMenuItem(
                  child: Text("Invite a friend"),
                  value: "Invite a friend",
                ),
                PopupMenuItem(
                  child: Text("Contacts"),
                  value: "Contacts",
                ),
                PopupMenuItem(
                  child: Text("Refresh"),
                  value: "Refresh",
                ),
                PopupMenuItem(
                  child: Text("Help"),
                  value: "Help",
                ),
              ];
            },
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(5),
        child: ListView.builder(
          itemCount: contacts.length + 2,
          itemBuilder: (context, index) {
            if (index == 0)
              return InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (builder) => CreateGroup()),
                  );
                },
                child: ButtonCard(icon: Icons.group, name: "New Group"),
              );
            else if (index == 1)
              return ButtonCard(icon: Icons.person_add, name: "New Contact");

            return ContactCard(
              contact: contacts[index - 2],
            );
          },
        ),
      ),
    );
  }
}
