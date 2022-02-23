import 'package:india_learner/models/WrittenTestModel.dart';
import 'package:india_learner/networking/Repository.dart';
import 'package:rxdart/rxdart.dart';

class WrittenTestBloc {
  final writtenTestController = PublishSubject<WrittenTestModel>();

  Stream<WrittenTestModel> get writtenTestStream => writtenTestController.stream;

  getWrittenTest() async {
    WrittenTestModel writtenTestModel = await Repository.getWrittenTest();

    writtenTestController.sink.add(writtenTestModel);
  }
}

final writtenTestBloc = WrittenTestBloc();
