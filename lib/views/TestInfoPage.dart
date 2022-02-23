import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:ext_storage/ext_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:india_learner/models/SubtestModel.dart';
import 'package:india_learner/utils/Color.dart';
import 'package:india_learner/utils/Constants.dart';
import 'package:india_learner/utils/ThemeModel.dart';
import 'package:india_learner/utils/ToastMessage.dart';
import 'package:india_learner/utils/Utils.dart';
import 'package:india_learner/utils/database.dart';
import 'package:india_learner/views/TestInstructions.dart';
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class TestInfoPage extends StatefulWidget {
  SubtestDetailsList subtestDetailsList;
  String testType;
  TestInfoPage(this.subtestDetailsList, this.testType);

  TestInfoPageState createState() => TestInfoPageState(subtestDetailsList, testType);
}

class TestInfoPageState extends State<TestInfoPage> {
//  List<String> strList = ['Syllabus', 'Question Paper', 'Question paper Hindi', 'Answer Format', 'Answer Format Hindi', 'Discussion'];
  List<String> strList = ['Syllabus', 'Question Paper', 'Answer Format', 'Discussion'];
  bool showLoader = false;
  List<String> strListSubtitle = ['Click to see the syllabus', 'Click to Download', 'Click to Download', 'Click to join discussion', 'Click to join discussion', 'Click to View'];
  SubtestDetailsList subtestDetailsList;
  String testType;

  TestInfoPageState(this.subtestDetailsList, this.testType);

  List<IconData> listIcons = [
    Icons.paste,
    Icons.library_books,
    Icons.library_books,
    Icons.mic,
  ];

/*
  List<IconData> listIcons = [
    Icons.paste,
    Icons.library_books,
    Icons.library_books,
    Icons.edit,
    Icons.edit,
    Icons.mic,
  ];
*/
  String theme;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getPermission();
  }

  @override
  Widget build(BuildContext context) {
    theme = Provider.of<ThemeModel>(context, listen: false).mode == ThemeMode.dark ? Constants.darkTheme : Constants.lightTheme;

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
        title: Text(subtestDetailsList.subtest, style: TextStyle(fontSize: 20, color: Colors.black, fontWeight: FontWeight.w600)),
      ),
      bottomNavigationBar: Container(
        width: Get.size.width,
        padding: EdgeInsets.only(left: 5, right: 5, bottom: 5),
        child: SizedBox(
          height: 50,
          child: RaisedButton(
            onPressed: () {
              Get.to(TestInstructions(
                subtestDetailsList: subtestDetailsList,
                testType: testType,
              ));
            },
            color: Colors.cyan,
            child: Text(
              'Take Test',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: Colors.white),
            ),
          ),
        ),
      ),
      body: Container(
        child: Stack(
          children: [
            showLoader == false
                ? ListView.builder(
                    itemCount: listIcons.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          navigate(index);
                        },
                        child: Container(
                            child: Column(
                          children: [
                            SizedBox(
                              height: 5,
                            ),
                            ListTile(
                              leading: Icon(
                                listIcons[index],
                                size: 34,
                                color: Colors.black.withOpacity(0.6),
                              ),
                              title: Text(
                                strList[index],
                                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: Colors.cyan),
                              ),
                              subtitle: Text(
                                strListSubtitle[index],
                                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400, fontStyle: FontStyle.italic, color: theme == Constants.lightTheme ? color.lightText : color.darkText),
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Container(
                              height: 1,
                              color: Colors.black12,
                            )
                          ],
                        )),
                      );
                    })
                : Utils.loader
          ],
        ),
      ),
    );
  }

  void navigate(int index) async {
    var format = DateFormat('yyyy-MM-dd hh:MM:ss');
    DateTime date = DateTime.now();
    Dio dio = Dio();
    String path = await ExtStorage.getExternalStoragePublicDirectory(ExtStorage.DIRECTORY_DOWNLOADS);
    String fileName = subtestDetailsList.subtest + "  Test " + date.toString();

    String fullPath = "$path/$fileName.pdf";
    setState(() {
      showLoader = true;
    });

    switch (index) {
      case 0:
        if (subtestDetailsList.syllabusPdf != null) {
          downloadFile(
            dio: dio,
            fullPath: fullPath,
            mainsPaper: subtestDetailsList.syllabusPdf,
            title: fileName + " Syllabus",
          );
        } else {
          ToastMessage.showToast(message: "File not available", type: false);
        }
        break;
      case 1:
        if (subtestDetailsList.quationPaperPdf != null) {
          downloadFile(
            dio: dio,
            fullPath: fullPath,
            mainsPaper: subtestDetailsList.quationPaperPdf,
            title: " Question Paper",
          );
        } else {
          ToastMessage.showToast(message: "File not available", type: false);
        }
        break;
      case 2:
        downloadFile(
          dio: dio,
          fullPath: fullPath,
          mainsPaper: subtestDetailsList.syllabusPdf,
          title: " Answer Format",
        );
        break;
      case 3:
        if (subtestDetailsList.zoomLink != null) {
          void launchUrl() async {
            await await launch(subtestDetailsList.zoomLink);
            //await canLaunch("") ? await launch("https://mail.google.com/mail/") : throw 'Could not launch';
          }
        } else {
          ToastMessage.showToast(message: "Link not available", type: false);
        }
        break;
    }
  }

  void downloadFile({Dio dio, String mainsPaper, String fullPath, String title}) async {
    String path = await ExtStorage.getExternalStoragePublicDirectory(ExtStorage.DIRECTORY_DOWNLOADS);
    var format = DateFormat('yyyy-MM-dd hh:MM:ss');
    DateTime date = DateTime.now();
    String fileName = title + format.format(date).toString();
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
      setState(() {
        showLoader = false;
      });
    } catch (e) {
      print("ERROR IS:");

      print(e);
    }

    /*try {
      var response = await dio.post(mainsPaper,
          onReceiveProgress: onReceiverProgress,
          options: Options(
              responseType: ResponseType.bytes,
              followRedirects: false,
              validateStatus: (status) {
                return status < 500;
              }));
      File file = File(fullPath);
      var ref = file.openSync(mode: FileMode.write);
      ref.writeFromSync(response.data);
      await ref.close();
      ToastMessage.showToast(message: "File downloaded successfully", type: true);
      setState(() {
        showLoader = false;
      });
    } catch (e) {
      print("ERROR ${e}");
    }*/
  }

  void showDownloadProgress(int count, int total) {
    print("Progress ${total.toString()} ${count.toString()}");
  }

  /*
  void downloadFile(String fileUrl) async {
    var format = DateFormat('yyyy-MM-dd hh:MM:ss');
    DateTime date = DateTime.now();
    Dio dio = Dio();
    String path = await ExtStorage.getExternalStoragePublicDirectory(ExtStorage.DIRECTORY_DOWNLOADS);
    String fileName = subtestDetailsList.subtest + "  test " + " " + date.toString();

    String fullPath = "$path/$fileName.pdf";
    setState(() {
      showLoader = true;
    });

    try {
      var response = await dio.post(fileUrl,
          onReceiveProgress: onReceiverProgress,
          options: Options(
              responseType: ResponseType.bytes,
              followRedirects: false,
              validateStatus: (status) {
                return status < 500;
              }));
      File file = File(fullPath);
      var ref = file.openSync(mode: FileMode.write);
      ref.writeFromSync(response.data);
      await ref.close();
      ToastMessage.showToast(message: "File downloaded successfully", type: true);
      setState(() {
        showLoader = false;
      });
    } catch (e) {
      print("ERROR ${e}");
    }
  }
*/

  onReceiverProgress(int count, int total) {
    print("COUNT ${count}  Total ${total}");
  }

  void getPermission() async {
    await Permission.storage.request();
    await Permission.mediaLibrary.request();
  }
}
