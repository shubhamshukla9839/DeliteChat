// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';

class ReplyCard extends StatelessWidget {
  const ReplyCard({Key key, this.othermessage, this.time}) : super(key: key);
  final String othermessage;
  final String time;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width - 35,
          ),
          child: Card(
            elevation: 1,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            margin: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
            //color: Color(0xffdcf8c6),
            child: Stack(
              children: [
                Padding(
                  padding:
                      EdgeInsets.only(left: 10, right: 80, top: 5, bottom: 30),
                  child: Text(
                    othermessage,
                    style: TextStyle(fontSize: 16),
                  ),
                ),
                Positioned(
                  bottom: 3,
                  right: 5,
                  child: Text(
                    time,
                    style: TextStyle(fontSize: 13, color: Colors.grey),
                  ),
                )
              ],
            ),
          )),
    );
  }
}
