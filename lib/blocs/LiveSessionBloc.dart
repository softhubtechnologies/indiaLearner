import 'package:india_learner/models/LiveSessionListModel.dart';
import 'package:india_learner/networking/Repository.dart';
import 'package:rxdart/rxdart.dart';

class LiveSessionBloc {
  Repository repository = Repository();

  final sessionFetcher = PublishSubject<List<LiveList>>();

  Stream<List<LiveList>> get getSessionList => sessionFetcher.stream;

  fetchAllLiveSessions({String courseId}) async {
    List<LiveList> listSessions = await Repository.getLiveSessionList(courseId: courseId);
    print("LSESSIONS ${listSessions.toString()}");
    sessionFetcher.sink.add(listSessions);
  }
}

final liveSessionBloc = LiveSessionBloc();
