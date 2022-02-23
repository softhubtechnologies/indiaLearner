import 'package:india_learner/models/SendOtpResponseModel.dart';
import 'package:india_learner/networking/Repository.dart';
import 'package:rxdart/rxdart.dart';

class SendOtpBloc {
  final sendOtpCtrl = PublishSubject<SendOtpResponseModel>();

  Stream<SendOtpResponseModel> get sendOtpResponseStream => sendOtpCtrl.stream;

  sendOtp({String email}) async {
    SendOtpResponseModel sendOtpResponseModel = await Repository.sendOtp(email: email);

    sendOtpCtrl.sink.add(sendOtpResponseModel);
  }
}

final sendOtpBloc = SendOtpBloc();
