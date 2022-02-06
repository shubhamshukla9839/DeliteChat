import 'package:first_app/CustomUI/ButtonCard.dart';
import 'package:first_app/Screens/Homescreen.dart';
import 'package:flutter/material.dart';
import '../model/Chatmodel.dart';

class loginScreen extends StatefulWidget {
  const loginScreen({Key key}) : super(key: key);

  @override
  _loginScreenState createState() => _loginScreenState();
}

class _loginScreenState extends State<loginScreen> {
  ChatModel sourceChat;
  List<ChatModel> chatModels = [
    ChatModel(
      name: "shubham",
      isGroup: false,
      currentMessage: "hi everyone1",
      time: "4:00",
      icon: "person.svg",
      id: 1,
    ),
    ChatModel(
        name: "saurabh",
        isGroup: false,
        currentMessage: "hi everyone2",
        time: "4:10",
        icon: "person.svg",
        id: 2),
    ChatModel(
        name: "shubham_server",
        isGroup: false,
        currentMessage: "hi everyone3",
        time: "4:20",
        icon: "person.svg",
        id: 3),
    /*ChatModel(
        name: "saurabh_server",
        isGroup: true,
        currentMessage: "hi everyone4",
        time: "4:30",
        icon: "groups.svg"), */

    ChatModel(
        name: "AJit",
        isGroup: false,
        currentMessage: "Fine",
        time: "4:50",
        icon: "person.svg",
        id: 4),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView.builder(
      itemCount: chatModels.length,
      itemBuilder: (context, index) => InkWell(
          onTap: () {
            sourceChat = chatModels.removeAt(index);
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (builder) => HomeScreen(
                  chatmodels: chatModels,
                  sourcechat: sourceChat,
                ),
              ),
            );
          },
          child: ButtonCard(name: chatModels[index].name, icon: Icons.person)),
    ));
  }
}
