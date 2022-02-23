import 'package:india_learner/models/message_reply_list_model.dart';
import 'package:india_learner/networking/Repository.dart';
import 'package:rxdart/rxdart.dart';

class MessageReplyListBloc {
  final messageReplyListCtrl = PublishSubject<MessageReplyListModel>();

  Stream<MessageReplyListModel> get messageReplyListStream => messageReplyListCtrl.stream;

  getMessages() async {
    MessageReplyListModel messageReplyListModel = await Repository.getMessagesList();

    messageReplyListCtrl.sink.add(messageReplyListModel);
  }
}

final messageReplyBloc = MessageReplyListBloc();
