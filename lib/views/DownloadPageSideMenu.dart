import 'dart:io';

import 'package:dio/dio.dart';
import 'package:ext_storage/ext_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:india_learner/blocs/DownloadsBloc.dart';
import 'package:india_learner/models/DownloadsSideMenuModel.dart';
import 'package:india_learner/utils/Color.dart';
import 'package:india_learner/utils/Constants.dart';
import 'package:india_learner/utils/ToastMessage.dart';
import 'package:india_learner/utils/Utils.dart';
import 'package:india_learner/views/PdfViewer.dart';
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';

class DownloadPageSideMenu extends StatefulWidget {
  DownloadPageSideMenuState createState() => DownloadPageSideMenuState();
}

class DownloadPageSideMenuState extends State<DownloadPageSideMenu> {
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

    downloadsBloc.getDownloads();
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
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
        title: Text('Downloads', style: TextStyle(fontSize: 20, color: Colors.black, fontWeight: FontWeight.w600)),
      ),
      body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: StreamBuilder(
              stream: downloadsBloc.downloadsStream,
              builder: (context, AsyncSnapshot<DownloadsSideMenuModel> snapshot) {
                if (snapshot.hasData) {
                  return Stack(
                    children: [
                      showLoader == false
                          ? ListView.builder(
                              itemCount: snapshot.data.downloadsList.length,
                              itemBuilder: (context, index) {
                                return Container(
                                  height: 70,
                                  width: Get.size.width / 1.2,
                                  padding: EdgeInsets.only(left: 8, top: 8),
                                  margin: EdgeInsets.only(left: 10, right: 10, top: 10),
                                  decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8.0)),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      ListTile(
                                        leading: Icon(
                                          Icons.file_copy,
                                          color: color.primaryColor,
                                          size: 30,
                                        ),
                                        title: Text(snapshot.data.downloadsList[index].title),
                                        trailing: IconButton(
                                            icon: Icon(Icons.picture_as_pdf),
                                            iconSize: 30,
                                            color: color.primaryColor,
                                            onPressed: () async {
                                              var format = DateFormat('yyyy-MM-dd hh:MM:ss');
                                              DateTime date = DateTime.now();
                                              Dio dio = Dio();
                                              String path = await ExtStorage.getExternalStoragePublicDirectory(ExtStorage.DIRECTORY_DOWNLOADS);
                                              String fileName = snapshot.data.downloadsList[index].title + " " + date.toString();

                                              String fullPath = "$path/$fileName.pdf";
                                              setState(() {
                                                showLoader = true;
                                              });
                                              Navigator.push(context, MaterialPageRoute(builder: (context) {
                                                return PdfViewer(
                                                  flag: "online",
                                                  pdfDocument: snapshot.data.downloadsList[index].downloadsPdf,
                                                );
                                              }));
                                              // downloadFile(dio, snapshot.data.downloadsList[index].downloadsPdf, fullPath);
                                            }),
                                      )
                                    ],
                                  ),
                                );
                              },
                            )
                          : Utils.loader
                    ],
                  );
                } else if (snapshot.connectionState == ConnectionState.waiting) {
                  return Utils.noData;
                } else {
                  return Utils.loader;
                }
              })),
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
}
