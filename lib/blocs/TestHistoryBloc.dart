import 'package:india_learner/models/TestHistoryModel.dart';
import 'package:india_learner/networking/Repository.dart';
import 'package:rxdart/rxdart.dart';

class TestHistoryBloc {
  final testHistoryController = PublishSubject<TestHistoryModel>();

  Stream<TestHistoryModel> get testHistoryStream => testHistoryController.stream;

  getTestHistory() async {
    TestHistoryModel testHistoryModel = await Repository.getTestHistory();

    testHistoryController.sink.add(testHistoryModel);
  }
}

final testHistoryBloc = TestHistoryBloc();
