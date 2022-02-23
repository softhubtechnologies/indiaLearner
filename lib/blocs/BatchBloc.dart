import 'package:india_learner/models/BatchModel.dart';
import 'package:india_learner/networking/Repository.dart';
import 'package:rxdart/rxdart.dart';

class BatchBloc {
  final batchFetcher = PublishSubject<List<BatchList>>();

  Stream<List<BatchList>> get batchStream => batchFetcher.stream;

  getBatches() async {
    List<BatchList> batchList = await Repository.fetchBatches();

    batchFetcher.sink.add(batchList);
  }
}

final batchBloc = BatchBloc();
