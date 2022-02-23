import 'package:india_learner/models/TopVideosModel.dart';
import 'package:india_learner/networking/Repository.dart';
import 'package:rxdart/rxdart.dart';

class TopVideosBloc {
  final topVideosFetcher = PublishSubject<List<TopVideosList>>();

  Stream<List<TopVideosList>> get topVideosStream => topVideosFetcher.stream;

  fetchAllTopVideos() async {
    List<TopVideosList> listTopVideos = await Repository.getTopVideos();

    topVideosFetcher.sink.add(listTopVideos);
  }
}

final topVideosBloc = TopVideosBloc();
