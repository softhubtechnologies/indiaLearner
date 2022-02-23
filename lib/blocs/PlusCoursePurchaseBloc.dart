import 'package:india_learner/models/PurchasePlusCourseModel.dart';
import 'package:india_learner/networking/Repository.dart';
import 'package:rxdart/rxdart.dart';

class PlusCoursePurchaseBloc {
  final plusCoursePurchaseController = PublishSubject<PurchasePlusCourseModel>();

  Stream get plusCourseStream => plusCoursePurchaseController.stream;

  purchasePlusCourse({String courseId, String price}) async {
    PurchasePlusCourseModel purchasePlusCourseModel = await Repository.purchasePluscourse(courseId: courseId, price: price);

    plusCoursePurchaseController.sink.add(purchasePlusCourseModel);
  }
}

final plusCoursePurchaseBloc = PlusCoursePurchaseBloc();
