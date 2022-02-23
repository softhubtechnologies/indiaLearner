import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:india_learner/blocs/MessageReplyListBloc.dart';
import 'package:india_learner/blocs/MessageSendBloc.dart';
import 'package:india_learner/models/message_reply_list_model.dart';
import 'package:india_learner/utils/Color.dart';
import 'package:india_learner/utils/Constants.dart';
import 'package:india_learner/utils/ToastMessage.dart';
import 'package:india_learner/utils/Utils.dart';
import 'package:intl/intl.dart';

class MessagePage extends StatefulWidget {
  String teacherId;

  MessagePage({this.teacherId});

  MessagePageState createState() => MessagePageState(teacherId: teacherId);
}

class MessagePageState extends State<MessagePage> {
  String theme;
  String teacherId;

  MessagePageState({this.teacherId});

  TextEditingController msgCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    theme = MediaQuery.of(context).platformBrightness == Brightness.dark ? Constants.darkTheme : Constants.lightTheme;
    messageReplyBloc.getMessages();
    return Scaffold(
      body: Scaffold(
        backgroundColor: Colors.grey.shade50,
        appBar: AppBar(
          backgroundColor: theme == Constants.lightTheme ? Colors.white : color.darkAppBar,
          automaticallyImplyLeading: false,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back_outlined,
              color: Colors.black87,
            ),
            onPressed: () {
              Get.back();
            },
          ),
          title: Text('Message to teacher', style: TextStyle(fontSize: 20, color: Colors.black, fontWeight: FontWeight.w600)),
        ),
        bottomNavigationBar: Container(
            padding: EdgeInsets.only(bottom: 12, left: 10),
            width: MediaQuery.of(context).size.width,
            child: Row(
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width / 1.2,
                  height: 45,
                  child: TextField(
                    controller: msgCtrl,
                    decoration: InputDecoration(hintText: "Type a message", border: OutlineInputBorder(borderSide: BorderSide(width: 1, color: Colors.black45))),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send),
                  onPressed: () {
                    DateFormat dateFormat = DateFormat("yyyy-MM-dd");
                    DateFormat dateFormatTime = DateFormat("hh:mm");
                    DateTime dateTime = DateTime.now();

                    messageSendBloc.sendMessage(message: msgCtrl.text, date: dateFormat.format(dateTime).toString(), time: dateFormatTime.format(dateTime), teacherId: teacherId);

                    messageSendBloc.messageSendStream.listen((event) {
                      if (event.statusCode == "200") {
                        ToastMessage.showToast(message: "sent", type: true);
                        print("RESPONSE  ${event.statusCode}");
                        messageReplyBloc.getMessages();
                        msgCtrl.text = "";
                      }
                    });
                  },
                )
              ],
            )),
        body: StreamBuilder(
          stream: messageReplyBloc.messageReplyListStream,
          builder: (context, AsyncSnapshot<MessageReplyListModel> snapshot) {
            if (snapshot.hasData) {
              return Container(
                margin: EdgeInsets.only(top: 10),
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: snapshot.data.messageList != null
                    ? ListView.builder(
                        itemCount: snapshot.data.messageList.length,
                        itemBuilder: (context, index) {
                          return Container(
                            padding: EdgeInsets.only(left: 10, top: 4),
                            margin: EdgeInsets.only(left: 12, right: 12, top: 12),
                            width: MediaQuery.of(context).size.width / 2,
                            height: 70,
                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(8.0), color: Colors.white),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                GestureDetector(
                                  child: Padding(
                                    padding: EdgeInsets.only(right: 10),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          snapshot.data.messageList[index].firstName,
                                          style: GoogleFonts.poppins(fontSize: 13, color: Colors.black87, fontWeight: FontWeight.w700),
                                        ),
                                        Text(
                                          snapshot.data.messageList[index].replyList.isNotEmpty ? snapshot.data.messageList[index].replyList.length.toString() + " Replies" : "0 Replies",
                                          style: GoogleFonts.poppins(fontSize: 12, color: Colors.black87, fontWeight: FontWeight.w500),
                                        )
                                      ],
                                    ),
                                  ),
                                  onTap: () {
                                    print("REPLYS${snapshot.data.messageList[index].replyList.isEmpty}");
                                    showRepliesDialog(snapshot.data.messageList[index].replyList, index);
                                  },
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: 20, top: 4),
                                  child: Text(
                                    snapshot.data.messageList[index].message,
                                    style: GoogleFonts.poppins(fontSize: 12, color: Colors.black87, fontWeight: FontWeight.w600),
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(right: 8, bottom: 2),
                                      child: Text(
                                        snapshot.data.messageList[index].date + "   " + snapshot.data.messageList[index].time,
                                        style: GoogleFonts.poppins(fontSize: 10, color: Colors.black87, fontWeight: FontWeight.w500),
                                      ),
                                    )
                                  ],
                                )
                              ],
                            ),
                          );
                        })
                    : Utils.noData,
              );
            } else if (snapshot.connectionState == ConnectionState.waiting) {
              return Utils.loader;
            } else {
              return Utils.noData;
            }
          },
        ),
      ),
    );
  }

  void showRepliesDialog(List<Reply_list> replyList, int index) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Material(
            child: Container(
              color: Colors.white,
              height: MediaQuery.of(context).size.height / 1.2,
              width: MediaQuery.of(context).size.width / 1.2,
              child: Column(
                children: [
                  Flexible(
                      flex: 2,
                      child: Padding(
                        padding: EdgeInsets.only(left: 10, right: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Replies",
                              style: GoogleFonts.poppins(fontSize: 14, color: Colors.black, fontWeight: FontWeight.w800),
                            ),
                            IconButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                icon: Icon(
                                  Icons.clear,
                                  size: 30,
                                  color: Colors.black,
                                ))
                          ],
                        ),
                      )),
                  Flexible(
                    flex: 8,
                    child: Container(
                      color: Colors.grey.shade50,
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height / 1.2,
                      child: replyList.length > 0
                          ? Padding(
                              padding: EdgeInsets.only(top: 10),
                              child: ListView.builder(
                                  itemCount: replyList.length,
                                  itemBuilder: (context, position) {
                                    return Container(
                                      padding: EdgeInsets.all(10),
                                      margin: EdgeInsets.only(left: 10, right: 10, bottom: 10),
                                      width: MediaQuery.of(context).size.width / 1.1,
                                      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8.0)),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              Text(
                                                replyList[index].name,
                                                style: GoogleFonts.poppins(fontSize: 14, color: Colors.black, fontWeight: FontWeight.w600),
                                              )
                                            ],
                                          ),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                replyList[index].reply,
                                                style: GoogleFonts.poppins(fontSize: 13, color: Colors.black, fontWeight: FontWeight.w500),
                                              )
                                            ],
                                          ),
                                        ],
                                      ),
                                    );
                                  }),
                            )
                          : Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [Utils.noData],
                            ),
                    ),
                  )
                ],
              ),
            ),
          );
        });
  }
}
