import 'package:india_learner/models/HelpAndSupportSendResponse.dart';
import 'package:india_learner/networking/Repository.dart';
import 'package:rxdart/rxdart.dart';

class HelpAndSupportPostBloc {
  final helpAndsupportCtrl = PublishSubject<HelpAndSupportSendResponse>();

  Stream<HelpAndSupportSendResponse> get helpAndSupportStream => helpAndsupportCtrl.stream;

  postHelp({String message, String date, String time}) async {
    HelpAndSupportSendResponse helpAndSupportSendResponse = await Repository.submitHelpSupport(message: message, date: date, time: time);

    helpAndsupportCtrl.sink.add(helpAndSupportSendResponse);
  }
}

final helpAndSupportBloc = HelpAndSupportPostBloc();
