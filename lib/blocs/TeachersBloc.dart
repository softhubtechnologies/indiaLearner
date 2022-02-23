import 'package:india_learner/models/TeacherListModel.dart';
import 'package:india_learner/networking/Repository.dart';
import 'package:rxdart/rxdart.dart';

class TeachersBloc {
  Repository repository = Repository();

  final teacherFetacher = PublishSubject<List<TeacherList>>();

  Stream<List<TeacherList>> get getTeachersStream => teacherFetacher.stream;

  featchAllTeacher() async {
    List<TeacherList> teacherList = await Repository.getTeachers();
    teacherFetacher.sink.add(teacherList);
  }
}

final teachersBloc = TeachersBloc();
