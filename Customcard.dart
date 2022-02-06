// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, duplicate_ignore, use_key_in_widget_constructors

import 'package:first_app/pages/indivisualPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:first_app/model/Chatmodel.dart';

class CustomCard extends StatelessWidget {
  const CustomCard({Key key, this.chatModel, this.sourcechat})
      : super(key: key);
  final ChatModel sourcechat;
  final ChatModel chatModel;
  @override
  Widget build(BuildContext context) {
    // ignore: prefer_const_constructors
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                IndivisualPage(chatModel: chatModel, sourcechat: sourcechat),
          ),
        );
      },
      child: Column(
        children: [
          ListTile(
            // ignore: prefer_const_constructors
            leading: CircleAvatar(
              radius: 30,
              child: SvgPicture.asset(
                chatModel.isGroup ? "assets/groups.svg" : "assets/person.svg",
                color: Colors.white,
                height: 38,
                width: 38,
              ),
              backgroundColor: Colors.blue[200],
            ),
            // ignore: prefer_const_constructors
            title: Text(
              chatModel.name,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            subtitle: Row(
              children: [
                Icon(Icons.done_all),
                SizedBox(
                  width: 3,
                ),
                Text(chatModel.currentMessage,
                    style: TextStyle(
                      fontSize: 13,
                    ))
              ],
            ),
            trailing: Text(chatModel.time),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 20, left: 80),
            child: Divider(
              thickness: 1.5,
            ),
          )
        ],
      ),
    );
  }
}
