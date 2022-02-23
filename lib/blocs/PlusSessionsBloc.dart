import 'package:india_learner/models/PlusSessionModel.dart';
import 'package:india_learner/networking/Repository.dart';
import 'package:rxdart/rxdart.dart';

class PlusSessionsBloc {
  final plusSessionFetcher = PublishSubject<PlusSessionModel>();

  Stream<PlusSessionModel> get plusSessionStream => plusSessionFetcher.stream;

  fetchPlusSessions({String courseId}) async {
    PlusSessionModel plusSessionModel = await Repository.getPlusSessions(courseId: courseId);

    plusSessionFetcher.sink.add(plusSessionModel);
  }
}

final plusSessionBloc = PlusSessionsBloc();
