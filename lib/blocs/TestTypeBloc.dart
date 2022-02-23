import 'package:india_learner/models/TestTypeModel.dart';
import 'package:india_learner/networking/Repository.dart';
import 'package:rxdart/rxdart.dart';

class TestTypeBloc {
  final testTypeFetcher = PublishSubject<List<TestTypeList>>();

  Stream<List<TestTypeList>> get testTypeStream => testTypeFetcher.stream;

  getAllTestTypes() async {
    List<TestTypeList> listTestType = await Repository.getTestTypes();

    testTypeFetcher.sink.add(listTestType);
  }
}

final testTypeBloc = TestTypeBloc();
