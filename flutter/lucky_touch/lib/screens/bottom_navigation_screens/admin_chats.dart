import 'package:flutter/material.dart';

import 'package:chat_bubbles/chat_bubbles.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:lucky_touch/providers/model_admin_chats.dart';


import 'package:provider/provider.dart';

class AdminChats extends StatefulWidget {
  AdminChats({Key? key, required this.usersId, required this.userName})
      : super(key: key);
  int usersId;
  String userName;
  @override
  State<AdminChats> createState() => _AdminChatsState();
}

class _AdminChatsState extends State<AdminChats> {
  DateTime now = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Colors.black,
          image: DecorationImage(
              colorFilter: new ColorFilter.mode(
                  Colors.black.withOpacity(0.2), BlendMode.dstATop),
              fit: BoxFit.cover,
              image: AssetImage('assets/images/inside_wallaper.jpg'))
          // gradient: LinearGradient(
          //   begin: Alignment.topLeft,
          //   end: Alignment.bottomRight,
          //   colors: [Colors.pinkAccent, Colors.deepPurpleAccent, Colors.red],
          //   // colors: [Colors.blue, Colors.blueAccent, Colors.cyanAccent],
          // ),
          ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(60.0),
          child: AppBar(
            elevation: 0,
            backgroundColor: Colors.amber.withOpacity(0.2),
            centerTitle: true,
            shape: ContinuousRectangleBorder(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(100),
                bottomRight: Radius.circular(100),
              ),
            ),
            title: Text(
              '${widget.userName}',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.only(top: 10, bottom: 20),
          child: FutureBuilder(
            future:
                context.read<ModelAdminChats>().getUsersChats(widget.usersId),
            builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
              var item = context.watch<ModelAdminChats>().chatModel?.data;
              if (snapshot.data != null && item!.length >= 0) {
                return Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                          controller:
                              context.watch<ModelAdminChats>().controller,
                          itemCount: item.length,
                          itemBuilder: ((context, index) {
                            return item[index]!.isSender == 0
                                ? Bubble(
                                    text: item[index]?.msg ?? '',
                                    isSender: true,
                                    fontColor: Colors.black,
                                    backgroundColor:
                                        Colors.white.withOpacity(0.5))
                                : Bubble(
                                    text: item[index]?.msg ?? '',
                                    isSender: false,
                                    fontColor: Colors.white,
                                    backgroundColor:
                                        Colors.amber.withOpacity(0.3));
                          })),
                    ),
                    MessageBar(
                      messageBarColor: Colors.transparent,
                      sendButtonColor: Colors.white,
                      onSend: (_) async {
                        await context
                            .read<ModelAdminChats>()
                            .sendMessage(widget.usersId, _, '0');
                        print('usersId2' + '${widget.usersId}');
                        // await context.read<ModelAdminChats>().updateChattedUsers(_);
                      },
                      // actions: [
                      //   InkWell(
                      //     child: Icon(
                      //       Icons.add,
                      //       color: Colors.black,
                      //       size: 24,
                      //     ),
                      //     onTap: () {},
                      //   ),
                      //   Padding(
                      //     padding: EdgeInsets.only(left: 8, right: 8),
                      //     child: InkWell(
                      //       child: Icon(
                      //         Icons.camera_alt,
                      //         color: Colors.green,
                      //         size: 24,
                      //       ),
                      //       onTap: () {},
                      //     ),
                      //   ),
                      // ],
                    ),
                  ],
                );
              } else {
                return SpinKitWave(
                  color: Colors.amberAccent,
                  size: 80,
                );
              }
            },
          ),
        ),
      ),
    );
  }

  BubbleSpecialOne Bubble(
      {required String text,
      required bool isSender,
      required Color fontColor,
      required Color backgroundColor}) {
    return BubbleSpecialOne(
      text: text,
      isSender: isSender,
      color: backgroundColor,
      tail: true,
      textStyle: TextStyle(fontSize: 16, color: fontColor),
    );
  }
}
