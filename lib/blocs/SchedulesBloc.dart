import 'package:india_learner/models/SchedulesModel.dart';
import 'package:india_learner/networking/Repository.dart';
import 'package:rxdart/rxdart.dart';

class SchedulesBloc {
  final scheduleFetcherSubject = PublishSubject<List<ScheduleList>>();

  Stream<List<ScheduleList>> get scheduleListStream => scheduleFetcherSubject.stream;

  fetchSchedules() async {
    List<ScheduleList> schedulesList = await Repository.getSchedules();
    scheduleFetcherSubject.sink.add(schedulesList);
    return schedulesList;
  }
}

final scheduleBloc = SchedulesBloc();
