import 'package:india_learner/models/CourseListModel.dart';
import 'package:india_learner/networking/Repository.dart';
import 'package:rxdart/rxdart.dart';

class CourseBloc {
  Repository repository = Repository();

  final courseFetcher = PublishSubject<List<CourseList>>();

  Stream<List<CourseList>> get allCoursesStream => courseFetcher.stream;

  featchAllCourses() async {
    List<CourseList> courseList = await Repository.getCourses();
    courseFetcher.sink.add(courseList);
  }
}

final courseBloc = CourseBloc();
