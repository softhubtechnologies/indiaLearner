import 'package:india_learner/dao/DownloadsVideoDao.dart';
import 'package:india_learner/models/DownloadVideoModel.dart';

class DownloadsRepository {
  final DownloadsVideoDao downloadsVideoDao = DownloadsVideoDao();

  Future getAllDownloadedVideos({String query}) => downloadsVideoDao.getAllDownloads(query: query);

  Future insertUsers({DownloadVideoModel downloadVideoModel}) => downloadsVideoDao.saveDownloadedVideo(downloadVideoModel);
}
