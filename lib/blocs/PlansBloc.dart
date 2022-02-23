import 'package:india_learner/models/plans_model.dart';
import 'package:india_learner/networking/Repository.dart';
import 'package:rxdart/rxdart.dart';

class PlansBloc {
  final plansCtrl = PublishSubject<PlansModel>();

  Stream<PlansModel> get streamPlans => plansCtrl.stream;

  getPlans() async {
    PlansModel plansModel = await Repository.getPlans();

    plansCtrl.sink.add(plansModel);
  }
}

final plansBloc = PlansBloc();
