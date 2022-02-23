import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:india_learner/blocs/CourseBloc.dart';
import 'package:india_learner/models/CourseListModel.dart';
import 'package:india_learner/utils/Color.dart';
import 'package:india_learner/utils/Constants.dart';
import 'package:india_learner/utils/Utils.dart';
import 'package:india_learner/views/FreeLiveClassListScreen.dart';

class PlusCourseListLive extends StatefulWidget {
  PlusCourseListLiveState createState() => PlusCourseListLiveState();
}

class PlusCourseListLiveState extends State<PlusCourseListLive> {
  String theme;

  @override
  Widget build(BuildContext context) {
    theme = MediaQuery.of(context).platformBrightness == Brightness.dark ? Constants.darkTheme : Constants.lightTheme;
    courseBloc.featchAllCourses();
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
        title: Text('Free live Plus courses', style: TextStyle(fontSize: 20, color: Colors.black, fontWeight: FontWeight.w600)),
      ),
      body: Container(
        // color: Colors.white,
        child: Column(
          children: [
            Expanded(
                child: StreamBuilder(
              stream: courseBloc.courseFetcher,
              builder: (context, AsyncSnapshot<List<CourseList>> snapshot) {
                if (snapshot.hasData) {
                  //  listCourse = snapshot.data;
                  return snapshot.data.length > 0
                      ? ListView.builder(
                          itemCount: snapshot.data.length,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () async {
                                Get.to(FreeLiveClassListScreen(
                                  courseId: snapshot.data[index].courseId,
                                ));

                                //Get.to(CourseListWidget());
                              },
                              child: snapshot.data[index].isFree == '2'
                                  ? Container(
                                      child: Column(
                                        children: [
                                          GestureDetector(
                                            child: Container(
                                              height: 80,
                                              //
                                              //color: Colors.white,
                                              child: Row(children: [
                                                Expanded(
                                                    flex: 3,
                                                    child: ClipRRect(
                                                      borderRadius: BorderRadius.all(Radius.circular(10)),
                                                      child: snapshot.data[index].file != null
                                                          ? Image.network(
                                                              snapshot.data[index].file,
                                                              height: 80,
                                                              width: 90,
                                                            )
                                                          : Image.asset(
                                                              'assets/images/download.jpg',
                                                              height: 50,
                                                              //fit: BoxFit.cover,
                                                              scale: 0.8,
                                                              width: 40,
                                                            ),
                                                    )),
                                                Expanded(
                                                    flex: 5,
                                                    child: Column(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                      children: [
                                                        Text(
                                                          snapshot.data[index].courseName,
                                                          style: TextStyle(fontSize: 14, height: 1.3, color: Colors.black, fontWeight: FontWeight.w600),
                                                        ),
                                                        Text(
                                                          snapshot.data[index].startDate,
                                                          style: TextStyle(fontSize: 14, height: 1.3, color: Colors.black, fontWeight: FontWeight.w600),
                                                        )
                                                      ],
                                                    )),
                                                Expanded(
                                                  flex: 1,
                                                  child: Container(),
                                                )
                                              ]),
                                            ),
                                          ),
                                          Container(
                                            height: 1,
                                            width: Get.size.width / 1.1,
                                            color: Colors.black12,
                                          )
                                        ],
                                      ),
                                    )
                                  : Container(),
                            );
                          })
                      : Utils.noData;
                } else if (snapshot.connectionState == ConnectionState.waiting) {
                  return Utils.loader;
                } else {
                  return Utils.noData;
                }
              },
            )),
          ],
        ),
      ),
    );
  }
}
