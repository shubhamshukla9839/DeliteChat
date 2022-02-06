// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import '../pages/ChatPage.dart';
import 'package:first_app/pages/statusPage.dart';
import '../pages/CameraPage.dart';
import '../model/Chatmodel.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key key, this.chatmodels, this.sourcechat}) : super(key: key);
  @override
  _HomeScreenState createState() => _HomeScreenState();
  final List<ChatModel> chatmodels;
  final ChatModel sourcechat;
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  TabController _controller;

  void initState() {
    super.initState();
    _controller = TabController(length: 4, vsync: this, initialIndex: 1);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("DeliteChat"),
        actions: [
          IconButton(icon: Icon(Icons.search), onPressed: () {}),
          PopupMenuButton<String>(
            onSelected: (value) {
              //print(value);
            },
            itemBuilder: (BuildContext context) {
              return [
                PopupMenuItem(
                  child: Text("New Group"),
                  value: "New Group",
                ),
                PopupMenuItem(
                  child: Text("New BroadCast"),
                  value: "New BroadCast",
                ),
                PopupMenuItem(
                  child: Text("DeliteChat Web"),
                  value: "DeliteChat Web",
                ),
                PopupMenuItem(
                  child: Text("Starred Message"),
                  value: "Starred Messages",
                ),
                PopupMenuItem(
                  child: Text("Settings"),
                  value: "Settings",
                ),
              ];
            },
          )
        ],
        bottom: TabBar(
          controller: _controller,
          indicatorColor: Colors.white,
          tabs: [
            Tab(
              icon: Icon(Icons.camera_alt),
            ),
            Tab(
              text: "CHATS",
            ),
            // ignore: prefer_const_constructors
            Tab(
              text: "STATUS",
            ),
            // ignore: prefer_const_constructors
            Tab(
              text: "CALLS",
            ),
          ],
        ),
      ),
      body: TabBarView(
        controller: _controller,
        children: [
          CameraPage(),
          //Text("camera"),
          ChatPage(
              chatmodels: widget.chatmodels, sourcechat: widget.sourcechat),
          statusPage(),
          Text("calls"),
        ],
      ),
    );
  }
}
