import 'package:india_learner/models/LiveSessionListModel.dart';
import 'package:india_learner/networking/Repository.dart';
import 'package:rxdart/rxdart.dart';

class LiveSessionHomeBloc {
  Repository repository = Repository();

  final sessionFetcher = PublishSubject<List<LiveList>>();

  Stream<List<LiveList>> get getSessionList => sessionFetcher.stream;

  fetchAllLiveSessions({String categoryId, String subcategoryId}) async {
    List<LiveList> listSessions = await Repository.getLiveSessionListHome(ctegoryId: categoryId, subCategoryId: subcategoryId);
    print("LSESSIONS ${listSessions.toString()}");
    sessionFetcher.sink.add(listSessions);
  }
}

final liveSessionHomeBloc = LiveSessionHomeBloc();
