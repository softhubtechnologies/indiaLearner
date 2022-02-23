import 'package:india_learner/models/EnrollmentsModel.dart';
import 'package:india_learner/networking/Repository.dart';
import 'package:rxdart/rxdart.dart';

class EnrollmentsBloc {
  final enrollmentsFetcher = PublishSubject<List<EnrollmentsList>>();

  Stream<List<EnrollmentsList>> get enrollmentsListStream => enrollmentsFetcher.stream;

  fetchAllEnrollments() async {
    List<EnrollmentsList> listEnrollment = await Repository.getEnrollments();
    enrollmentsFetcher.sink.add(listEnrollment);
  }
}

final enrollmentsBloc = EnrollmentsBloc();
