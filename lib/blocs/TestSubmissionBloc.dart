import 'package:india_learner/models/TestsubmissionModel.dart';
import 'package:india_learner/networking/Repository.dart';
import 'package:rxdart/rxdart.dart';

class TestSubmissionBloc {
  final testSubmissionController = PublishSubject<TestsubmissionModel>();

  Stream<TestsubmissionModel> get testSubmissionStream => testSubmissionController.stream;

  submitTest({String answerSheet, String testType, String totalMarks, String obtainMarks, String testName}) async {
    TestsubmissionModel testsubmissionModel = await Repository.testSubmission(answerSheet: answerSheet, testType: testType, testName: testName, totalMarks: totalMarks, obtainMarks: obtainMarks);
    testSubmissionController.sink.add(testsubmissionModel);
  }
}

final testSubmissionBloc = TestSubmissionBloc();
