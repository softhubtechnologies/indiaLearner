import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:india_learner/blocs/CourseBloc.dart';
import 'package:india_learner/models/CourseListModel.dart';
import 'package:india_learner/networking/Repository.dart';
import 'package:india_learner/utils/Color.dart';
import 'package:india_learner/utils/Constants.dart';
import 'package:india_learner/utils/ThemeModel.dart';
import 'package:india_learner/utils/Utils.dart';
import 'package:india_learner/views/FreeLiveClassListScreen.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import 'PdfViewer.dart';

class FreeLiveClass extends StatefulWidget {
  FreeLiveClassState createState() => FreeLiveClassState();
}

class FreeLiveClassState extends State<FreeLiveClass> {
  Future<List<CourseList>> futureCourse;
  List<CourseList> listCourse = [];
  String theme;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    setState(() {
      futureCourse = Repository.getCourses();
    });
  }

  @override
  Widget build(BuildContext context) {
    theme = Provider.of<ThemeModel>(context, listen: false).mode == ThemeMode.dark ? Constants.darkTheme : Constants.lightTheme;
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
        title: Text('Free live courses', style: TextStyle(fontSize: 20, color: Colors.black, fontWeight: FontWeight.w600)),
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
                  listCourse = snapshot.data;
                  return listCourse.length > 0
                      ? ListView.builder(
                          itemCount: listCourse.length,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () async {
                                Get.to(FreeLiveClassListScreen(
                                  courseId: listCourse[index].courseId,
                                ));

                                //Get.to(CourseListWidget());
                              },
                              child: listCourse[index].isFree == '0'
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
                                                      child: listCourse[index].file != null
                                                          ? Image.network(
                                                              listCourse[index].file,
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
                                                          listCourse[index].courseName,
                                                          style: TextStyle(fontSize: 14, height: 1.3, color: theme == Constants.lightTheme ? Colors.black87 : Colors.white, fontWeight: FontWeight.w600),
                                                        ),
                                                        Text(
                                                          listCourse[index].startDate,
                                                          style: TextStyle(fontSize: 14, height: 1.3, color: theme == Constants.lightTheme ? Colors.black87 : Colors.white, fontWeight: FontWeight.w600),
                                                        )
                                                      ],
                                                    )),
                                                Expanded(
                                                  flex: 1,
                                                  child: IconButton(
                                                      icon: Icon(Icons.picture_as_pdf),
                                                      iconSize: 30,
                                                      color: color.primaryColor,
                                                      onPressed: () async {
                                                        Navigator.push(context, MaterialPageRoute(builder: (context) {
                                                          return PdfViewer(
                                                            flag: "online",
                                                            pdfDocument: listCourse[index].file2,
                                                          );
                                                        }));
                                                        // downloadFile(dio, snapshot.data.downloadsList[index].downloadsPdf, fullPath);
                                                      }),
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

  void launchUrl() async {
    await await launch("https://us05web.zoom.us/j/81770167728");
    //await canLaunch("") ? await launch("https://mail.google.com/mail/") : throw 'Could not launch';
  }
}
