// ignore_for_file: prefer_const_constructors

import 'package:first_app/CustomUI/statusPage/HeadOwnStatus.dart';
import 'package:first_app/CustomUI/statusPage/OthersStatus.dart';
import 'package:flutter/material.dart';

class statusPage extends StatefulWidget {
  const statusPage({Key key}) : super(key: key);

  @override
  _statusPageState createState() => _statusPageState();
}

class _statusPageState extends State<statusPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
              height: 50,
              child: FloatingActionButton(
                elevation: 8,
                backgroundColor: Colors.blueGrey[100],
                onPressed: () {},
                child: Icon(
                  Icons.edit,
                  color: Colors.blueGrey[900],
                ),
              )),
          SizedBox(
            height: 13,
          ),
          FloatingActionButton(
            onPressed: () {},
            backgroundColor: Colors.greenAccent[700],
            elevation: 10,
            child: Icon(Icons.camera_alt),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            HeadOwnStatus(),
            label("Recent Updates"),
            OthersStatus(
              name: "shubham kumar shukla",
              imageName: "assets/22.png",
              time: "11:00",
              isSeen: true,
              numberOfStatus: 2,
            ),
            OthersStatus(
              name: "Arohi ",
              imageName: "assets/33.png",
              time: "11:00",
              isSeen: false,
              numberOfStatus: 1,
            ),
            OthersStatus(
              name: "suman",
              imageName: "assets/44.png",
              time: "11:00",
              isSeen: true,
              numberOfStatus: 3,
            ),
            OthersStatus(
              name: "Rohan",
              imageName: "assets/22.png",
              time: "11:00",
              isSeen: false,
              numberOfStatus: 10,
            ),
            SizedBox(height: 10),
            label("Viewed Updates"),
            OthersStatus(
                name: "shubham kumar shukla",
                imageName: "assets/22.png",
                time: "11:00",
                isSeen: false,
                numberOfStatus: 5),
            OthersStatus(
              name: "Arohi ",
              imageName: "assets/33.png",
              time: "11:00",
              isSeen: true,
              numberOfStatus: 2,
            ),
            OthersStatus(
              name: "suman",
              imageName: "assets/44.png",
              time: "11:00",
              isSeen: false,
              numberOfStatus: 5,
            ),
          ],
        ),
      ),
    );
  }

  Widget label(String label) {
    return Container(
      height: 30,
      width: MediaQuery.of(context).size.width,
      color: Colors.grey[300],
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 4),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
