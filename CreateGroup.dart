// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unused_import, curly_braces_in_flow_control_structures, missing_return

import 'package:first_app/CustomUI/AvtarCard.dart';
import 'package:flutter/material.dart';
import '../CustomUI/ContactCard.dart';
import '../CustomUI/ButtonCard.dart';
import '../model/Chatmodel.dart';

class CreateGroup extends StatefulWidget {
  const CreateGroup({Key key}) : super(key: key);

  @override
  _CreateGroupState createState() => _CreateGroupState();
}

class _CreateGroupState extends State<CreateGroup> {
  List<ChatModel> contacts = [
    ChatModel(
      name: "Balram",
      status: "A Mern developer",
      //select: false,
    ),
    ChatModel(
      name: "Krishna",
      status: "A java developer",
      // select: false,
    ),
    ChatModel(
      name: "Suman",
      status: "A App developer",
      // select: false,
    ),
    ChatModel(
      name: "Darun",
      status: "A React developer",
      // select: false,
    ),
    ChatModel(
      name: "Sunil",
      status: "A Flutter developer",
      // select: false,
    ),
    ChatModel(
      name: "Balram",
      status: "A Mern developer",
      //  select: false,
    ),
    ChatModel(
      name: "Krishna",
      status: "A java developer",
      //  select: false,
    ),
    ChatModel(
      name: "Suman",
      status: "A App developer",
      //  select: false,
    ),
    ChatModel(
      name: "Darun",
      status: "A React developer",
      //  select: false,
    ),
    ChatModel(
      name: "Sunil",
      status: "A Flutter developer",
      //  select: false,
    ),
  ];

  List<ChatModel> groups = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "New Group",
              style: TextStyle(
                fontSize: 19,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              "Add Participants",
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
        ],
      ),
      body: Stack(
        children: [
          ListView.builder(
            itemCount: contacts.length + 1,
            itemBuilder: (context, index) {
              if (index == 0) {
                return Container(
                  height: groups.length > 0 ? 90 : 5,
                );
              }
              return InkWell(
                onTap: () {
                  setState(
                    () {
                      if (contacts[index].select == true) {
                        contacts[index - 1].select = false;
                      } else {
                        groups.add(contacts[index - 1]);
                        contacts[index - 1].select = true;
                      }
                    },
                  );
                },
                child: ContactCard(
                  contact: contacts[index - 1],
                ),
              );
            },
          ),
          groups.length > 0
              ? Column(
                  children: [
                    Container(
                      height: groups.length > 0 ? 105 : 5,
                      color: Colors.white,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: contacts.length,
                        itemBuilder: (context, index) {
                          if (contacts[index].select == true) {
                            return InkWell(
                              onTap: () {
                                setState(() {
                                  groups.remove(contacts[index]);
                                  contacts[index].select = false;
                                });
                              },
                              child: AvtarCard(
                                contact: contacts[index],
                              ),
                            );
                          } else {
                            return Container();
                          }
                        },
                      ),
                    ),
                    Divider(
                      thickness: 1,
                    )
                  ],
                )
              : Container(),
        ],
      ),
    );
  }
}
