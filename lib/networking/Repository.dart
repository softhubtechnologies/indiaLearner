import 'dart:convert';

import 'package:get/route_manager.dart';
import 'package:india_learner/models/BatchModel.dart';
import 'package:india_learner/models/ClassesSessionListModel.dart';
import 'package:india_learner/models/CourseListModel.dart';
import 'package:india_learner/models/DownloadsSideMenuModel.dart';
import 'package:india_learner/models/EnrollmentsModel.dart';
import 'package:india_learner/models/HelpAndSupportSendResponse.dart';
import 'package:india_learner/models/HelpSupportListResponseModel.dart';
import 'package:india_learner/models/LiveSessionListModel.dart';
import 'package:india_learner/models/LoginModel.dart';
import 'package:india_learner/models/NotificationsListModel.dart';
import 'package:india_learner/models/OtpVerifyModel.dart';
import 'package:india_learner/models/PlusCourseModel.dart';
import 'package:india_learner/models/PlusSessionModel.dart';
import 'package:india_learner/models/PurchasePlusCourseModel.dart';
import 'package:india_learner/models/SchedulesModel.dart';
import 'package:india_learner/models/SendOtpResponseModel.dart';
import 'package:india_learner/models/SignupModel.dart';
import 'package:india_learner/models/SubtestModel.dart';
import 'package:india_learner/models/TeacherListModel.dart';
import 'package:india_learner/models/TestDetailsModel.dart';
import 'package:india_learner/models/TestHistoryModel.dart';
import 'package:india_learner/models/TestTypeModel.dart';
import 'package:india_learner/models/TestsubmissionModel.dart';
import 'package:india_learner/models/TopVideosModel.dart';
import 'package:india_learner/models/UpdatePasswordResponseModel.dart';
import 'package:india_learner/models/WrittenTestModel.dart';
import 'package:india_learner/models/downloads_model.dart';
import 'package:india_learner/models/message_reply_list_model.dart';
import 'package:india_learner/models/message_send_response_model.dart';
import 'package:india_learner/models/plans_model.dart';
import 'package:india_learner/utils/ToastMessage.dart';
import 'package:india_learner/utils/database.dart';
import 'package:india_learner/views/CategoriesPage.dart';
import 'package:india_learner/views/DashBoard.dart';

import 'ApiHandler.dart';
import 'ApiProvider.dart';
import 'EndApi.dart';

class Repository {
  // All COURSES FETCH API by catId,subCatIS
  static Future<List<CourseList>> getCourses() async {
    Database.initDatabase();
    print("REQUEST COURSE ${Database.getUserID()}");
    var obj = {'category_id': Database.getSelectedCategoryId(), 'subcategory_id': Database.getSubcategoryId(), 'user_id': Database.getUserID()};
    print("REQUEST COURSE ${obj}");
    return ApiHandler.postApi(baseUrl: ApiProvider.baseUrl, endApi: EndApi.courseList, map: obj).then((value) {
      List<CourseList> courseList = CourseListModel.fromJson(value).courseList;
      return courseList;
    });
  }

  //FETCH ALL TEACHERS API CATID,SUBCATID
  static Future<List<TeacherList>> getTeachers() async {
    Database.initDatabase();

    var obj = {'category_id': Database.getSelectedCategoryId(), 'subcategory_id': Database.getSubcategoryId()};
    print("REQUEST TEACHERS ${obj}");
    return ApiHandler.postApi(baseUrl: ApiProvider.baseUrl, endApi: EndApi.teachersList, map: obj).then((value) {
      List<TeacherList> teachersList = TeacherListModel.fromJson(value).teacherList;
      return teachersList;
    });
  }

  //UPDATE CATEGORY API
  static Future<Map<String, dynamic>> updateCategory({String categoryName, String categoryId, String subCategoryId, String classId}) {
    var obj = {'id': Database.getUserID(), 'category_name': categoryName, 'category_id': categoryId, 'subcategory_id': subCategoryId, 'class_id': classId};
    print("REQUEST  ${obj.toString()}");

    ApiHandler.putApi(baseUrl: ApiProvider.baseUrl, endApi: EndApi.updateCaegory, map: json.encode(obj)).then((value) {
      print("RES ${value.toString()}");
      if (value['Status_code'] == '200') {
        ToastMessage.showToast(message: 'Category updated successfuly', type: true);
        print("RES ${subCategoryId}");
        Database.initDatabase();
        Database.saveSelectedCategory(category: categoryName, categoryId: categoryId);
        print("RES ${Database.getSelectedCategoryId()}");
        // Get.to(ClassSelectionPage());
        Get.off(DashBoard());
      }
    });
  }

  //LOGIN API CALL
  static Future<Map<String, dynamic>> login({String email, String password}) {
    Database.initDatabase();
    var obj = {'email': email, 'password': password};
    ApiHandler.postApi(baseUrl: ApiProvider.baseUrl, endApi: EndApi.login, map: obj).then((value) {
      if (value['Status_code'] == '200') {
        LoginModel loginModel = LoginModel.fromJson(value);
        Database.initDatabase();
        Database.saveUserId(loginModel.result.userId);

        if (loginModel.result.categoryName != null) {
          Database.saveSelectedCategory(
            category: loginModel.result.categoryName,
            categoryId: loginModel.result.categoryId,
          );
          Database.saveSubCategory(subcatId: loginModel.result.subcategoryId, subcategory: "");
          Get.offAll(DashBoard());
        } else {
          Get.offAll(CategoriesPage());
        }
      } else {
        ToastMessage.showToast(message: 'Invalid email or password', type: false);
      }
    });
  }

  //SIGNUP API CALL
  static Future<Map<String, dynamic>> signup({String fName, String lName, String mno, String email, String bio, String password}) {
    var obj = {"first_name": fName, "last_name": lName, "mobile_number": mno, "email": email, "password": password, "bio": bio};
    print("REQUEST  ${obj}");

    ApiHandler.postApi(baseUrl: ApiProvider.baseUrl, endApi: EndApi.createAccount, map: obj).then((value) {
      print("RESPONSE ${value.toString()}");
      if (value['Status_code'] == '200') {
        SignupModel signupModel = SignupModel.fromJson(value);
        Database.initDatabase();
        Database.saveUserId(signupModel.result.userId);
        Get.to(CategoriesPage());
        print("RESPONSE ID ${Database.getUserID()}");
      } else {
        ToastMessage.showToast(message: value['Message'], type: false);
      }
    });
  }

  //SUBSCRIBE API CALL
  static Future<Map<String, dynamic>> subscribe({String planName, String plan_id, String payment_id}) {
    Database.initDatabase();

    var obj = {'user_id': Database.getUserID(), 'category_id': Database.getSelectedCategoryId(), 'subcategory_id': Database.getSubcategoryId(), 'plan_name': '1Month', "plan_id": plan_id, "payment_id": payment_id};

    print("REQ ${obj.toString()}");

    return ApiHandler.postApi(baseUrl: ApiProvider.baseUrl, endApi: EndApi.subscription, map: obj).then((value) {
      print("RES ${value.toString()}");

      if (value['Status_code'] == '200') {
        ToastMessage.showToast(message: 'Subscription  successfuly', type: true);
      }
    });
  }

  //TOP VIDEOS API
  static Future<Map<String, dynamic>> getVideos() {
    return ApiHandler.getApi(baseUrl: ApiProvider.baseUrl, endApi: EndApi.courseVideos);
  }

  //CLASSES API FOR SELECT CLASS IF SCHOOL CLASS OR ANY SUBCAT HAVING CLASS
  static Future<Map<String, dynamic>> getClasses() async {
    var obj = {'category_id': Database.getSelectedCategoryId(), 'subcategory_id': Database.getSubcategoryId()};
    print("REQUEST ${obj.toString()}");

    return ApiHandler.postApi(baseUrl: ApiProvider.baseUrl, endApi: EndApi.classes, map: obj);
  }

  //API FOR ADVERTISEMENTS BANERS
  static Future<Map<String, dynamic>> advertisement() {
    Database.initDatabase();

    var obj = {
      'category_id': Database.getSelectedCategoryId(),
    };

    return ApiHandler.postApi(baseUrl: ApiProvider.baseUrl, endApi: EndApi.advertisement, map: obj);
  }

  // LIVE SESSION LIST API
  static Future<List<LiveList>> getLiveSessionList({String courseId}) async {
    var obj = {'course_id': courseId};
    print("REQ ${obj.toString()}");

    return ApiHandler.postApi(baseUrl: ApiProvider.baseUrl, endApi: EndApi.live_session_list, map: obj).then((value) {
      List<LiveList> listSessions = LiveSessionListModel.fromJson(value).liveList;
      return listSessions;
    });
  }

  //FREE COURSES OR CLASSES VIDEO SESSION API
  static Future<List<VideoList>> getClassesSessionList({String courseId}) async {
    var obj = {'course_id': courseId};

    return ApiHandler.postApi(baseUrl: ApiProvider.baseUrl, endApi: EndApi.freeClassesSessions, map: obj).then((value) {
      List<VideoList> listSessions = ClassesSessionListModel.fromJson(value).videoList;
      return listSessions;
    });
  }

  // ENROLLMENTS API
  static Future<List<EnrollmentsList>> getEnrollments() async {
    Database.initDatabase();
    String userId = Database.getUserID();
    var obj = {'user_id': userId};

    return ApiHandler.postApi(baseUrl: ApiProvider.baseUrl, endApi: EndApi.enrollments, map: obj).then((value) {
      List<EnrollmentsList> listSessions = EnrollmentsModel.fromJson(value).enrollmentsList;
      return listSessions;
    });
  }

  // API FOR SCHEDULES
  static Future<List<ScheduleList>> getSchedules() async {
    Database.initDatabase();
    String userId = Database.getUserID();
    var obj = {'user_id': userId};
    print("REQ ${obj}");

    return ApiHandler.postApi(baseUrl: ApiProvider.baseUrl, endApi: EndApi.schedule, map: obj).then((value) {
      List<ScheduleList> listSchedules = SchedulesModel.fromJson(value).scheduleList;
      return listSchedules;
    });
  }

  // TOP VIDEOS API
  static Future<List<TopVideosList>> getTopVideos() async {
    Database.initDatabase();
    var obj = {'category_id': Database.getSelectedCategoryId(), 'subcategory_id': Database.getSubcategoryId()};

    return ApiHandler.postApi(baseUrl: ApiProvider.baseUrl, endApi: EndApi.topVideos, map: obj).then((value) {
      List<TopVideosList> listTopVideos = TopVideosModel.fromJson(value).topVideosList;

      return listTopVideos;
    });
  }

  //TEST TYPE API
  static Future<List<TestTypeList>> getTestTypes() async {
    Database.initDatabase();
    var obj = {'category_id': Database.getSelectedCategoryId(), 'subcategory_id': Database.getSubcategoryId()};

    return ApiHandler.postApi(baseUrl: ApiProvider.baseUrl, endApi: EndApi.testType, map: obj).then((value) {
      List<TestTypeList> listTestType = TestTypeModel.fromJson(value).testTypeList;

      return listTestType;
    });
  }

// SUB TEST API
  static Future<List<SubtestDetailsList>> getSubTest({String testTypeId}) async {
    Database.initDatabase();
    var obj = {'test_type_id': testTypeId};

    return ApiHandler.postApi(baseUrl: ApiProvider.baseUrl, endApi: EndApi.subtest, map: obj).then((value) {
      List<SubtestDetailsList> listSubTest = SubtestModel.fromJson(value).subtestDetailsList;

      return listSubTest;
    });
  }

  //TEST DETAILS API
  static Future<TestDetailsModel> geTestDetails({SubtestDetailsList subtestDetailsList}) async {
    Database.initDatabase();
    var obj = {'subtest': "16" /*subtestDetailsList.id*/, 'category_id': Database.getSelectedCategoryId(), 'subcategory_id': Database.getSubcategoryId(), 'test_type': subtestDetailsList.testTypeId, 'user_id': Database.getUserID()};
    print("REQUEST ${obj}");
    return ApiHandler.postApi(baseUrl: ApiProvider.baseUrl, endApi: EndApi.testDetails, map: obj).then((value) {
      TestDetailsModel testDetailsModel = TestDetailsModel.fromJson(value);

      return testDetailsModel;
    });
  }

  //API FOR FETCH PLUS COURSES
  static Future<List<PlusCourseList>> getPlusCourses() async {
    Database.initDatabase();
    var obj = {
      'category_id': Database.getSelectedCategoryId(),
      'subcategory_id': Database.getSubcategoryId(),
    };

    return ApiHandler.postApi(baseUrl: ApiProvider.baseUrl, endApi: EndApi.plusCourses, map: obj).then((value) {
      List<PlusCourseList> plusCourseList = PlusCourseModel.fromJson(value).plusCourseList;

      return plusCourseList;
    });
  }

  //API FOR FETCH BATCHES
  static Future<List<BatchList>> fetchBatches() {
    var obj = {
      'category_id': '1' /*Database.getSelectedCategoryId()*/,
      'subcategory_id': /* Database.getSubcategoryId()*/ '18',
    };

    return ApiHandler.postApi(baseUrl: ApiProvider.baseUrl, endApi: EndApi.batch, map: obj).then((value) {
      List<BatchList> batchList = BatchModel.fromJson(value).batchList;
      return batchList;
    });
  }

  // LIVE SESSION LIST FOR HOME SCREEN
  static Future<List<LiveList>> getLiveSessionListHome({String ctegoryId, String subCategoryId}) async {
    Database.initDatabase();
    var obj = {'category_id': Database.getSelectedCategoryId(), 'subcategory_id': Database.getSubcategoryId(), "user_id": Database.getUserID()};
    print("REQ SessionListHome ${obj.toString()}");

    return ApiHandler.postApi(baseUrl: ApiProvider.baseUrl, endApi: EndApi.sessionListHome, map: obj).then((value) {
      List<LiveList> listSessions = LiveSessionListModel.fromJson(value).liveList;
      print("REQ SessionListHome CONT ${value.toString()}");

      return listSessions;
    });
  }

  // PLUS COURSE COMBINE SESSIONS API
  static Future<PlusSessionModel> getPlusSessions({String courseId}) {
    var request = {"course_id": courseId};
    return ApiHandler.postApi(baseUrl: ApiProvider.baseUrl, endApi: EndApi.plusSession, map: request).then((value) {
      PlusSessionModel plusSessionModel = PlusSessionModel.fromJson(value);

      return plusSessionModel;
    });
  }

  // PURCHASE PLUS COURSE
  static Future<PurchasePlusCourseModel> purchasePluscourse({String courseId, String price}) async {
    Database.initDatabase();
    var request = {"category_id": Database.getSelectedCategoryId(), "course_id": courseId, "price": price, "subcategory_id": Database.getSubcategoryId(), "user_id": Database.getUserID()};
    return ApiHandler.postApi(baseUrl: ApiProvider.baseUrl, endApi: EndApi.plusCourseSubscription, map: request).then((value) {
      PurchasePlusCourseModel purchasePlusCourseModel = PurchasePlusCourseModel.fromJson(value);

      return purchasePlusCourseModel;
    });
  }

  // WRITTEN TEST API
  static Future<WrittenTestModel> getWrittenTest() {
    Database.initDatabase();
    var request = {"category_id": Database.getSelectedCategoryId(), "subcategory_id": Database.getSubcategoryId()};
    print("SSSSSSSSSSSSSSS request ${request.toString()}");

    return ApiHandler.postApi(baseUrl: ApiProvider.baseUrl, endApi: EndApi.writtenTestGet, map: request).then((value) {
      WrittenTestModel writtenTestModel = WrittenTestModel.fromJson(value);

      return writtenTestModel;
    });
  }

  static Future<TestsubmissionModel> testSubmission({String answerSheet, String testType, String totalMarks, String obtainMarks, String testName}) {
    Database.initDatabase();
    var request = {
      "category_id": Database.getSelectedCategoryId(),
      "subcategory_id": Database.getSubcategoryId(),
      "user_id": Database.getUserID(),
      "test_id": Database.getUserID(),
      "test_name": testName,
      "answer_sheet": answerSheet,
      "test_type": testType,
      "obtain_marks": answerSheet,
      "total_marks": totalMarks
    };

    print("SSSSSSSSSSSSSSS wriren request ${request.toString()}");

    return ApiHandler.postApi(baseUrl: ApiProvider.baseUrl, endApi: EndApi.test_result, map: request).then((value) {
      print("SSSSSSSSSSSSSSS Response ${value.toString()}");

      TestsubmissionModel testsubmissionModel = TestsubmissionModel.fromJson(value);
    });
  }

  static Future<TestHistoryModel> getTestHistory() async {
    Database.initDatabase();
    var request = {"category_id": Database.getSelectedCategoryId(), "subcategory_id": Database.getSubcategoryId(), "user_id": Database.getUserID()};
    print("SSSSSSSSSSSSSSS ${request.toString()}");

    return ApiHandler.postApi(baseUrl: ApiProvider.baseUrl, endApi: EndApi.resultHistory, map: request).then((value) {
      TestHistoryModel testHistoryModel = TestHistoryModel.fromJson(value);
      print("SSSSSSSSSSSSSSS ${value.toString()}");

      return testHistoryModel;
    });
  }

  static Future<MessageSendResponseModel> sendMessage({String message, String date, String time, String teacherId}) async {
    Database.initDatabase();
    var request = {"teacher_id": teacherId, "message": message, "user_id": Database.getUserID(), "date": date, "time": time};

    return ApiHandler.postApi(baseUrl: ApiProvider.baseUrl, endApi: EndApi.message, map: request).then((value) {
      MessageSendResponseModel messageSendResponseModel = MessageSendResponseModel.fromJson(value);

      return messageSendResponseModel;
    });
  }

  static Future<MessageReplyListModel> getMessagesList() async {
    Database.initDatabase();
    var request = {"user_id": Database.getUserID()};

    return ApiHandler.postApi(baseUrl: ApiProvider.baseUrl, endApi: EndApi.messageReplyList, map: request).then((value) {
      MessageReplyListModel messageReplyListModel = MessageReplyListModel.fromJson(value);

      return messageReplyListModel;
    });
  }

  static Future<HelpAndSupportSendResponse> submitHelpSupport({String message, String date, String time}) async {
    Database.initDatabase();
    var request = {"message": message, "user_id": Database.getUserID(), "time": time, "date": date};
    return ApiHandler.postApi(baseUrl: ApiProvider.baseUrl, endApi: EndApi.helpSupport, map: request).then((value) {
      HelpAndSupportSendResponse helpAndSupportSendResponse = HelpAndSupportSendResponse.fromJson(value);

      return helpAndSupportSendResponse;
    });
  }

  static Future<SendOtpResponseModel> sendOtp({String email}) async {
    var request = {"email": email};
    return ApiHandler.postApi(baseUrl: ApiProvider.baseUrl, endApi: EndApi.forget_password_send, map: request).then((value) {
      SendOtpResponseModel sendOtpResponseModel = SendOtpResponseModel.fromJson(value);

      return sendOtpResponseModel;
    });
  }

  static Future<OtpVerifyModel> veriryOtp({String email, String otp}) async {
    var request = {"email": email, "otp": otp};
    return ApiHandler.postApi(baseUrl: ApiProvider.baseUrl, endApi: EndApi.verify_otp, map: request).then((value) {
      OtpVerifyModel otpVerifyModel = OtpVerifyModel.fromJson(value);

      return otpVerifyModel;
    });
  }

  static Future<UpdatePasswordResponseModel> updatePassword({String email, String password}) async {
    var request = {"email": email, "password": password};

    return ApiHandler.postApi(baseUrl: ApiProvider.baseUrl, endApi: EndApi.change_password, map: request).then((value) {
      UpdatePasswordResponseModel updatePasswordResponseModel = UpdatePasswordResponseModel.fromJson(value);

      return updatePasswordResponseModel;
    });
  }

  static Future<HelpSupportListResponseModel> getHelpMessageList() async {
    Database.initDatabase();
    var request = {"user_id": Database.getUserID()};
    return ApiHandler.postApi(baseUrl: ApiProvider.baseUrl, endApi: EndApi.help_support_reply_list, map: request).then((value) {
      HelpSupportListResponseModel helpSupportListResponseModel = HelpSupportListResponseModel.fromJson(value);

      return helpSupportListResponseModel;
    });
  }

  static Future<DownloadsSideMenuModel> getDownlods() async {
    Database.initDatabase();
    var request = {"category_id": Database.getSelectedCategoryId(), "subcategory_id": Database.getSubcategoryId()};
    print("REQUEST ${request}");
    return ApiHandler.postApi(baseUrl: ApiProvider.baseUrl, endApi: EndApi.downloads, map: request).then((value) {
      DownloadsSideMenuModel downloadsSideMenuModel = DownloadsSideMenuModel.fromJson(value);
      print("REQUEST ${downloadsSideMenuModel.statusCode}");

      return downloadsSideMenuModel;
    });
  }

  static Future<NotificationsListModel> getNotifications() async {
    Database.initDatabase();
    var request = {"category_id": Database.getSelectedCategoryId(), "subcategory_id": Database.getSubcategory(), "type": "Teache Message Reply"};

    print("REQUEST ${request}");

    return ApiHandler.postApi(baseUrl: ApiProvider.baseUrl, endApi: EndApi.notification_list, map: request).then((value) {
      NotificationsListModel notificationsListModel = NotificationsListModel.fromJson(value);

      return notificationsListModel;
    });
  }

  static Future<PlansModel> getPlans() {
    Database.initDatabase();
    var request = {"category_id": Database.getSelectedCategoryId()};

    return ApiHandler.postApi(baseUrl: ApiProvider.baseUrl, endApi: EndApi.plan_list, map: request).then((value) {
      PlansModel plansModel = PlansModel.fromJson(value);

      return plansModel;
    });
  }

  static Future<TestsubmissionModel> writtenTestSubmission({String answerSheet, String testType, String totalMarks, String obtainMarks, String testName}) {
    Database.initDatabase();
    var request = {
      "category_id": Database.getSelectedCategoryId(),
      "subcategory_id": Database.getSubcategoryId(),
      "user_id": Database.getUserID(),
      "test_id": Database.getUserID(),
      "test_name": testName,
      "answer_sheet": answerSheet,
      "test_type": testType,
      "obtain_marks": obtainMarks,
      "total_marks": totalMarks
    };
    return ApiHandler.postApi(baseUrl: ApiProvider.baseUrl, endApi: EndApi.writtenTestSubmission, map: request).then((value) {
      print("SSSSSSSSSSSSSSS Response ${value.toString()}");

      TestsubmissionModel testsubmissionModel = TestsubmissionModel.fromJson(value);
    });
  }

  static Future<Map<String, dynamic>> updateProfile({Map<String, dynamic> request}) {
    return ApiHandler.postApi(baseUrl: ApiProvider.baseUrl, endApi: EndApi.editProfile, map: request).then((value) {
      print("SSSSSSSSSSSSSSS Response ${value.toString()}");

      return value;
    });
  }

  static Future<DownloadsModel> getDownloads() {
    Database.initDatabase();
    var request = {"category_id": Database.getSelectedCategoryId(), "subcategory_id": Database.getSubcategoryId()};

    return ApiHandler.postApi(baseUrl: ApiProvider.baseUrl, endApi: EndApi.downloads).then((value) {
      DownloadsModel downloadsModel = DownloadsModel.fromJson(value);
      return downloadsModel;
    });
  }
}
