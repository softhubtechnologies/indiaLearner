import 'dart:async';

import 'package:india_learner/models/DownloadVideoModel.dart';
import 'package:india_learner/utils/DownloadsRepository.dart';

class VideoDownloadBloc {
  final downloadRepository = DownloadsRepository();

  final downloadController = StreamController<List<DownloadVideoModel>>.broadcast();

  get downloadList => downloadController.stream;

  VideoDownloadBloc() {
    getDownloads();
  }

  void getDownloads({String query}) async {
    downloadController.sink.add(await downloadRepository.getAllDownloadedVideos(query: query));
  }

  void saveDownloadedVideo(DownloadVideoModel downloadVideoModel) {
    DownloadsRepository downloadsRepository = DownloadsRepository();
    downloadsRepository.insertUsers(downloadVideoModel: downloadVideoModel);
  }
}
