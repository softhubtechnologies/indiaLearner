import 'package:india_learner/models/message_send_response_model.dart';
import 'package:india_learner/networking/Repository.dart';
import 'package:rxdart/rxdart.dart';

class MessageSendBloc {
  final messageCtrl = PublishSubject<MessageSendResponseModel>();

  Stream<MessageSendResponseModel> get messageSendStream => messageCtrl.stream;

  sendMessage({String message, String date, String time, String teacherId}) async {
    MessageSendResponseModel messageSendResponseModel = await Repository.sendMessage(message: message, date: date, time: time, teacherId: teacherId);

    messageCtrl.sink.add(messageSendResponseModel);
  }
}

final messageSendBloc = MessageSendBloc();
