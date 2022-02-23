import 'package:india_learner/models/NotificationsListModel.dart';
import 'package:india_learner/networking/Repository.dart';
import 'package:rxdart/rxdart.dart';

class NotificationsListBloc {
  final notificationsCtrl = PublishSubject<NotificationsListModel>();

  Stream<NotificationsListModel> get notificationsStream => notificationsCtrl.stream;

  getNotifications() async {
    NotificationsListModel notificationsListModel = await Repository.getNotifications();

    notificationsCtrl.sink.add(notificationsListModel);
  }
}

final notificationsBloc = NotificationsListBloc();
