import 'dart:io';

import 'package:dio/dio.dart';
import 'package:ext_storage/ext_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:india_learner/blocs/TestHistoryBloc.dart';
import 'package:india_learner/models/TestHistoryModel.dart';
import 'package:india_learner/utils/ToastMessage.dart';
import 'package:india_learner/utils/Utils.dart';
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';

class TestHistoryPage extends StatefulWidget {
  TestHistoryPageState createState() => TestHistoryPageState();
}

class TestHistoryPageState extends State<TestHistoryPage> {
  bool showLoader = false;

  @override
  void initState() {
    super.initState();
    getPermission();
  }

  @override
  Widget build(BuildContext context) {
    testHistoryBloc.getTestHistory();
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        leading: Builder(builder: (context) {
          return IconButton(
            icon: Icon(
              Icons.arrow_back_rounded,
              color: Colors.black87,
            ),
            onPressed: () => Get.back(),
          );
        }),
        title: Text('Test history', style: TextStyle(fontSize: 20, color: Colors.black, fontWeight: FontWeight.w600)),
      ),
      body: Container(
        width: Get.size.width,
        color: Colors.grey.shade50,
        height: Get.size.height,
        child: Stack(
          children: [
            showLoader == false
                ? Column(
                    children: [
                      Expanded(
                          child: StreamBuilder(
                        stream: testHistoryBloc.testHistoryStream,
                        builder: (context, AsyncSnapshot<TestHistoryModel> snapshot) {
                          if (snapshot.hasData) {
                            return ListView.builder(
                              itemCount: snapshot.data.testResultList.length,
                              itemBuilder: (context, index) {
                                return Container(
                                    color: Colors.white,
                                    margin: EdgeInsets.only(left: 10, right: 10, top: 10),
                                    child: ListTile(
                                      leading: Icon(Icons.receipt),
                                      title: Text("TestName: " + snapshot.data.testResultList[index].testName),
                                      subtitle: Text("Marks: " + snapshot.data.testResultList[index].obtainMarks),
                                      trailing: snapshot.data.testResultList[index].checkedAnswerSheet != ""
                                          ? IconButton(
                                              icon: Icon(Icons.cloud_download),
                                              onPressed: () async {
                                                var format = DateFormat('yyyy-MM-dd hh:MM:ss');
                                                DateTime date = DateTime.now();
                                                Dio dio = Dio();
                                                String path = await ExtStorage.getExternalStoragePublicDirectory(ExtStorage.DIRECTORY_DOWNLOADS);
                                                String fileName = snapshot.data.testResultList[index].testName + "  answer sheet" + " " + date.toString();

                                                String fullPath = "$path/$fileName.pdf";
                                                setState(() {
                                                  showLoader = true;
                                                });
                                                downloadFile(dio, snapshot.data.testResultList[index].checkedAnswerSheet, fullPath);
                                              })
                                          : Icon(Icons.arrow_forward_ios_rounded),
                                    ));
                              },
                            );
                          } else if (snapshot.connectionState == ConnectionState.waiting) {
                            return Utils.loader;
                          } else {
                            return Utils.noData;
                          }
                        },
                      ))
                    ],
                  )
                : Utils.loader
          ],
        ),
      ),
    );
  }

  void downloadFile(Dio dio, String checkedAnswerSheet, String fullPath) async {
    try {
      var response = await dio.post(checkedAnswerSheet,
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

  onReceiverProgress(int count, int total) {
    print("COUNT ${count}  Total ${total}");
  }

  void getPermission() async {
    await Permission.storage.request();
    await Permission.mediaLibrary.request();
  }
}
