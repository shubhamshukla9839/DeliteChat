// ignore_for_file: prefer_const_constructors, missing_required_param, prefer_const_literals_to_create_immutables, prefer_final_fields, unused_field, unused_import, missing_return

import 'package:emoji_picker/emoji_lists.dart';
import 'package:first_app/CustomUI/ReplyCard.dart';
import 'package:first_app/CustomUI/ownMessageCard.dart';
import 'package:first_app/pages/CameraPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../model/Chatmodel.dart';
import 'package:emoji_picker/emoji_picker.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import '../model/MessageModel.dart';

class IndivisualPage extends StatefulWidget {
  const IndivisualPage({Key key, this.chatModel, this.sourcechat})
      : super(key: key);
  final ChatModel chatModel;
  final ChatModel sourcechat;
  @override
  _IndivisualPageState createState() => _IndivisualPageState();
}

class _IndivisualPageState extends State<IndivisualPage> {
  IO.Socket socket;
  bool show = false;
  FocusNode focusnode = FocusNode();
  bool sendButton = false;
  List<MessageModel> messages = [];
  TextEditingController _controller = TextEditingController();
  ScrollController _scrollcontroller = ScrollController();
  void initState() {
    super.initState();
    connect();
    focusnode.addListener(
      () {
        if (focusnode.hasFocus) {
          setState(() {
            show = false;
          });
        }
      },
    );
  }

  void connect() {
    //https://delitechat.herokuapp.com/check //"http://192.168.0.112:5000"
    socket = IO.io("http://192.168.0.112:5000", <String, dynamic>{
      "transports": ["websocket"],
      "autoConnect": false,
    });
    socket.connect();
    socket.onConnect((data) {
      socket.emit("signin", widget.sourcechat.id);
      print(socket.connected);
      print("connected");
      socket.on("message", (msg) {
        print(msg);
        setMessage("destination", msg["message"]);
      });
    });
  }

  void setMessage(String type, String message) {
    MessageModel messagemodel = MessageModel(
      type: type,
      message: message,
      time: DateTime.now().toString().substring(10, 16),
    );
    setState(() {
      messages.add(messagemodel);
    });
  }

  void sendMessage(String message, sourceId, targetId) {
    setMessage("source", message);
    socket.emit(
      "message",
      {"message": message, "sourceId": sourceId, "targetId": targetId},
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.asset("assets/whatsappback.png",
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            fit: BoxFit.cover),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(60),
            child: AppBar(
              leadingWidth: 70,
              titleSpacing: 0,
              leading: InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.arrow_back,
                      size: 24,
                    ),
                    CircleAvatar(
                      child: SvgPicture.asset(
                        widget.chatModel.isGroup
                            ? "assets/groups.svg"
                            : "assets/person.svg",
                        color: Colors.white,
                        height: 38,
                        width: 38,
                      ),
                      radius: 20,
                      backgroundColor: Colors.blue[200],
                    ),
                  ],
                ),
              ),
              title: InkWell(
                onTap: () {},
                child: Container(
                  margin: EdgeInsets.all(6),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        widget.chatModel.name,
                        style: TextStyle(
                          fontSize: 18.5,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "last seen today at 12:05",
                        style: TextStyle(
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              actions: [
                IconButton(
                  icon: Icon(Icons.videocam),
                  onPressed: () {},
                ),
                IconButton(
                  icon: Icon(Icons.call),
                  onPressed: () {},
                ),
                PopupMenuButton<String>(
                  onSelected: (value) {
                    print(value);
                  },
                  itemBuilder: (BuildContext context) {
                    return [
                      PopupMenuItem(
                        child: Text("View Contact"),
                        value: "View Contact",
                      ),
                      PopupMenuItem(
                        child: Text("Media links and docs"),
                        value: "Media links and docs",
                      ),
                      PopupMenuItem(
                        child: Text("Whatsapp Web"),
                        value: "Whatsapp Web",
                      ),
                      PopupMenuItem(
                        child: Text("Search"),
                        value: "Search",
                      ),
                      PopupMenuItem(
                        child: Text("Mute Notification"),
                        value: "Mute Notification",
                      ),
                      PopupMenuItem(
                        child: Text("Wallpaper"),
                        value: "Wallpaper",
                      ),
                    ];
                  },
                )
              ],
            ),
          ),
          body: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: WillPopScope(
              child: Column(
                children: [
                  Expanded(
                    //height: MediaQuery.of(context).size.height - 180,
                    child: ListView.builder(
                      controller: _scrollcontroller,
                      shrinkWrap: true,
                      itemCount: messages.length + 1,
                      itemBuilder: (context, index) {
                        if (index == messages.length) {
                          return Container(
                            height: 70,
                          );
                        }
                        if (messages[index].type == "source") {
                          return ownMessageCard(
                            ownmessage: messages[index].message,
                            time: messages[index].time,
                          );
                        } else if (messages[index].type == "destination") {
                          return ReplyCard(
                            othermessage: messages[index].message,
                            time: messages[index].time,
                          );
                        }
                      },
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      //height: 70,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Row(
                            children: [
                              Container(
                                  width: MediaQuery.of(context).size.width - 65,
                                  child: Card(
                                    margin: EdgeInsets.only(
                                        left: 2, right: 2, bottom: 2),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(25),
                                    ),
                                    child: TextFormField(
                                      controller: _controller,

                                      //focusmode
                                      focusNode: focusnode,
                                      textAlignVertical:
                                          TextAlignVertical.center,
                                      keyboardType: TextInputType.multiline,
                                      maxLines: 5,
                                      minLines: 1,
                                      onChanged: (value) {
                                        print(value);
                                        if (value.length == 0) {
                                          setState(() {
                                            sendButton = false;
                                          });
                                        } else {
                                          setState(() {
                                            sendButton = true;
                                          });
                                        }
                                      },

                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                        hintText: "Type a message",
                                        prefixIcon: IconButton(
                                          icon: Icon(
                                            Icons.emoji_emotions,
                                          ),
                                          onPressed: () {
                                            setState(
                                              () {
                                                focusnode.unfocus();
                                                focusnode.canRequestFocus =
                                                    false;
                                                show = !show;
                                              },
                                            );
                                          },
                                        ),
                                        suffixIcon: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            IconButton(
                                              icon: Icon(Icons.attach_file),
                                              onPressed: () {
                                                showModalBottomSheet(
                                                  backgroundColor:
                                                      Colors.transparent,
                                                  context: context,
                                                  builder: (builder) =>
                                                      bottomsheet(),
                                                );
                                              },
                                            ),
                                            IconButton(
                                                onPressed: () {
                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (builder) =>
                                                              CameraPage()));
                                                },
                                                icon: Icon(Icons.camera_alt))
                                          ],
                                        ),
                                        contentPadding: EdgeInsets.all(5),
                                      ),
                                    ),
                                  )),
                              Padding(
                                padding: EdgeInsets.only(
                                  bottom: 8,
                                  right: 2,
                                  left: 2,
                                ),
                                child: CircleAvatar(
                                  radius: 25,
                                  backgroundColor: Color(0xFF128C7E),
                                  child: IconButton(
                                    icon: Icon(
                                        sendButton ? Icons.send : Icons.mic,
                                        color: Colors.white),
                                    onPressed: () {
                                      if (sendButton == true) {
                                        // print("pressed send");
                                        _scrollcontroller.animateTo(
                                            _scrollcontroller
                                                .position.maxScrollExtent,
                                            duration:
                                                Duration(milliseconds: 300),
                                            curve: Curves.easeOut);
                                        sendMessage(
                                          _controller.text,
                                          widget.sourcechat.id,
                                          widget.chatModel.id,
                                        );
                                        _controller.clear();
                                        setState(() {
                                          sendButton = false;
                                        });
                                      }
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                          show ? emojiSelect() : Container(),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              onWillPop: () {
                if (show) {
                  setState(
                    () {
                      show = false;
                    },
                  );
                } else {
                  Navigator.pop(context);
                }
                return Future.value(false);
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget emojiSelect() {
    return EmojiPicker(
        rows: 4,
        columns: 7,
        onEmojiSelected: (emoji, category) {
          print(emoji);
          setState(() {
            _controller.text = _controller.text + emoji.emoji;
          });
        });
  }

  Widget iconcreation(IconData icon, Color color, String text) {
    return InkWell(
      onTap: () {
        if (text == "Camera") {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (builder) => CameraPage()),
          );
        }
      },
      child: Column(
        children: [
          CircleAvatar(
            backgroundColor: color,
            radius: 30,
            child: Icon(
              icon,
              size: 29,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 5),
          Text(text,
              style: TextStyle(
                fontSize: 12,
              )),
        ],
      ),
    );
  }

  Widget bottomsheet() {
    return Container(
      height: MediaQuery.of(context).size.height - 500,
      width: MediaQuery.of(context).size.width,
      child: Card(
        margin: EdgeInsets.all(15),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  iconcreation(
                      Icons.insert_drive_file, Colors.indigo, "Document"),
                  SizedBox(width: 35),
                  iconcreation(Icons.camera_alt, Colors.pink, "Camera"),
                  SizedBox(width: 35),
                  iconcreation(Icons.insert_photo, Colors.purple, "Gallery"),
                  SizedBox(width: 35),
                ],
              ),
              SizedBox(height: 20),
              //row2
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  iconcreation(Icons.headset, Colors.orange, "Audio"),
                  SizedBox(width: 35),
                  iconcreation(Icons.location_pin, Colors.teal, "Location"),
                  SizedBox(width: 35),
                  iconcreation(Icons.person, Colors.blue, "Contact"),
                  SizedBox(width: 35),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
