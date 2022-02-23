import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:india_learner/blocs/PlusSessionsBloc.dart';
import 'package:india_learner/models/ClassesSessionListModel.dart';
import 'package:india_learner/models/PlusSessionModel.dart';
import 'package:india_learner/utils/Utils.dart';
import 'package:india_learner/views/VideoPlayerWidget.dart';

class PlusCoursesSession extends StatefulWidget {
  var courseId;

  PlusCoursesSession({this.courseId});

  PlusCoursesSessionState createState() => PlusCoursesSessionState(courseId: courseId);
}

class PlusCoursesSessionState extends State<PlusCoursesSession> {
  var courseId;

  PlusCoursesSessionState({this.courseId});

  @override
  Widget build(BuildContext context) {
    plusSessionBloc.fetchPlusSessions(courseId: courseId);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
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
        title: Text('plus courses session', style: TextStyle(fontSize: 20, color: Colors.black, fontWeight: FontWeight.w600)),
      ),
      body: Container(
          child: StreamBuilder(
              stream: plusSessionBloc.plusSessionStream,
              builder: (context, AsyncSnapshot<PlusSessionModel> snapshot) {
                if (snapshot.hasData) {
                  return Container(
                    margin: EdgeInsets.only(top: 10, left: 10, right: 5),
                    width: MediaQuery.of(context).size.width,
                    child: snapshot.data.plusSessionLiveList != null
                        ? ListView.builder(
                            itemCount: snapshot.data.plusSessionLiveList.length,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () async {
                                  VideoList videoList = VideoList();
                                  videoList.id = snapshot.data.plusSessionLiveList[index].id;
                                  videoList.title = snapshot.data.plusSessionLiveList[index].title;
                                  videoList.image = snapshot.data.plusSessionLiveList[index].image;
                                  videoList.courseName = snapshot.data.plusSessionLiveList[index].courseName;
                                  videoList.categoryId = snapshot.data.plusSessionLiveList[index].categoryId;
                                  videoList.subcategoryId = snapshot.data.plusSessionLiveList[index].subcategoryId;
                                  videoList.video = snapshot.data.plusSessionLiveList[index].link;

                                  snapshot.data.plusSessionLiveList[index].type == 'zoom' ? Utils.launchUrl(zoomLink: snapshot.data.plusSessionLiveList[index].link) : Get.to(VideoPlayerWidget(videoList: videoList));
                                },
                                child: Container(
                                  child: Column(
                                    children: [
                                      Container(
                                        height: 80,
                                        //
                                        //color: Colors.white,
                                        child: Row(children: [
                                          Expanded(
                                              flex: 2,
                                              child: ClipRRect(
                                                borderRadius: BorderRadius.all(Radius.circular(10)),
                                                child: Icon(
                                                  snapshot.data.plusSessionLiveList[index].type == 'zoom' ? Icons.live_tv_rounded : Icons.video_call_sharp,
                                                  size: 40,
                                                  color: Colors.cyan,
                                                ),
                                              )),
                                          Expanded(
                                              flex: 5,
                                              child: Padding(
                                                padding: EdgeInsets.only(left: 12),
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                      snapshot.data.plusSessionLiveList[index].title,
                                                      style: TextStyle(fontSize: 14, height: 1.3, color: Colors.black, fontWeight: FontWeight.w600),
                                                    ),
                                                    SizedBox(
                                                      height: 6,
                                                    ),
                                                    snapshot.data.plusSessionLiveList[index].type != "video"
                                                        ? Text.rich(TextSpan(
                                                            text: 'Duration:  ',
                                                            style: TextStyle(
                                                              fontSize: 13,
                                                              color: Colors.black87,
                                                              fontWeight: FontWeight.bold,
                                                            ),
                                                            children: <InlineSpan>[
                                                                TextSpan(
                                                                  text: snapshot.data.plusSessionLiveList[index].startTime + ' To ' + snapshot.data.plusSessionLiveList[index].endTime,
                                                                  style: TextStyle(
                                                                    fontSize: 11,
                                                                    color: Colors.black.withOpacity(0.6),
                                                                    fontWeight: FontWeight.bold,
                                                                  ),
                                                                )
                                                              ]))
                                                        : Container(),
                                                    SizedBox(
                                                      height: 6,
                                                    ),
                                                    Text.rich(TextSpan(
                                                        text: 'Type: ',
                                                        style: TextStyle(fontSize: 13, fontWeight: FontWeight.w800, color: Colors.black87),
                                                        children: <InlineSpan>[TextSpan(text: snapshot.data.plusSessionLiveList[index].type, style: TextStyle(fontSize: 12, color: Colors.black87.withOpacity(0.5), fontWeight: FontWeight.w800))]))
                                                  ],
                                                ),
                                              )),
                                          Expanded(
                                            flex: 1,
                                            child: Container(),
                                          )
                                        ]),
                                      ),
                                      Container(
                                        height: 1,
                                        width: Get.size.width / 1.1,
                                        color: Colors.black12,
                                      )
                                    ],
                                  ),
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
              })),
    );
  }
}
