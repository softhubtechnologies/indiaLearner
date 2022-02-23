class NotificationsListModel {
  String statusCode;
  String message;
  List<NotificationList> notificationList;

  NotificationsListModel({this.statusCode, this.message, this.notificationList});

  NotificationsListModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['status_code'];
    message = json['message'];
    if (json['notification_list'] != null) {
      notificationList = new List<NotificationList>();
      json['notification_list'].forEach((v) {
        notificationList.add(new NotificationList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status_code'] = this.statusCode;
    data['message'] = this.message;
    if (this.notificationList != null) {
      data['notification_list'] = this.notificationList.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class NotificationList {
  String courseId;
  String type;
  String notification;
  String date;

  NotificationList({this.courseId, this.type, this.notification, this.date});

  NotificationList.fromJson(Map<String, dynamic> json) {
    courseId = json['course_id'];
    type = json['type'];
    notification = json['notification'];
    date = json['date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['course_id'] = this.courseId;
    data['type'] = this.type;
    data['notification'] = this.notification;
    data['date'] = this.date;
    return data;
  }
}
