import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:ext_storage/ext_storage.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_uploader/flutter_uploader.dart';
import 'package:get/get.dart';
import 'package:india_learner/blocs/WrittenTestBloc.dart';
import 'package:india_learner/models/WrittenTestModel.dart';
import 'package:india_learner/networking/ApiProvider.dart';
import 'package:india_learner/networking/Repository.dart';
import 'package:india_learner/utils/Color.dart';
import 'package:india_learner/utils/Constants.dart';
import 'package:india_learner/utils/ToastMessage.dart';
import 'package:india_learner/utils/Utils.dart';
import 'package:intl/intl.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class WrittenTestWidget extends StatefulWidget {
  WrittenTestWidgetState createState() => WrittenTestWidgetState();
}

class WrittenTestWidgetState extends State<WrittenTestWidget> {
  String theme;
  bool showLoader = false;
  @override
  void initState() {
    super.initState();
    getPermission();
  }

  @override
  Widget build(BuildContext context) {
    theme = MediaQuery.of(context).platformBrightness == Brightness.dark ? Constants.darkTheme : Constants.lightTheme;
    writtenTestBloc.getWrittenTest();
    return Scaffold(
      floatingActionButton: Padding(
        padding: EdgeInsets.only(bottom: 12, right: 12),
        child: FloatingActionButton(
          child: Icon(
            Icons.cloud_upload_sharp,
            color: Colors.white,
            size: 35,
          ),
          backgroundColor: color.primaryColor,
          onPressed: () {
            uploadFile();
          },
        ),
      ),
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
            Get.back();
          },
        ),
        title: Text('Written Test', style: TextStyle(fontSize: 20, color: Colors.black, fontWeight: FontWeight.w600)),
      ),
      body: Stack(
        children: [
          Container(
            child: StreamBuilder(
              stream: writtenTestBloc.writtenTestStream,
              builder: (context, AsyncSnapshot<WrittenTestModel> snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                      itemCount: snapshot.data.subcategoryList.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            // Get.to(TestInfoPage(snapshot.data[index], testTypeId));
                          },
                          child: Container(
                            color: theme == Constants.darkTheme ? color.darkCard : Colors.white,
                            padding: EdgeInsets.only(top: 10),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                        flex: 1,
                                        child: Container(
                                          margin: EdgeInsets.only(left: 4),
                                          height: 50,
                                          width: 45,
                                          decoration: BoxDecoration(color: Colors.blueAccent, borderRadius: BorderRadius.circular(3)),
                                          child: Center(
                                            child: Text(
                                              ("100" + index.toString()),
                                              style: TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w700,
                                                color: theme == Constants.darkTheme ? color.darkText : color.lightText,
                                              ),
                                            ),
                                          ),
                                        )),
                                    Expanded(
                                        flex: 3,
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Container(
                                              margin: EdgeInsets.only(left: 6, top: 4),
                                              height: 40,
                                              //   color: Colors.white,
                                              child: Text(
                                                snapshot.data.subcategoryList[index].testName != null ? snapshot.data.subcategoryList[index].testName : "",
                                                maxLines: 2,
                                                style: TextStyle(fontSize: 12, color: theme == Constants.darkTheme ? color.darkText : color.lightText, fontWeight: FontWeight.w700),
                                              ),
                                            )
                                          ],
                                        )),
                                    Expanded(
                                        child: GestureDetector(
                                      onTap: () async {
                                        var format = DateFormat('yyyy-MM-dd hh:MM:ss');
                                        DateTime date = DateTime.now();
                                        Dio dio = Dio();
                                        String path = await ExtStorage.getExternalStoragePublicDirectory(ExtStorage.DIRECTORY_DOWNLOADS);
                                        String fileName = snapshot.data.subcategoryList[index].testName + " " + date.toString();

                                        String fullPath = "$path/$fileName.pdf";
                                        setState(() {
                                          showLoader = true;
                                        });
                                        downloadFile(dio, snapshot.data.subcategoryList[index].mainsPaper, fullPath);
                                      },
                                      child: Container(
                                        child: Icon(
                                          Icons.download_sharp,
                                          color: theme == Constants.darkTheme ? color.darkText : color.lightText,
                                        ),
                                      ),
                                    ))
                                  ],
                                ),
                                Container(
                                  margin: EdgeInsets.only(top: 11),
                                  height: 1,
                                  color: Colors.black12,
                                )
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
            ),
          ),
          showLoader == true ? Utils.loader : Container()
        ],
      ),
    );
  }

  void downloadFile(Dio dio, String mainsPaper, String fullPath) async {
    try {
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
    }
  }

  onReceiverProgress(int count, int total) {
    print("COUNT ${count}  Total ${total}");
  }

  void getPermission() async {
    await Permission.storage.request();
    await Permission.mediaLibrary.request();
  }

  void uploadFile() async {
    List<String> extensions;

    String filePath = await FilePicker.getFilePath(type: FileType.any, allowedExtensions: extensions);

    String dir = (await getApplicationDocumentsDirectory()).path;

    String extension = File(filePath).path.split('.').last;

    String fileName = "answerSheet";

    String newPath = path.join(dir, fileName + '.' + extension);

    File f = await File(filePath);

    File ff = await File(f.path).copy(newPath);

    String fName = ff.path.split('/').last;

    uploader(fileName: fName, directory: dir);
    setState(() {
      showLoader = true;
    });
  }

  Future<Map<String, dynamic>> uploader({fileName, directory}) async {
    dynamic prog;
    Map<String, dynamic> map;
    final uploader = FlutterUploader();
    //String fileName = await file.path.split('/').last;

    final taskId = await uploader.enqueue(url: ApiProvider.fileUploadUrl, files: [FileItem(filename: fileName, savedDir: directory)], method: UploadMethod.POST, headers: {"apikey": "api_123456", "userkey": "userkey_123456"}, showNotification: true);
    final subscription = uploader.progress.listen((progress) {});

    final subscription1 = uploader.result.listen((result) {
//    print("Progress result ${result.response}");

      print("Progress result ${result.response}");

      // return result.response;
    }, onError: (ex, stacktrace) {
      setState(() {
        showLoader = false;
      });
    });
    subscription1.onData((data) async {
      map = json.decode(data.response);

      print("result DATA ${map["url"]}");

      ToastMessage.showToast(message: "Uploaded successfully", type: true);

      Repository.writtenTestSubmission(obtainMarks: "", totalMarks: "", testName: "Written test", answerSheet: map["url"], testType: "4");
      showLoader = false;
    });
    return map;
  }
}
