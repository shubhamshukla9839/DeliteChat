// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors

import 'package:first_app/CustomUI/Customcard.dart';
import 'package:flutter/material.dart';
import 'package:first_app/model/Chatmodel.dart';
import 'package:first_app/Screens/SelectContact.dart';
import '../Screens/loginScreen.dart';

class ChatPage extends StatefulWidget {
  ChatPage({Key key, this.chatmodels, this.sourcechat}) : super(key: key);
  final List<ChatModel> chatmodels;
  final ChatModel sourcechat;
  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (builder) => SelectContact()),
          );
        },
        backgroundColor: Colors.blueGrey,
        child: Icon(Icons.chat),
      ),
      body: ListView.builder(
        itemCount: widget.chatmodels.length,
        itemBuilder: (context, index) => CustomCard(
          chatModel: widget.chatmodels[index],
          sourcechat: widget.sourcechat,
        ),
      ),
    );
  }
}
