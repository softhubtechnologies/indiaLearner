import 'package:india_learner/models/ClassesSessionListModel.dart';
import 'package:india_learner/networking/Repository.dart';
import 'package:rxdart/rxdart.dart';

class ClassesSessionBloc {
  Repository repository = Repository();

  final classSessionFetcher = PublishSubject<List<VideoList>>();

  Stream<List<VideoList>> get getClassSessionStream => classSessionFetcher.stream;

  fetchClassesSession({String courseId}) async {
    List<VideoList> listClassSessions = await Repository.getClassesSessionList(courseId: courseId);

    classSessionFetcher.sink.add(listClassSessions);
  }
}

final classesSessions = ClassesSessionBloc();
