import 'package:india_learner/models/DownloadsSideMenuModel.dart';
import 'package:india_learner/networking/Repository.dart';
import 'package:rxdart/rxdart.dart';

class DownloadsBloc {
  final downloadsCtrl = PublishSubject<DownloadsSideMenuModel>();

  Stream<DownloadsSideMenuModel> get downloadsStream => downloadsCtrl.stream;

  getDownloads() async {
    DownloadsSideMenuModel downloadsSideMenuModel = await Repository.getDownlods();

    downloadsCtrl.sink.add(downloadsSideMenuModel);
  }
}

final downloadsBloc = DownloadsBloc();
