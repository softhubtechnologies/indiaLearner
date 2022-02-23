import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:ext_storage/ext_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:india_learner/models/CourseListModel.dart';
import 'package:india_learner/networking/ApiHandler.dart';
import 'package:india_learner/networking/ApiProvider.dart';
import 'package:india_learner/networking/EndApi.dart';
import 'package:india_learner/utils/ToastMessage.dart';
import 'package:india_learner/utils/database.dart';
import 'package:india_learner/views/PdfViewer.dart';
import 'package:india_learner/views/PricingWidget.dart';
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';

class SubscriptionPage extends StatefulWidget {
  SubscriptionPageState createState() => SubscriptionPageState();
}

class SubscriptionPageState extends State<SubscriptionPage> {
  List<dynamic> listFaqs = [];
  List<bool> isSelectedList = [];
  int indexQue;
  String categoryName;
  List<CourseList> listCourse = [];
  bool showLoader = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Database.initDatabase();
    print("SUBID ${Database.getSubcategoryId()}");
    getCourses();
    categoryName = Database.getSelectedCategory();
    getPermission();
    getPermissionTwo();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        width: Get.size.width,
        child: SizedBox(
          height: 50,
          child: RaisedButton(
            onPressed: () {
              Get.to(PricingWidget());
            },
            color: Colors.cyan,
            child: Text(
              'Get subscription',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700, color: Colors.white),
            ),
          ),
        ),
      ),
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
        title: Text(categoryName + ' subscription', style: TextStyle(fontSize: 20, color: Colors.black, fontWeight: FontWeight.w600)),
      ),
      body: SafeArea(
        child: Container(
          child: Column(
            children: [
              Expanded(
                flex: 10,
                child: listCourse != null
                    ? ListView.builder(
                        itemCount: listCourse.length,
                        itemBuilder: (context, index) {
                          indexQue = index + 1;
                          return listCourse[index].isFree == '1'
                              ? Container(
                                  margin: EdgeInsets.only(left: 18, right: 14, top: 18),
                                  decoration: BoxDecoration(boxShadow: [BoxShadow(color: Colors.black12, offset: Offset(5.0, 0.5), blurRadius: 10.4, spreadRadius: 0.4)]),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      GestureDetector(
                                        onTap: () {},
                                        child: Container(
                                            height: 70,
                                            padding: EdgeInsets.symmetric(horizontal: 5),
                                            width: Get.size.width / 1.1,
                                            decoration: BoxDecoration(color: Colors.white),
                                            child: Column(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  children: [
                                                    Expanded(
                                                        flex: 5,
                                                        child: Container(
                                                          child: Text(listCourse[index].courseName, overflow: TextOverflow.ellipsis, maxLines: 3, style: TextStyle(fontSize: 15, color: Colors.black87, fontWeight: FontWeight.w600)),
                                                        )),
                                                    Expanded(
                                                      child: IconButton(
                                                          icon: Icon(
                                                            Icons.picture_as_pdf_outlined,
                                                            color: Colors.cyan,
                                                          ),
                                                          onPressed: () {
                                                            Navigator.push(context, MaterialPageRoute(builder: (context) {
                                                              return PdfViewer(flag: "online", pdfDocument: listCourse[index].file2);
                                                            }));
                                                          }),
                                                    ),
                                                    Expanded(
                                                        flex: 1,
                                                        child: IconButton(
                                                            icon: Icon(Icons.download_sharp),
                                                            color: Colors.cyan,
                                                            iconSize: 30,
                                                            onPressed: () async {
                                                              var format = DateFormat('yyyy-MM-dd hh:MM:ss');
                                                              DateTime date = DateTime.now();
                                                              Dio dio = Dio();
                                                              String path = await ExtStorage.getExternalStoragePublicDirectory(ExtStorage.DIRECTORY_DOWNLOADS);
                                                              String fileName = listCourse[index].courseName + "  Information " + date.toString();

                                                              String fullPath = "$path/$fileName.pdf";
                                                              setState(() {
                                                                showLoader = true;
                                                              });
                                                              downloadFile(dio: dio, mainsPaper: listCourse[index].file, fullPath: fullPath, title: listCourse[index].courseName);
                                                              //downloadFile(dio, listCourse[index].file, fullPath);
                                                            }))
                                                  ],
                                                ),
                                              ],
                                            )),
                                      ),
                                    ],
                                  ),
                                )
                              : Container();
                        })
                    : Center(
                        child: Text('No courses available for this category'),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void getCourses() {
    Database.initDatabase();

    var obj = {'category_id': Database.getSelectedCategoryId(), 'subcategory_id': Database.getSubcategoryId()};
    ApiHandler.postApi(baseUrl: ApiProvider.baseUrl, endApi: EndApi.courseList, map: obj).then((value) {
      setState(() {
        listCourse = CourseListModel.fromJson(value).courseList;
      });
      print("RESPONSE VVVVVVVVVVV ${listCourse.length}");
    });
  }

  void downloadFile({Dio dio, String mainsPaper, String fullPath, String title}) async {
    String path = await ExtStorage.getExternalStoragePublicDirectory(ExtStorage.DIRECTORY_DOWNLOADS);
    var format = DateFormat('yyyy-MM-dd hh:MM:ss');
    DateTime date = DateTime.now();
    String fileName = 'Notes ' + title + format.format(date).toString();
    String fullPath = "$path/$fileName.pdf";
    List<dynamic> notesList = [];
    List<String> listJson = [];

    String str = Database.getDownloadedNotes();
    print("NOTESSS ${str}");
    if (str != null) {
      notesList = json.decode(str);
    }
    for (int i = 0; i < notesList.length; i++) {
      listJson.add(json.encode(notesList[i]));
    }
    Map<String, dynamic> map = {'title': title + " course Details", 'path': fullPath};
    listJson.add(json.encode(map));
    Database.initDatabase();
    print("LLLLLLLLL ${listJson.toString()}");
    Database.downloadNotes(listJson.toString());
    Dio dio = Dio();
    try {
      var response = await dio.post(
        mainsPaper,
        onReceiveProgress: showDownloadProgress,
        options: Options(
            responseType: ResponseType.bytes,
            followRedirects: false,
            validateStatus: (status) {
              return status < 500;
            }),
      );
      File file = File(fullPath);
      var ref = file.openSync(mode: FileMode.write);
      ref.writeFromSync(response.data);
      await ref.close();
      ToastMessage.showToast(message: 'Notes downloaded to ' + fullPath, type: true);
    } catch (e) {
      print("ERROR IS:");

      print(e);
    }
  }

  onReceiverProgress(int count, int total) {
    print("COUNT ${count}  Total ${total}");
  }

  void showDownloadProgress(int count, int total) {
    print("Progress ${total.toString()} ${count.toString()}");
  }

  void getPermission() async {
    await Permission.storage.request();
    await Permission.mediaLibrary.request();
  }

  void getPermissionTwo() async {
    if (await Permission.contacts.request().isGranted) {
      // Either the permission was already granted before or the user just granted it.
    } else {
// You can request multiple permissions at once.
      Map<Permission, PermissionStatus> statuses = await [
        Permission.storage,
      ].request();

      print(statuses[Permission.location]);
    }
  }
}
