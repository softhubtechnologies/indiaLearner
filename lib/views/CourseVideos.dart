import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:india_learner/blocs/ClassesSessionBloc.dart';
import 'package:india_learner/models/ClassesSessionListModel.dart';
import 'package:india_learner/networking/Repository.dart';
import 'package:india_learner/utils/Color.dart';
import 'package:india_learner/utils/Constants.dart';
import 'package:india_learner/utils/ThemeModel.dart';
import 'package:india_learner/utils/Utils.dart';
import 'package:india_learner/views/VideoPlayerWidget.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';

class CourseListWidget extends StatefulWidget {
  final courseId, type;

  CourseListWidget({this.courseId, this.type});

  CourseListWidgetState createState() => CourseListWidgetState(courseId: courseId, type: type);
}

class CourseListWidgetState extends State<CourseListWidget> {
  VideoPlayerController _controller;
  final courseId, type;

  CourseListWidgetState({this.courseId, this.type});

  Future<Map<String, dynamic>> futurevideos;
  //List<VideoList> videosList = [];
  String theme;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    setState(() {
      futurevideos = Repository.getVideos();
    });

    _controller = VideoPlayerController.network('http://oneroofcm.com/e_learning/uploads/testing.mp4')
      ..initialize().then((value) {
        setState(() {});
      });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    theme = Provider.of<ThemeModel>(context, listen: false).mode == ThemeMode.dark ? Constants.darkTheme : Constants.lightTheme;
    classesSessions.fetchClassesSession(courseId: courseId);
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
        title: Text(type == Constants.free ? 'Free classes & courses' : 'Classes & courses', style: TextStyle(fontSize: 20, color: Colors.black, fontWeight: FontWeight.w600)),
      ),
      body: SafeArea(
          child: Container(
              child: StreamBuilder(
        stream: classesSessions.getClassSessionStream,
        builder: (context, AsyncSnapshot<List<VideoList>> snapshot) {
          print("HAS ${snapshot.hasData}");
          if (snapshot.hasData) {
            List<VideoList> listSessions = snapshot.data;
            return Column(
              children: [
                Expanded(
                    flex: 6,
                    child: ListView.builder(
                        itemCount: listSessions.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                              onTap: () {
/*
                                Get.to(VideoPlayerWidget(
                                  videoList: listSessions[index],
                                ));
*/
//                                  _controller.value.isPlaying ? _controller.pause() : _controller.play();
                              },
                              child: Padding(
                                  padding: EdgeInsets.only(top: 22),
                                  child: Container(
                                      child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Column(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          Container(
                                              margin: EdgeInsets.only(top: 10, left: 14),
                                              height: 100,
                                              width: Get.size.width / 2.6,
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
                                              Text(
                                                listSessions[index].title,
                                                style: TextStyle(fontSize: 15, height: 2, color: Colors.cyan, fontWeight: FontWeight.w700),
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 6,
                                          ),
                                          Text(
                                            'Teacher name here',
                                            style: TextStyle(
                                              fontSize: 14,
                                              height: 1.2,
                                              color: theme == Constants.lightTheme ? Colors.black87 : Colors.white,
                                            ),
                                          ),
                                          SizedBox(
                                            height: 6,
                                          ),
                                          ButtonTheme(
                                            minWidth: Get.size.width / 2.5,
                                            child: RaisedButton(
                                              onPressed: () {
                                                Get.to(VideoPlayerWidget(
                                                  videoList: listSessions[index],
                                                ));
                                              },
                                              color: color.primaryColor,
                                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6.0)),
                                              child: Text(
                                                'watch now',
                                                style: TextStyle(fontSize: 15, color: Colors.white, fontWeight: FontWeight.w800),
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ],
                                  ))));
                        }))
              ],
            );
          } else if (snapshot.hasData == false) {
            return Utils.noData;
          } else {
            return Utils.loader;
          }
        },
      ))),
    );
  }

  void displayPopupDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
            child: Container(
              height: Get.size.height,
              width: Get.size.width,
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16.0)),
              child: Column(
                children: [
                  /*Container(
                      child: _controller.value.initialized
                          ? AspectRatio(
                              aspectRatio: _controller.value.aspectRatio,
                              child: VideoPlayer(_controller),
                            )
                          : Container()),*/
                  SizedBox(
                    height: 20,
                  ),
                  IconButton(
                      onPressed: () {
                        _controller.value.isPlaying ? _controller.pause() : _controller.play();
                      },
                      icon: Icon(
                        Icons.play_arrow,
                        color: Colors.red,
                      ))
                ],
              ),
            ),
          );
        });
  }
}
