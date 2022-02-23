import 'dart:convert';

import 'package:india_learner/models/SubtestModel.dart';
import 'package:india_learner/models/TestDetailsModel.dart';
import 'package:india_learner/networking/Repository.dart';
import 'package:rxdart/rxdart.dart';

class TestDetailsBloc {
  final testDetailsBlocFetcher = PublishSubject<TestDetailsModel>();

  Stream<TestDetailsModel> get testDetailsStream => testDetailsBlocFetcher.stream;

  getTestDetails(SubtestDetailsList subtestDetailsList) async {

    TestDetailsModel testDetailsModel = await Repository.geTestDetails(subtestDetailsList: subtestDetailsList);

      testDetailsBlocFetcher.sink.add(testDetailsModel);
    }
}

final testDetailsBloc = TestDetailsBloc();
