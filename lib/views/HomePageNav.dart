import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:india_learner/blocs/CourseBloc.dart';
import 'package:india_learner/blocs/LiveSessionHomeBloc.dart';
import 'package:india_learner/blocs/TeachersBloc.dart';
import 'package:india_learner/blocs/TopVideosBloc.dart';
import 'package:india_learner/models/AdvertiseModel.dart';
import 'package:india_learner/models/ClassesSessionListModel.dart';
import 'package:india_learner/models/CourseListModel.dart';
import 'package:india_learner/models/LiveSessionListModel.dart';
import 'package:india_learner/models/TeacherListModel.dart';
import 'package:india_learner/models/TopVideosModel.dart';
import 'package:india_learner/networking/ApiProvider.dart';
import 'package:india_learner/networking/Repository.dart';
import 'package:india_learner/utils/AppStrings.dart';
import 'package:india_learner/utils/Color.dart';
import 'package:india_learner/utils/Constants.dart';
import 'package:india_learner/utils/ThemeModel.dart';
import 'package:india_learner/utils/Utils.dart';
import 'package:india_learner/utils/database.dart';
import 'package:india_learner/views/CourseVideos.dart';
import 'package:india_learner/views/DownloadsPage.dart';
import 'package:india_learner/views/FreeLiveClassListScreen.dart';
import 'package:india_learner/views/MyEnrollments.dart';
import 'package:india_learner/views/PlusCoursesScreen.dart';
import 'package:india_learner/views/SavedScreen.dart';
import 'package:india_learner/views/SchedulePage.dart';
import 'package:india_learner/views/SubscriptionPage.dart';
import 'package:india_learner/views/TeachersDetails.dart';
import 'package:india_learner/views/VideoPlayerWidget.dart';
import 'package:provider/provider.dart';

class HomePageNav extends StatefulWidget {
  HomePageNavState createState() => HomePageNavState();
}

class HomePageNavState extends State<HomePageNav> {
  String categorypName;
  List<TeacherList> listTeachers = [];
  List<CourseList> listCourse = [];
  Future<List<CourseList>> futureCourse;
  Future<List<TeacherList>> futureTeachers;
  Future<Map<String, dynamic>> futureAdvertisement;
  List<AdvertiesmentList> advertiseList = [];
  String theme, className;
  bool showLoader = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print("userid ${Database.getUserID()}");

    categorypName = Database.getSelectedCategory();
    className = Database.getClassName();
    setState(() {
      futureTeachers = Repository.getTeachers();
      futureAdvertisement = Repository.advertisement();
    });
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    setState(() {
      theme = Provider.of<ThemeModel>(context, listen: false).mode == ThemeMode.dark ? Constants.darkTheme : Constants.lightTheme;
    });
  }

  @override
  void didUpdateWidget(covariant HomePageNav oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
    setState(() {
      theme = Provider.of<ThemeModel>(context, listen: false).mode == ThemeMode.dark ? Constants.darkTheme : Constants.lightTheme;
    });
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    theme = Provider.of<ThemeModel>(context, listen: false).mode == ThemeMode.dark ? Constants.darkTheme : Constants.lightTheme;
    courseBloc.featchAllCourses();
    teachersBloc.featchAllTeacher();
    topVideosBloc.fetchAllTopVideos();

    //liveSessionBloc.fetchAllLiveSessions();
    liveSessionHomeBloc.fetchAllLiveSessions(categoryId: Database.getSelectedCategoryId(), subcategoryId: Database.getSubcategoryId());
    return Scaffold(
        body: SingleChildScrollView(
      child: Container(
//        color: Colors.white,
        height: Get.size.height + 170,
        child: IntrinsicHeight(
          child: Column(
            children: [
              Expanded(flex: 2, child: getSlider()),
              SizedBox(
                height: 17,
              ),
              Expanded(flex: 3, child: getMenuGrid()),
              Expanded(
                flex: 2,
                child: getEducatorList(),
              ),
              SizedBox(
                height: 10,
              ),
              Expanded(
                flex: 2,
                child: getLatestCourses(),
              ),
              SizedBox(
                height: 8,
              ),
              Expanded(
                flex: 2,
                child: topVideos(),
              ),
              SizedBox(
                height: 8,
              ),
              Expanded(
                flex: 3,
                child: getLearningList(),
              ),
            ],
          ),
        ),
      ),
    ));
  }

  List<String> listGrid = [
    'My Schedule',
    'Saved',
    'Enrollments',
    'Downloads',
  ];

  List<IconData> iconsList = [
    Icons.calendar_today,
    Icons.save,
    Icons.check_box,
    Icons.cloud_download,
    Icons.history,
  ];

  void navigate(int index) {
    switch (index) {
      case 0:
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return SchedulePage();
        }));
        break;
      case 1:
        Get.to(SavedScreen());
        break;
      case 2:
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return MyEnrollments();
        }));
        break;
      case 3:
        Get.to(DownloadsPage());
        break;
    }
  }

  getMenuGrid() {
    return GridView.count(
      crossAxisCount: 2,
      crossAxisSpacing: 14,
      mainAxisSpacing: 14,
      padding: EdgeInsets.symmetric(horizontal: 16),
      childAspectRatio: 2.3,
      children: List.generate(listGrid.length, (index) {
        return GestureDetector(
          onTap: () {
            navigate(index);
          },
          child: Container(
            height: 120,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(10.0), color: theme == Constants.lightTheme ? Colors.white : color.darkCard, boxShadow: [
              BoxShadow(
                color: Colors.black12,
                offset: const Offset(
                  5.0,
                  0.5,
                ),
                blurRadius: 10.4,
                spreadRadius: 0.4,
              )
            ]),
            child: Center(
              child: Row(
                //mainAxisAlignment:MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(
                    width: 18,
                  ),
                  Icon(
                    iconsList[index],
                    color: theme == Constants.lightTheme ? Colors.black : Colors.white,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    listGrid[index],
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: theme == Constants.lightTheme ? Colors.black : Colors.white,
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      }),
    );
  }

  getEducatorList() {
    return Container(
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.only(left: 15, right: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppSrings.educatorAndTeacher,
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w800,
              color: theme == Constants.lightTheme ? Colors.black87 : Colors.white,
            ),
          ),
          StreamBuilder(
              stream: teachersBloc.getTeachersStream,
              builder: (context, AsyncSnapshot<List<TeacherList>> snapshot) {
                if (snapshot.hasData) {
                  print("Runtimettype ${snapshot.hasData}");
                  listTeachers = snapshot.data;
                  print("Teachers ${listTeachers.toString()}");
                  return Expanded(
                    child: listTeachers.length > 0
                        ? ListView.builder(
                            itemCount: listTeachers.length,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () {
                                  Get.to(TeachersDetails(
                                    teacherList: listTeachers[index],
                                  ));
                                },
                                child: Padding(
                                  padding: EdgeInsets.only(right: 10, top: 5),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Container(
                                        height: 90,
                                        width: Get.size.width / 4,
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(8.0),
                                          child: listTeachers[index].file != null && listTeachers[index].file != ''
                                              ? Image.network(
                                                  listTeachers[index].file,
                                                  //height: 90,
                                                  //width: 120,
                                                  fit: BoxFit.cover,
                                                )
                                              : Image.asset('assets/images/teachers.jpg'),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        listTeachers[index].name,
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w500,
                                          color: theme == Constants.lightTheme ? Colors.black87 : Colors.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            })
                        : Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Center(
                                child: Utils.loader,
                              )
                            ],
                          ),
                  );
                } else if (snapshot.connectionState == ConnectionState.waiting) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Center(
                        child: Utils.loader,
                      )
                    ],
                  );
                } else {
                  return Column(
                    children: [Utils.noData],
                  );
                }
              })
        ],
      ),
    );
  }

  getLatestCourses() {
    return Container(
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.only(left: 15, right: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Latest Courses',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w800,
              color: theme == Constants.lightTheme ? Colors.black87 : Colors.white,
            ),
          ),
          Expanded(
              child: StreamBuilder(
            stream: courseBloc.courseFetcher,
            builder: (context, AsyncSnapshot<List<CourseList>> snapshot) {
              if (snapshot.hasData) {
                // print("Runtimetype dd${snapshot.data.}");

                //print("Runtimetype ${CourseList.fromJson(snapshot.data.length)}");
                listCourse = snapshot.data;
                if (listCourse != null) {
                  return listCourse.length > 0
                      ? ListView.builder(
                          itemCount: listCourse.length,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            print("LLLLLLLLLLLLLLLLLLL ${ApiProvider.baseUrlImage + listCourse[index].file.toString()}");
                            Database.initDatabase();
                            Database.saveSubscribitionPlan("1000", snapshot.data[index].planName);
                            return listCourse[index].isFree == '1'
                                ? GestureDetector(
                                    onTap: () {
                                      print("LLLLLLLLLLLLLLLLLLL ${ApiProvider.baseUrlImage + listCourse[index].file.toString()}");

                                      listCourse[index].isPurchase == 1
                                          ? Get.to(CourseListWidget(
                                              courseId: listCourse[index].courseId,
                                              type: Constants.paid,
                                            ))
                                          : Get.to(SubscriptionPage());
                                    },
                                    child: Container(
                                      padding: EdgeInsets.only(top: 5),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Expanded(
                                              flex: 3,
                                              child: Container(
                                                // height: 120,
                                                width: Get.size.width / 3,
                                                child: ClipRRect(
                                                  borderRadius: BorderRadius.circular(8.0),
                                                  child: listCourse[index].file != null
                                                      ? Image.network(
                                                          listCourse[index].file,
                                                          fit: BoxFit.cover,
                                                        )
                                                      : Image.asset('assets/images/download.jpg'),
                                                ),
                                              )),
                                          SizedBox(
                                            height: 1,
                                          ),
                                          Text(
                                            listCourse[index].courseName,
                                            style: TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w500,
                                              color: theme == Constants.lightTheme ? Colors.black87 : Colors.white,
                                            ),
                                          ),
                                          SizedBox(
                                            height: 2,
                                          ),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            children: [
                                              /*Text(
                                                'Price: ' + listCourse[index].courseFee.toString(),
                                                style: TextStyle(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w500,
                                                  color: theme == Constants.lightTheme ? Colors.black : Colors.white,
                                                ),
                                              ),*/
                                              Text(
                                                '   Duration: ' + listCourse[index].duration.toString() + ' days',
                                                style: TextStyle(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w500,
                                                  color: theme == Constants.lightTheme ? Colors.black87 : Colors.white,
                                                ),
                                              )
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  )
                                : Container();
                          })
                      : Utils.noData;
                } else if (snapshot.connectionState == ConnectionState.waiting) {
                  return Utils.loader;
                }
              } else {
                return Utils.noData;
              }
            },
          )),
        ],
      ),
    );
  }

  getLearningList() {
    return Container(
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.only(left: 15, right: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Continue learning',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w800,
              color: theme == Constants.lightTheme ? Colors.black87 : Colors.white,
            ),
          ),
          Expanded(
              child: StreamBuilder(
            stream: liveSessionHomeBloc.getSessionList,
            builder: (context, AsyncSnapshot<List<LiveList>> snapshot) {
              if (snapshot.hasData) {
                return snapshot.data.length > 0
                    ? ListView.builder(
                        itemCount: snapshot.data.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              if (snapshot.data[index].isFree == "0") {
                                Get.to(FreeLiveClassListScreen(
                                  courseId: snapshot.data[index].courseId,
                                ));
                              } else {
                                if (snapshot.data[index].isFree == "2") {
                                  if (snapshot.data[index].isPurchase == 1) {
                                    Get.to(FreeLiveClassListScreen(
                                      courseId: snapshot.data[index].courseId,
                                    ));
                                  } else {
                                    Get.to(PlusCoursesScreen());
                                  }
                                } else if (snapshot.data[index].isFree == "1" && snapshot.data[index].isPurchase == 1) {
                                  Get.to(FreeLiveClassListScreen(
                                    courseId: snapshot.data[index].courseId,
                                  ));
                                } else {
                                  Get.to(SubscriptionPage());
                                }
                              }
                            },
                            child: Padding(
                              padding: EdgeInsets.only(right: 10, top: 5, left: 15),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                      flex: 3,
                                      child: Container(
                                        width: Get.size.width / 3,
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(8.0),
                                          child: Image.asset(
                                            'assets/images/download.jpg',
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      )),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Expanded(
                                      flex: 1,
                                      child: Text(
                                        snapshot.data[index].title,
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w400,
                                          color: theme == Constants.lightTheme ? Colors.black87 : Colors.white,
                                        ),
                                      )),
                                ],
                              ),
                            ),
                          );
                        })
                    : Utils.noData;
              } else if (snapshot.connectionState == ConnectionState.waiting) {
                print("DDDDDDDDD ${snapshot.data}");
                return Utils.loader;
              } else {
                return Utils.noData;
              }
            },
          )),
        ],
      ),
    );
  }

  topVideos() {
    return Container(
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.only(left: 15, right: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Top Videos',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w800,
              color: theme == Constants.lightTheme ? Colors.black87 : Colors.white,
            ),
          ),
          Expanded(
              child: StreamBuilder(
            stream: topVideosBloc.topVideosStream,
            builder: (context, AsyncSnapshot<List<TopVideosList>> snapshot) {
              if (snapshot.hasData) {
                List<TopVideosList> listTopVideos = snapshot.data;
                return ListView.builder(
                    itemCount: listTopVideos.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          VideoList videoList = VideoList();
                          videoList.video = listTopVideos[index].video;
                          videoList.categoryId = listTopVideos[index].categoryId;
                          videoList.subcategoryId = listTopVideos[index].subcategoryId;
                          videoList.courseName = listTopVideos[index].courseName;
                          videoList.id = listTopVideos[index].courseId;
                          videoList.title = listTopVideos[index].title;
                          videoList.image = listTopVideos[index].image;
                          print("TOPPP ${listTopVideos[index].video}");
                          Get.to(VideoPlayerWidget(videoList: videoList));
                        },
                        child: Padding(
                          padding: EdgeInsets.only(right: 10, left: 5, top: 5),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                  flex: 3,
                                  child: Container(
                                    width: Get.size.width / 3,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(8.0),
                                      child: Image.asset(
                                        'assets/images/download.jpg',
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  )),
                              SizedBox(
                                height: 5,
                              ),
                              Expanded(
                                  flex: 1,
                                  child: Text(
                                    listTopVideos[index].title,
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400,
                                      color: theme == Constants.lightTheme ? Colors.black87 : Colors.white,
                                    ),
                                  )),
                            ],
                          ),
                        ),
                      );
                    });
              } else if (snapshot.connectionState == ConnectionState.waiting) {
                return Utils.loader;
              } else {
                return Utils.noData;
              }
            },
          )
              /*ListView.builder(
                  itemCount: 5,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsets.only(right: 10, left: 5, top: 5),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                              flex: 3,
                              child: Container(
                                width: Get.size.width / 3,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(8.0),
                                  child: Image.asset(
                                    'assets/images/download.jpg',
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              )),
                          SizedBox(
                            height: 5,
                          ),
                          Expanded(
                              flex: 1,
                              child: Text(
                                "Video Name " + index.toString(),
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                  color: theme == Constants.lightTheme ? Colors.black : Colors.white,
                                ),
                              )),
                        ],
                      ),
                    );
                  })*/
              ),
        ],
      ),
    );
  }

  getSlider() {
    return FutureBuilder(
      future: futureAdvertisement,
      builder: (context, snapshot) {
        if (snapshot.hasData == true) {
          advertiseList = AdvertiseModel.fromJson(snapshot.data).advertiesmentList;
          if (advertiseList != null) {
            return CarouselSlider(
              options: CarouselOptions(height: 400.0),
              items: advertiseList.map((i) {
                return Builder(
                  builder: (BuildContext context) {
                    print("DDDDDDDDDD advertiseList ${i}");

                    return Container(
                        width: MediaQuery.of(context).size.width,
                        margin: EdgeInsets.symmetric(horizontal: 5.0),
                        decoration: BoxDecoration(color: theme == Constants.lightTheme ? Colors.white : Colors.grey),
                        child: Image.network(
                          i.imagePath,
                          fit: BoxFit.cover,
                        ));
                  },
                );
              }).toList(),
            );
          } else if (advertiseList == null) {
            return Utils.noData;
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return Utils.loader;
          }
        } else {
          return Utils.noData;
        }
      },
    );
  }
}
