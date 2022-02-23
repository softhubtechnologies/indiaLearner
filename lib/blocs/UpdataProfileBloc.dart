import 'package:india_learner/networking/Repository.dart';
import 'package:india_learner/utils/ToastMessage.dart';
import 'package:rxdart/rxdart.dart';

class UpdataProfileBloc {
  final updateProfileCtrl = PublishSubject<Map<String, dynamic>>();

  Stream<Map<String, dynamic>> get updateStream => updateStream;

  updateProfile({Map<String, dynamic> request}) async {
    Map<String, dynamic> response = await Repository.updateProfile(request: request);
    if (response['Status_code'] == '200') {
      ToastMessage.showToast(message: 'Updated successfully', type: true);
    } else {
      ToastMessage.showToast(message: 'Update Failed', type: false);
    }
    updateProfileCtrl.sink.add(response);
  }
}

final updateProfileBloc = UpdataProfileBloc();
