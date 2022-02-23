class HelpAndSupportSendResponse {
  String statusCode;
  Result result;

  HelpAndSupportSendResponse({this.statusCode, this.result});

  HelpAndSupportSendResponse.fromJson(Map<String, dynamic> json) {
    statusCode = json['Status_code'];
    result = json['result'] != null ? new Result.fromJson(json['result']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Status_code'] = this.statusCode;
    if (this.result != null) {
      data['result'] = this.result.toJson();
    }
    return data;
  }
}

class Result {
  String id;
  String userId;
  String message;
  String time;
  String date;

  Result({this.id, this.userId, this.message, this.time, this.date});

  Result.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    message = json['message'];
    time = json['time'];
    date = json['date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['message'] = this.message;
    data['time'] = this.time;
    data['date'] = this.date;
    return data;
  }
}
