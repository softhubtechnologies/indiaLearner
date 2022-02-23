import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:india_learner/blocs/BatchBloc.dart';
import 'package:india_learner/blocs/CourseBloc.dart';
import 'package:india_learner/blocs/TeachersBloc.dart';
import 'package:india_learner/models/BatchModel.dart';
import 'package:india_learner/models/CourseListModel.dart';
import 'package:india_learner/models/TeacherListModel.dart';
import 'package:india_learner/networking/ApiHandler.dart';
import 'package:india_learner/networking/ApiProvider.dart';
import 'package:india_learner/networking/EndApi.dart';
import 'package:india_learner/utils/Constants.dart';
import 'package:india_learner/utils/ThemeModel.dart';
import 'package:india_learner/utils/Utils.dart';
import 'package:india_learner/utils/database.dart';
import 'package:india_learner/views/SubscriptionPage.dart';
import 'package:india_learner/views/TeachersDetails.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import 'CourseVideos.dart';

class BrowseNav extends StatefulWidget {
  BrowseNavState createState() => BrowseNavState();
}

class BrowseNavState extends State<BrowseNav> {
  List<TeacherList> listTeachers = [];
  List<CourseList> listCourse = [];
  Future<List<CourseList>> futureCourse;
  Future<List<TeacherList>> futureTeachers;
  Duration duration;
  String categoryName;
  @override
  void initState() {
    // TODO: implement initState

    super.initState();
    categoryName = Database.getSelectedCategory();
    getJson();
    //getTeachers();
  }

  String theme;

  @override
  Widget build(BuildContext context) {
    theme = Provider.of<ThemeModel>(context, listen: false).mode == ThemeMode.dark ? Constants.darkTheme : Constants.lightTheme;
    teachersBloc.featchAllTeacher();
    courseBloc.featchAllCourses();
    batchBloc.getBatches();

    return Scaffold(
      body: SingleChildScrollView(
        child: IntrinsicHeight(
          child: Container(
            //  color: theme == Constants.lightTheme ? Colors.white : Colors.black,
            height: Get.size.height + 70,
            width: Get.size.width,
            // padding: EdgeInsets.only(left: 20, top: 20, right: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [Expanded(flex: 1, child: getTeachersList()), /*Expanded(flex: 1, child: getOngoingBatchesList()),*/ Expanded(flex: 1, child: getOnGoingCoursesList()), Expanded(flex: 1, child: getUpcomingCourses()), Expanded(flex: 1, child: getCompletedCourses())],
            ),
          ),
        ),
      ),
    );
  }

  void getJson() async {
    var jsonText = await rootBundle.loadString('assets/jsonassets/browseJson');
    print("jsonText ${jsonText}");
    var map = json.decode(jsonText);
    setState(() {
      //listTeachers = map['list'];
    });
    print("jsonText jsonText${listTeachers.toString()}");
  }

  void getTeachers() {
    ApiHandler.getApi(baseUrl: ApiProvider.baseUrl, endApi: EndApi.teachersList).then((value) {
      print("VALUE ${value.toString()}");
      if (value['status_code'] == '200')
        setState(() {
          listTeachers = TeacherListModel.fromJson(value).teacherList;
        });
    });
  }

  getTeachersList() {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(padding: EdgeInsets.only(left: 15, top: 20), child: Text(categoryName + '- Educator/ Teacher', style: TextStyle(fontSize: 16, color: theme == Constants.lightTheme ? Colors.black : Colors.white, fontWeight: FontWeight.w800))),
          SizedBox(
            height: 10,
          ),
          Expanded(
            flex: 2,
            child: StreamBuilder(
                stream: teachersBloc.teacherFetacher,
                builder: (context, AsyncSnapshot<List<TeacherList>> snapshot) {
                  if (snapshot.hasData == false) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else {
                    print("RESSSS ${snapshot.data}");

                    listTeachers = snapshot.data;

                    return listTeachers != null
                        ? Container(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  flex: 2,
                                  child: listTeachers != null
                                      ? ListView.builder(
                                          scrollDirection: Axis.horizontal,
                                          itemCount: (listTeachers.length),
                                          itemBuilder: (context, index) {
                                            return GestureDetector(
                                              onTap: () {
                                                Get.to(TeachersDetails(
                                                  teacherList: listTeachers[index],
                                                ));
                                              },
                                              child: Container(
                                                width: 140,
                                                margin: EdgeInsets.only(left: 10),
                                                height: 100,
                                                decoration: BoxDecoration(borderRadius: BorderRadius.circular(8.0), border: Border.all(width: 1, color: Colors.black12)),
                                                child: Column(
                                                  children: [
                                                    Expanded(
                                                        flex: 3,
                                                        child: listTeachers[index].file == null || listTeachers[index].file == ''
                                                            ? Image.asset(
                                                                'assets/images/teachers.jpg',
                                                                //height: 90,
                                                                fit: BoxFit.contain,
                                                                width: 120,
                                                              )
                                                            : Image.network(listTeachers[index].file)),
                                                    Container(
                                                      height: 1,
                                                      color: Colors.black12,
                                                    ),
                                                    SizedBox(
                                                      height: 8,
                                                    ),
                                                    Expanded(flex: 1, child: Text(listTeachers[index].name, overflow: TextOverflow.ellipsis, style: TextStyle(fontSize: 14, color: theme == Constants.lightTheme ? Colors.black : Colors.white, fontWeight: FontWeight.w500)))
                                                  ],
                                                ),
                                              ),
                                            );
                                          })
                                      : Center(
                                          child: Text('No data'),
                                        ),
                                ),
                              ],
                            ),
                          )
                        : Center(
                            child: Text('No data'),
                          );
                  }
                }),
          ),
        ],
      ),
    );
  }

  getOngoingBatchesList() {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(padding: EdgeInsets.only(left: 15, top: 20), child: Text(categoryName + '- Batches ongoing', style: TextStyle(fontSize: 16, color: theme == Constants.lightTheme ? Colors.black : Colors.white, fontWeight: FontWeight.w800))),
          SizedBox(
            height: 10,
          ),
          Expanded(
            flex: 2,
            child: StreamBuilder(
              stream: batchBloc.batchStream,
              builder: (context, AsyncSnapshot<List<BatchList>> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (snapshot.hasData) {
                  print("RESSSS ${snapshot.data}");

                  List<BatchList> batchList = snapshot.data;
                  return batchList != null
                      ? Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                flex: 2,
                                child: batchList.length > 0
                                    ? ListView.builder(
                                        scrollDirection: Axis.horizontal,
                                        itemCount: (batchList.length),
                                        itemBuilder: (context, index) {
                                          DateFormat formater = DateFormat('yyyy-MM-dd');

                                          DateTime now = DateTime.now();

                                          return now.isAfter(DateTime.parse(listCourse[index].startDate)) && now.isBefore(DateTime.parse(listCourse[index].endDate))
                                              ? GestureDetector(
                                                  onTap: () {},
                                                  child: Container(
                                                    width: 140,
                                                    margin: EdgeInsets.only(left: 10),
                                                    height: 100,
                                                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(8.0), border: Border.all(width: 1, color: Colors.black12)),
                                                    child: Column(
                                                      children: [
                                                        Expanded(
                                                            flex: 3,
                                                            child: Image.asset(
                                                              'assets/images/download.jpg',
                                                              //height: 90,
                                                              fit: BoxFit.contain,
                                                              width: 120,
                                                            )),
                                                        Container(
                                                          height: 1,
                                                          color: Colors.black12,
                                                        ),
                                                        SizedBox(
                                                          height: 8,
                                                        ),
                                                        Expanded(flex: 1, child: Text(batchList[index].batchName, style: TextStyle(fontSize: 14, color: theme == Constants.lightTheme ? Colors.black : Colors.white, fontWeight: FontWeight.w500)))
                                                      ],
                                                    ),
                                                  ),
                                                )
                                              : Container();
                                        })
                                    : Center(
                                        child: Text('No data'),
                                      ),
                              ),
                            ],
                          ),
                        )
                      : Center(
                          child: Text('No data'),
                        );
                } else {
                  return Utils.noData;
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  getOnGoingCoursesList() {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(padding: EdgeInsets.only(left: 15, top: 20), child: Text(categoryName + '- Courses ongoing', style: TextStyle(fontSize: 16, color: theme == Constants.lightTheme ? Colors.black : Colors.white, fontWeight: FontWeight.w800))),
          SizedBox(
            height: 10,
          ),
          Expanded(
            flex: 2,
            child: StreamBuilder(
              stream: courseBloc.courseFetcher,
              builder: (context, AsyncSnapshot<List<CourseList>> snapshot) {
                if (snapshot.hasData == false) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  listCourse = snapshot.data;
                  if (listCourse != null) {
                    return Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            flex: 2,
                            child: listCourse.length > 0
                                ? ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemCount: (listCourse.length),
                                    itemBuilder: (context, index) {
                                      DateFormat formater = DateFormat('yyyy-MM-dd');

                                      DateTime now = DateTime.now();
                                      print("DIFFF isAfter ${now.isAfter(DateTime.parse(listCourse[index].startDate))}");
                                      print("DIFFF isBefore ${now.isBefore(DateTime.parse(listCourse[index].endDate))}");
                                      print("TTTTTTTTTTTTTTT ${now.isAfter(DateTime.parse(listCourse[index].startDate)) && now.isBefore(DateTime.parse(listCourse[index].endDate))}");

                                      return /*now.isAfter(DateTime.parse(listCourse[index].startDate)) && now.isBefore(DateTime.parse(listCourse[index].endDate))*/
                                          listCourse[index].courseStatus == Constants.ongoing
                                              ? GestureDetector(
                                                  onTap: () {
                                                    listCourse[index].isPurchase == 1
                                                        ? Get.to(CourseListWidget(
                                                            courseId: listCourse[index].courseId,
                                                            type: Constants.paid,
                                                          ))
                                                        : Get.to(SubscriptionPage());
                                                  },
                                                  child: Container(
                                                    width: 140,
                                                    margin: EdgeInsets.only(left: 10),
                                                    height: 100,
                                                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(8.0), border: Border.all(width: 1, color: Colors.black12)),
                                                    child: Column(
                                                      children: [
                                                        Expanded(
                                                            flex: 3,
                                                            child: listCourse[index].file == null || listCourse[index].file == ''
                                                                ? Image.asset(
                                                                    'assets/images/teachers.jpg',
                                                                    //height: 90,
                                                                    fit: BoxFit.contain,
                                                                    width: 120,
                                                                  )
                                                                : Image.network(listCourse[index].file)),
                                                        Container(
                                                          height: 1,
                                                          color: Colors.black12,
                                                        ),
                                                        SizedBox(
                                                          height: 8,
                                                        ),
                                                        Expanded(flex: 1, child: Text(listCourse[index].courseName, overflow: TextOverflow.ellipsis, style: TextStyle(fontSize: 14, color: theme == Constants.lightTheme ? Colors.black : Colors.white, fontWeight: FontWeight.w500)))
                                                      ],
                                                    ),
                                                  ),
                                                )
                                              : Container();
                                    })
                                : Center(
                                    child: Text('No data'),
                                  ),
                          ),
                        ],
                      ),
                    );
                  } else {
                    return Center(
                      child: Utils.noData,
                    );
                  }
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  getUpcomingCourses() {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(padding: EdgeInsets.only(left: 15, top: 20), child: Text(categoryName + '- Upcoming courses', style: TextStyle(fontSize: 16, color: theme == Constants.lightTheme ? Colors.black : Colors.white, fontWeight: FontWeight.w800))),
          SizedBox(
            height: 10,
          ),
          Expanded(
              flex: 2,
              child: StreamBuilder(
                stream: courseBloc.courseFetcher,
                builder: (context, AsyncSnapshot<List<CourseList>> snapshot) {
                  if (snapshot.hasData == false) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else {
                    print("RESSSS ${snapshot.data}");
                    listCourse = snapshot.data;
                    if (listCourse != null) {
                      return Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              flex: 2,
                              child: listCourse.length > 0
                                  ? ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      itemCount: (listCourse.length),
                                      itemBuilder: (context, index) {
                                        //int durationDiff = DateTime.now().difference(DateTime.now().add(Duration(days: 5)) /*DateTime.parse(listCourse[index].startDate)*/).inDays;
                                        int durationDiff = DateTime.now().difference(DateTime.parse(listCourse[index].startDate)).inDays;
                                        print("UP DIFF UP ${2021 - 12 - 01}");
                                        DateTime now = DateTime.now();
                                        bool dateStatus = now.isAfter(DateTime.parse(listCourse[index].startDate));
                                        return /*durationDiff.isNegative || durationDiff != 0*/
                                            listCourse[index].courseStatus == Constants.upcoming
                                                ? GestureDetector(
                                                    onTap: () {
                                                      listCourse[index].isPurchase == 1
                                                          ? Get.to(CourseListWidget(
                                                              courseId: listCourse[index].courseId,
                                                              type: Constants.paid,
                                                            ))
                                                          : Get.to(SubscriptionPage());
                                                    },
                                                    child: Container(
                                                      width: 140,
                                                      margin: EdgeInsets.only(left: 10),
                                                      height: 100,
                                                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(8.0), border: Border.all(width: 1, color: Colors.black12)),
                                                      child: Column(
                                                        children: [
                                                          Expanded(
                                                              flex: 3,
                                                              child: listCourse[index].file == null || listCourse[index].file == ''
                                                                  ? Image.asset(
                                                                      'assets/images/teachers.jpg',
                                                                      //height: 90,
                                                                      fit: BoxFit.contain,
                                                                      width: 120,
                                                                    )
                                                                  : Image.network(listCourse[index].file)),
                                                          Container(
                                                            height: 1,
                                                            color: Colors.black12,
                                                          ),
                                                          SizedBox(
                                                            height: 8,
                                                          ),
                                                          Expanded(flex: 1, child: Text(listCourse[index].courseName, overflow: TextOverflow.ellipsis, style: TextStyle(fontSize: 14, color: theme == Constants.lightTheme ? Colors.black : Colors.white, fontWeight: FontWeight.w500)))
                                                        ],
                                                      ),
                                                    ),
                                                  )
                                                : Container();
                                      })
                                  : Center(
                                      child: Text('No data'),
                                    ),
                            ),
                          ],
                        ),
                      );
                    } else {
                      return Center(
                        child: Utils.noData,
                      );
                    }
                  }
                },
              )),
        ],
      ),
    );
  }

  getCompletedCourses() {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(padding: EdgeInsets.only(left: 15, top: 20), child: Text(categoryName + '- Courses completed', overflow: TextOverflow.ellipsis, style: TextStyle(fontSize: 16, color: theme == Constants.lightTheme ? Colors.black : Colors.white, fontWeight: FontWeight.w800))),
          SizedBox(
            height: 10,
          ),
          Expanded(
            flex: 2,
            child: StreamBuilder(
              stream: courseBloc.courseFetcher,
              builder: (context, AsyncSnapshot<List<CourseList>> snapshot) {
                if (snapshot.hasData == false) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  print("RESSSS ${snapshot.data}");
                  listCourse = snapshot.data;
                  if (listCourse != null) {
                    return Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            flex: 2,
                            child: listCourse.length > 0
                                ? ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemCount: (listCourse.length),
                                    itemBuilder: (context, index) {
                                      Duration durationDiff = DateTime.parse(listCourse[index].startDate).difference(DateTime.parse(listCourse[0].endDate));
                                      int days = DateTime.now().difference(DateTime.parse('2021-10-07' /*listCourse[index].endDate*/)).inDays;
                                      print("DIFFRENCE LLL ${days.toString()}");

                                      return listCourse[index].courseStatus == Constants.complted /*days.isNegative == false*/
                                          ? GestureDetector(
                                              onTap: () {
                                                listCourse[index].isPurchase == 1
                                                    ? Get.to(CourseListWidget(
                                                        courseId: listCourse[index].courseId,
                                                        type: Constants.paid,
                                                      ))
                                                    : Get.to(SubscriptionPage());
                                              },
                                              child: Container(
                                                width: 140,
                                                margin: EdgeInsets.only(left: 10),
                                                height: 100,
                                                decoration: BoxDecoration(borderRadius: BorderRadius.circular(8.0), border: Border.all(width: 1, color: Colors.black12)),
                                                child: Column(
                                                  children: [
                                                    Expanded(
                                                        flex: 3,
                                                        child: listCourse[index].file == null || listCourse[index].file == ''
                                                            ? Image.asset(
                                                                'assets/images/teachers.jpg',
                                                                //height: 90,
                                                                fit: BoxFit.contain,
                                                                width: 120,
                                                              )
                                                            : Image.network(listCourse[index].file)),
                                                    Container(
                                                      height: 1,
                                                      color: Colors.black12,
                                                    ),
                                                    SizedBox(
                                                      height: 8,
                                                    ),
                                                    Expanded(flex: 1, child: Text(listCourse[index].courseName, overflow: TextOverflow.ellipsis, style: TextStyle(fontSize: 14, color: theme == Constants.lightTheme ? Colors.black : Colors.white, fontWeight: FontWeight.w500)))
                                                  ],
                                                ),
                                              ),
                                            )
                                          : Container();
                                    })
                                : Center(
                                    child: Text('No data'),
                                  ),
                          ),
                        ],
                      ),
                    );
                  } else {
                    return Center(
                      child: Utils.noData,
                    );
                  }
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
