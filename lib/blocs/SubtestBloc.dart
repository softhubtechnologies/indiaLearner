import 'package:india_learner/models/SubtestModel.dart';
import 'package:india_learner/networking/Repository.dart';
import 'package:rxdart/rxdart.dart';

class SubtestBloc {
  final subtestFetcher = PublishSubject<List<SubtestDetailsList>>();

  Stream<List<SubtestDetailsList>> get subTestStream => subtestFetcher.stream;

  getAllSubTest({String testTypeId}) async {
    List<SubtestDetailsList> listSubtest = await Repository.getSubTest(testTypeId: testTypeId);

    subtestFetcher.sink.add(listSubtest);
  }
}

final subtestBloc = SubtestBloc();
