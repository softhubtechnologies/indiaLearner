import 'package:india_learner/models/HelpSupportListResponseModel.dart';
import 'package:india_learner/networking/Repository.dart';
import 'package:rxdart/rxdart.dart';

class HelpMessageBloc {
  final helpCtrl = PublishSubject<HelpSupportListResponseModel>();

  Stream<HelpSupportListResponseModel> get helpListStream => helpCtrl.stream;

  getHelpSupportList() async {
    HelpSupportListResponseModel helpSupportListResponseModel = await Repository.getHelpMessageList();

    helpCtrl.sink.add(helpSupportListResponseModel);
  }
}

final helpMessagesBloc = HelpMessageBloc();
