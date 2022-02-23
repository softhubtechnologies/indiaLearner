import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:india_learner/blocs/HelpAndSupportPostBloc.dart';
import 'package:india_learner/blocs/HelpMessageBloc.dart';
import 'package:india_learner/models/HelpSupportListResponseModel.dart';
import 'package:india_learner/utils/Color.dart';
import 'package:india_learner/utils/Constants.dart';
import 'package:india_learner/utils/ToastMessage.dart';
import 'package:india_learner/utils/Utils.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

class HelpandSupport extends StatefulWidget {
  HelpandSupportState createState() => HelpandSupportState();
}

class HelpandSupportState extends State<HelpandSupport> {
  String theme;
  TextEditingController textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    helpMessagesBloc.getHelpSupportList();
    theme = MediaQuery.of(context).platformBrightness == Brightness.dark ? Constants.darkTheme : Constants.lightTheme;
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(
        backgroundColor: theme == Constants.lightTheme ? Colors.white : color.darkAppBar,
        elevation: 4,
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: theme == Constants.lightTheme ? Colors.black87 : Colors.white,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          "Help & support",
          style: TextStyle(fontSize: 15, color: theme == Constants.lightTheme ? Colors.black87 : color.darkText),
        ),
      ),
      body: Container(
        width: Get.size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Expanded(
                  flex: 2,
                  child: GestureDetector(
                    child: Container(
                      margin: EdgeInsets.only(left: 10, right: 10),
                      color: color.primaryColor.withOpacity(0.1),
                      height: 160,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.call,
                            size: 30,
                            color: Colors.black87,
                          ),
                          Text(
                            "Call us",
                            style: GoogleFonts.poppins(fontSize: 14, color: Colors.black87, fontWeight: FontWeight.w500),
                          )
                        ],
                      ),
                    ),
                    onTap: () async {
                      await launch("tel://8178241337");
                    },
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: GestureDetector(
                    child: Container(
                      margin: EdgeInsets.only(left: 10, right: 10),
                      color: color.primaryColor.withOpacity(0.1),
                      height: 160,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.mail_rounded,
                            size: 30,
                            color: Colors.black87,
                          ),
                          Text(
                            "Email us",
                            style: GoogleFonts.poppins(fontSize: 14, color: Colors.black87, fontWeight: FontWeight.w500),
                          )
                        ],
                      ),
                    ),
                    onTap: () async {
                      await launch("mailto://denykuntal@gmail.com");
                    },
                  ),
                )
              ],
            ),
            SizedBox(
              height: 20,
            ),
            SizedBox(
              width: Get.size.width / 1.2,
              child: TextFormField(
                controller: textEditingController,
                autofocus: false,
                decoration: InputDecoration(
                  hintText: 'Type a message',
                  errorStyle: Utils.errorHeight,
                  enabledBorder: Utils.textFieldBorder,
                  focusedErrorBorder: Utils.errorBorder,
                  focusedBorder: Utils.textFieldBorder,
                  errorBorder: Utils.errorBorder,
                  disabledBorder: Utils.textFieldBorder,
                  helperText: ' ',
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                SizedBox(
                  height: 46,
                  width: MediaQuery.of(context).size.width / 4,
                  child: RaisedButton(
                    onPressed: () {
                      DateTime dateTime = DateTime.now();
                      DateTime time = DateTime.now();

                      DateFormat dateFormat = DateFormat(
                        "yyyy-MM-dd",
                      );
                      DateFormat timeFormat = DateFormat(
                        "HH:MM",
                      );

                      if (textEditingController.text.length > 0) {
                        helpAndSupportBloc.postHelp(message: textEditingController.text, date: dateFormat.format(dateTime), time: dateFormat.format(time));

                        helpAndSupportBloc.helpAndSupportStream.listen((event) {
                          if (event.statusCode == "200") {
                            print("MSGGGGG ${event}");
                            ToastMessage.showToast(message: "Sent", type: true);
                          }
                        });
                      } else {
                        ToastMessage.showToast(message: "Please type a message", type: false);
                      }
                    },
                    child: Text(
                      "Send",
                      style: TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.w800),
                    ),
                    color: Colors.cyan,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
                  ),
                ),
                SizedBox(
                  width: 32,
                )
              ],
            ),
            Expanded(
                child: StreamBuilder(
              stream: helpMessagesBloc.helpListStream,
              builder: (context, AsyncSnapshot<HelpSupportListResponseModel> snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                      itemCount: snapshot.data.messageList.length,
                      itemBuilder: (context, index) {
                        return Container(
                          height: 80,
                          margin: EdgeInsets.only(left: 10, right: 10, top: 10),
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(8.0), color: Colors.white),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Row(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      GestureDetector(
                                        child: Text(
                                          "Replies " + snapshot.data.messageList[index].replyList.length.toString(),
                                          style: GoogleFonts.poppins(fontSize: 10, color: Colors.black87),
                                        ),
                                        onTap: () {
                                          showRepliesDialog(snapshot.data.messageList[index].replyList, index);
                                        },
                                      )
                                    ],
                                  )
                                ],
                              ),
                              Text(
                                snapshot.data.messageList[index].message,
                                style: GoogleFonts.poppins(fontSize: 14, color: Colors.black87),
                              ),
                              Padding(
                                padding: EdgeInsets.only(right: 14),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Text(
                                      snapshot.data.messageList[index].date + "   " + snapshot.data.messageList[index].time,
                                      style: GoogleFonts.poppins(fontSize: 10, color: Colors.black87),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        );
                      });
                } else if (snapshot.connectionState == ConnectionState.waiting) {
                  return Utils.loader;
                } else {
                  return Utils.noData;
                }
              },
            ))
          ],
        ),
      ),
    );
  }

  void showRepliesDialog(List<ReplyList> replyList, int index) {
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
                                                replyList[position].reply,
                                                style: GoogleFonts.poppins(fontSize: 14, color: Colors.black, fontWeight: FontWeight.w600),
                                              )
                                            ],
                                          ),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                replyList[position].messageId,
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
