import 'package:india_learner/models/PlusCourseModel.dart';
import 'package:india_learner/networking/Repository.dart';
import 'package:rxdart/rxdart.dart';

class PlusCoursesBloc {
  final plusCourseFetcher = PublishSubject<List<PlusCourseList>>();

  Stream<List<PlusCourseList>> get allPlusCoursesStream => plusCourseFetcher.stream;

  getPlusCourses() async {
    List<PlusCourseList> listPlusCourse = await Repository.getPlusCourses();

    plusCourseFetcher.sink.add(listPlusCourse);
  }
}

final plusCoursesBloc = PlusCoursesBloc();
