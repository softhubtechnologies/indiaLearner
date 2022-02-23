import 'dart:io';

import 'package:cached_video_player/cached_video_player.dart';
import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:get/get.dart';
import 'package:india_learner/utils/Color.dart';
import 'package:india_learner/utils/Constants.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerLocal extends StatefulWidget {
  String path, title;

  VideoPlayerLocal(this.path, this.title);

  VideoPlayerLocalState createState() => VideoPlayerLocalState(path, title);
}

class VideoPlayerLocalState extends State<VideoPlayerLocal> {
  String theme, path, title;
  CachedVideoPlayerController controller;
  File file;
  ChewieController chewieController;
  VideoPlayerController _controller;

  VideoPlayerLocalState(this.path, this.title);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = VideoPlayerController.file(File(path))
      ..initialize().then((value) {
        setState(() {
          _controller.play();
        });
      });
    DefaultCacheManager().getSingleFile(path, key: title).then((value) {
      setState(() {
        file = File(value.path);
      });
      print("PPPPPPPPPPPPP ${value.path}");
    });
    print("PATH ${DefaultCacheManager().getSingleFile('http://oneroofcm.com/e_learning/uploads/testing.mp4', key: 'test')}");
    // print("PATH ${path.join(directory.path, 'test')}");
    controller = CachedVideoPlayerController.file(File(path));
    controller.initialize().then((_) {
      setState(() {});
      controller.play();
    });
    chewieController = ChewieController(videoPlayerController: _controller, autoPlay: true, looping: true, materialProgressColors: ChewieProgressColors(playedColor: Colors.purple, handleColor: Colors.purple, backgroundColor: Colors.grey, bufferedColor: Colors.purple[100]));
    final playerWidget = Chewie(
      controller: chewieController,
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    controller.dispose();
    chewieController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    theme = MediaQuery.of(context).platformBrightness == Brightness.dark ? Constants.darkTheme : Constants.lightTheme;

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
        title: Text("title", style: TextStyle(fontSize: 20, color: Colors.black, fontWeight: FontWeight.w600)),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
              height: 400,
              width: Get.size.width,
              child: file != null
                  ? Chewie(
                      controller: chewieController,
                    )
                  /*controller.value != null && controller.value.initialized
                      ? AspectRatio(
                          child: CachedVideoPlayer(controller),
                          aspectRatio: controller.value.aspectRatio,
                        )
                      : Center(
                          child: CircularProgressIndicator(),
                        )*/
                  : Container())
        ],
      ),
    );
  }
}
