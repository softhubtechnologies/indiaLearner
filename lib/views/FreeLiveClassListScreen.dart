import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:india_learner/blocs/LiveSessionBloc.dart';
import 'package:india_learner/models/LiveSessionListModel.dart';
import 'package:india_learner/utils/Color.dart';
import 'package:india_learner/utils/Constants.dart';
import 'package:india_learner/utils/ThemeModel.dart';
import 'package:india_learner/utils/Utils.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class FreeLiveClassListScreen extends StatefulWidget {
  String courseId;

  FreeLiveClassListScreen({this.courseId});

  FreeLiveClassListScreenState createState() => FreeLiveClassListScreenState(courseId: courseId);
}

class FreeLiveClassListScreenState extends State<FreeLiveClassListScreen> {
  String theme;
  String courseId;

  FreeLiveClassListScreenState({this.courseId});

  @override
  Widget build(BuildContext context) {
    theme = Provider.of<ThemeModel>(context, listen: false).mode == ThemeMode.dark ? Constants.darkTheme : Constants.lightTheme;
    liveSessionBloc.fetchAllLiveSessions(courseId: courseId);
    return Scaffold(
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
        title: Text('Live sessions', style: TextStyle(fontSize: 20, color: Colors.black, fontWeight: FontWeight.w600)),
      ),
      body: SafeArea(
          child: Container(
        child: StreamBuilder(
          stream: liveSessionBloc.sessionFetcher,
          builder: (context, AsyncSnapshot<List<LiveList>> snapshot) {
            if (snapshot.hasData) {
              print("LOSDING ${snapshot.connectionState}");
              List<LiveList> sessionList = snapshot.data;
              return Column(
                children: [
                  Expanded(
                      flex: 6,
                      child: sessionList != null
                          ? ListView.builder(
                              itemCount: sessionList.length,
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                    onTap: () {
                                      launchUrl(sessionList[index].zoomId);
                                    },
                                    child: Padding(
                                        padding: EdgeInsets.only(top: 22),
                                        child: Container(
                                            color: Colors.white,
                                            child: Row(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Column(
                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                  children: [
                                                    Container(
                                                        margin: EdgeInsets.only(top: 10, left: 14),
                                                        height: 65,
                                                        width: 80,
                                                        decoration: BoxDecoration(
                                                          borderRadius: BorderRadius.circular(8.0),
                                                          color: Colors.cyan.withOpacity(0.3),
                                                        ),
                                                        child: Center(child: Image.asset('assets/images/download.jpg')))
                                                  ],
                                                ),
                                                SizedBox(
                                                  width: 18,
                                                ),
                                                Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Row(
                                                      children: [
                                                        SizedBox(
                                                          width: 10,
                                                        ),
                                                        Text(
                                                          sessionList[index].title != null ? sessionList[index].title : "",
                                                          style: TextStyle(fontSize: 15, height: 2, color: Colors.cyan, fontWeight: FontWeight.w700),
                                                        ),
                                                      ],
                                                    ),
                                                    SizedBox(
                                                      height: 2,
                                                    ),
                                                    Container(
                                                      width: MediaQuery.of(context).size.width / 2,
                                                      child: Text(
                                                        'Time: ' + sessionList[index].startTime + ' ' + sessionList[index].endTime,
                                                        style: TextStyle(fontSize: 14, height: 1.4, color: theme == Constants.lightTheme ? Colors.black87 : Colors.white, fontWeight: FontWeight.w700),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: 6,
                                                    ),
                                                    Row(
                                                      children: [
                                                        Text(
                                                          'Date: ',
                                                          style: TextStyle(fontSize: 14, height: 1.2, color: theme == Constants.lightTheme ? Colors.black87 : Colors.white, fontWeight: FontWeight.w600),
                                                        ),
                                                        Text(
                                                          sessionList[index].date,
                                                          style: TextStyle(fontSize: 14, color: theme == Constants.lightTheme ? Colors.black87 : Colors.white, fontWeight: FontWeight.w400),
                                                        ),
                                                      ],
                                                    ),
                                                    Text(
                                                      'Teacher name here',
                                                      style: TextStyle(
                                                        fontSize: 14,
                                                        height: 1.2,
                                                        color: theme == Constants.lightTheme ? Colors.black87 : Colors.white,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ))));
                              })
                          : Center(
                              child: Utils.noData,
                            ))
                ],
              );
            } else if (snapshot.connectionState == ConnectionState.waiting) {
              print("LOSDING ${snapshot.connectionState}");
              return Utils.loader;
            } else {
              print("LOSDING ${snapshot.connectionState}");
              return Utils.noData;
            }
          },
        ),
      )),
    );
  }

  void launchUrl(String meetingUrl) async {
    await await launch(meetingUrl);
    //await canLaunch("") ? await launch("https://mail.google.com/mail/") : throw 'Could not launch';
  }
}
