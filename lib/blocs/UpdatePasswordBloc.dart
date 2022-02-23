import 'package:india_learner/models/UpdatePasswordResponseModel.dart';
import 'package:india_learner/networking/Repository.dart';
import 'package:rxdart/rxdart.dart';

class UpdatePasswordBloc {
  final updatePasswordCtrl = PublishSubject<UpdatePasswordResponseModel>();

  Stream<UpdatePasswordResponseModel> get updatePasswordStream => updatePasswordCtrl.stream;

  updatePassword({String email, String password}) async {
    UpdatePasswordResponseModel updatePasswordResponseModel = await Repository.updatePassword(email: email, password: password);

    updatePasswordCtrl.sink.add(updatePasswordResponseModel);
  }
}

final updatePasswordBloc = UpdatePasswordBloc();
