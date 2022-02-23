import 'dart:convert';
import 'dart:io';

import 'package:chewie/chewie.dart';
import 'package:dio/dio.dart';
import 'package:ext_storage/ext_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:india_learner/models/ClassesSessionListModel.dart';
import 'package:india_learner/models/DownloadVideoModel.dart';
import 'package:india_learner/utils/Color.dart';
import 'package:india_learner/utils/Constants.dart';
import 'package:india_learner/utils/ThemeModel.dart';
import 'package:india_learner/utils/ToastMessage.dart';
import 'package:india_learner/utils/Utils.dart';
import 'package:india_learner/utils/database.dart';
import 'package:india_learner/views/PdfViewer.dart';
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerWidget extends StatefulWidget {
  VideoList videoList;
  VideoPlayerWidget({this.videoList});

  VideoPlayerWidgetState createState() => VideoPlayerWidgetState(videoList: videoList);
}

class VideoPlayerWidgetState extends State<VideoPlayerWidget> {
  String videoUrl, title;
  VideoPlayerController _controller;
  VideoList videoList;

  VideoPlayerWidgetState({this.videoList});
  String theme;
  ChewieController chewieController;
  bool isDownloading = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getPermission();
    title = videoList.title;
    videoUrl = videoList.video;
    print("videoUrl ${videoUrl}");
    _controller = VideoPlayerController.network(videoUrl)
      ..initialize().then((_) {
        setState(() {});
        _controller.play();
        setState(() {});
      });
    chewieController = ChewieController(videoPlayerController: _controller, autoPlay: true, looping: true, materialProgressColors: ChewieProgressColors(playedColor: Colors.purple, handleColor: Colors.purple, backgroundColor: Colors.grey, bufferedColor: Colors.purple[100]));

    /*_controller = VideoPlayerController.network(videoUrl)
      ..initialize().then((value) {
        setState(() {
          _controller.play();
          setState(() {});
        });
      });*/
    //initNotification();
    print("TTTTTT${videoList.video}");
    chewieController = ChewieController(videoPlayerController: _controller, autoPlay: true, looping: true, materialProgressColors: ChewieProgressColors(playedColor: Colors.purple, handleColor: Colors.purple, backgroundColor: Colors.grey, bufferedColor: Colors.purple[100]));
    final playerWidget = Chewie(
      controller: chewieController,
    );
    Future.delayed(Duration(seconds: 3), () {
      setState(() {});
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controller.dispose();
    chewieController.dispose();
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
        actions: <Widget>[
          /*PopupMenuButton<String>(
            icon: Icon(
              Icons.download_outlined,
              color: Colors.black87,
            ),
            onSelected: handleClick,
            itemBuilder: (BuildContext context) {
              return {'Download video', 'Download notes'}.map((String choice) {
                return PopupMenuItem<String>(
                  value: choice,
                  child: Text(choice),
                );
              }).toList();
            },
          ),
          SizedBox(
            width: 24,
          )*/
        ],
        title: Text(title, style: TextStyle(fontSize: 20, color: Colors.black, fontWeight: FontWeight.w600)),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          AspectRatio(
              child: _controller != null
                  ? Container(
                      //height: 400,
                      height: 400,
                      width: Get.size.width * 2,
                      child: Chewie(
                        controller: chewieController,
                      ))
                  : CircularProgressIndicator(),
              aspectRatio: 1.1),
          Container(
            width: Get.size.width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 20),
                  child: Text(
                    title,
                    style: TextStyle(fontSize: 20, color: Colors.black87, fontWeight: FontWeight.w700),
                  ),
                ),
                SizedBox(
                  height: 14,
                ),
                Row(
                  children: [
                    //Expanded(flex: 1, child: Container()),
                    Expanded(
                        flex: 4,
                        child: videoList.video != ""
                            ? isDownloading == false
                                ? GestureDetector(
                                    onTap: () {
                                      downloadFile();
                                    },
                                    child: Column(
                                      children: [
                                        Container(
                                          height: 35,
                                          width: 35,
                                          decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.grey),
                                          child: Center(
                                            child: Icon(
                                              Icons.download_sharp,
                                              color: Colors.black.withOpacity(0.6),
                                            ),
                                          ),
                                        ),
                                        Text(
                                          'Download',
                                          style: TextStyle(fontSize: 12, color: theme == Constants.lightTheme ? Colors.black87 : Colors.white, fontWeight: FontWeight.w400),
                                        ),
                                      ],
                                    ),
                                  )
                                : Container(
                                    height: 30,
                                    width: 30,
                                    child: Utils.loader,
                                  )
                            : Container()),
                    Expanded(
                        flex: 4,
                        child: videoList.image != ""
                            ? GestureDetector(
                                onTap: () {
                                  downloadNotes();
                                },
                                child: Column(
                                  children: [
                                    Container(
                                      height: 35,
                                      width: 35,
                                      decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.grey),
                                      child: Center(
                                        child: Icon(
                                          Icons.download_sharp,
                                          color: Colors.black.withOpacity(0.6),
                                        ),
                                      ),
                                    ),
                                    Text(
                                      'Download notes',
                                      style: TextStyle(fontSize: 12, color: theme == Constants.lightTheme ? Colors.black87 : Colors.white, fontWeight: FontWeight.w400),
                                    ),
                                  ],
                                ),
                              )
                            : Container()),
                    Expanded(
                        flex: 4,
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) {
                              return PdfViewer(flag: "online", pdfDocument: videoList.image);
                            }));
                          },
                          child: Column(
                            children: [
                              Container(
                                height: 35,
                                width: 35,
                                decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.grey),
                                child: Center(
                                  child: Icon(
                                    Icons.picture_as_pdf,
                                    color: Colors.black.withOpacity(0.6),
                                  ),
                                ),
                              ),
                              Text(
                                'Read notes',
                                style: TextStyle(fontSize: 12, color: theme == Constants.lightTheme ? Colors.black87 : Colors.white, fontWeight: FontWeight.w600),
                              ),
                            ],
                          ),
                        )),
                    Expanded(flex: 4, child: Container()),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  buildVideoPlayer() {
    return AspectRatio(
      aspectRatio: _controller.value.aspectRatio,
      child: VideoPlayer(_controller),
    );
  }

  Widget buildIndicator() {
    return VideoProgressIndicator(
      _controller,
      padding: EdgeInsets.only(left: 5, right: 5, bottom: 10),
      allowScrubbing: true,
    );
  }

  Widget buildPlay() {
    return _controller.value.isPlaying
        ? Container()
        : Container(
//            alignment: Alignment.center,
            color: Colors.black26,
            child: Icon(Icons.play_arrow, color: Colors.white, size: 50),
          );
  }

  void handleClick(String value) {
    switch (value) {
      case 'Download video':
        downloadFile();
        break;
      case 'Download notes':
        break;
    }
  }

  Future downloadFile() async {
    setState(() {
      isDownloading = true;
    });
    DownloadVideoModel downloadVideoModel = DownloadVideoModel();

    print(videoUrl);
    Stream<FileResponse> fileStream;
    setState(() {
      List<dynamic> list = [];

      fileStream = DefaultCacheManager().getFileStream(videoUrl, withProgress: true, key: 'test');
      DefaultCacheManager().getSingleFile(videoUrl, key: videoList.title).then((value) {
        print('TTTTT ${value.path}');
        String file = value.path;
        List<String> listDownloads = [];
        Map<String, dynamic> map = {'title': videoList.title, 'file': value.path};
        Database.initDatabase();
        downloadVideoModel.title = videoList.title;
        downloadVideoModel.file = value.path;

        String str = Database.getDownloadedVideos();
        if (str != null && str != "" && str != " ") {
          list = json.decode(str);
          for (int i = 0; i < list.length; i++) {
            Map<String, dynamic> mapTemp = list[i];
            listDownloads.add(json.encode(mapTemp));
          }
          print("TTTT ${map['file']}");
        }

        print('TTTTT ${listDownloads.toString()} ${list.toString()}');
        listDownloads.add(json.encode(map));

        Database.downloadVideo(videoJson: listDownloads.toString());
        print('TTTTT ${listDownloads.toString()}');
        setState(() {
          isDownloading = false;
        });
      });
    });
  }

  void getPermission() async {
    await Permission.storage.request();
    await Permission.mediaLibrary.request();

    /*await Permission.mediaLibrary.request();

    var status = await Permission.storage.status;
    if (!status.isGranted) {
      await Permission.storage.request();
    }*/
  }

  void downloadNotes() async {
    String path = await ExtStorage.getExternalStoragePublicDirectory(ExtStorage.DIRECTORY_DOWNLOADS);
    var format = DateFormat('yyyy-MM-dd hh:MM:ss');
    DateTime date = DateTime.now();
    String fileName = 'Notes ' + videoList.title + format.format(date).toString();
    String fullPath = "$path/$fileName.pdf";

    Map<String, dynamic> map = {'title': videoList.title, 'path': fullPath};
    List<String> listJson = [];
    listJson.add(json.encode(map));
    Database.initDatabase();
    print("LLLLLLLLL ${listJson.toString()}");
    Database.downloadNotes(listJson.toString());
    Dio dio = Dio();
    try {
      var response = await dio.post(
        videoList.image,
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

  void showDownloadProgress(int count, int total) {
    print("Progress ${total.toString()} ${count.toString()}");
  }

  void initNotification() async {
    FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    const AndroidInitializationSettings initializationSettingsAndroid = AndroidInitializationSettings('app_icon');
    final IOSInitializationSettings initializationSettingsIOS = IOSInitializationSettings(onDidReceiveLocalNotification: onDidReceiveLocalNotification);
    final InitializationSettings initializationSettings = InitializationSettings(android: initializationSettingsAndroid, iOS: initializationSettingsIOS);
    flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
    );

    var androidPlatformChannelSpecifics = AndroidNotificationDetails('channel_ID', 'channel_name', 'channel description',
        importance: Importance.high,
        playSound: true,
        // sound: 'sound',
        showProgress: true,
        priority: Priority.high,
        ticker: 'test ticker');

    var platformChannelSpecifics = NotificationDetails(android: androidPlatformChannelSpecifics);
    print("Channel :${platformChannelSpecifics.android.channelId}");
    await flutterLocalNotificationsPlugin.show(0, 'title', 'body', platformChannelSpecifics, payload: 'Default_Sound');
  }

  Future onDidReceiveLocalNotification(int id, String title, String body, String payload) {}
}
