// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';

class ownMessageCard extends StatelessWidget {
  const ownMessageCard({Key key, this.ownmessage, this.time}) : super(key: key);
  final String ownmessage;
  final String time;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width - 35,
          ),
          child: Card(
            elevation: 1,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            margin: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
            color: Color(0xffdcf8c6),
            child: Stack(
              children: [
                Padding(
                  padding:
                      EdgeInsets.only(left: 10, right: 80, top: 5, bottom: 30),
                  child: Text(
                    ownmessage,
                    style: TextStyle(fontSize: 16),
                  ),
                ),
                Positioned(
                  bottom: 3,
                  right: 5,
                  child: Row(
                    children: [
                      Text(
                        time,
                        style: TextStyle(fontSize: 13, color: Colors.grey),
                      ),
                      SizedBox(width: 5),
                      Icon(Icons.done_all, size: 20),
                    ],
                  ),
                )
              ],
            ),
          )),
    );
  }
}
