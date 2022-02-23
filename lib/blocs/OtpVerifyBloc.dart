import 'package:india_learner/models/OtpVerifyModel.dart';
import 'package:india_learner/networking/Repository.dart';
import 'package:rxdart/rxdart.dart';

class OtpVerifyBloc {
  final otpVerifyCtrl = PublishSubject<OtpVerifyModel>();

  Stream<OtpVerifyModel> get otpVerifyStream => otpVerifyCtrl.stream;

  verifyOtp({String email, String otp}) async {
    OtpVerifyModel otpVerifyModel = await Repository.veriryOtp(email: email, otp: otp);

    otpVerifyCtrl.sink.add(otpVerifyModel);
  }
}

final otpVerifyBloc = OtpVerifyBloc();
