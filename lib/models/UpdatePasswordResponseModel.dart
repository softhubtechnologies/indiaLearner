class UpdatePasswordResponseModel {
  String statusCode;
  Result result;

  UpdatePasswordResponseModel({this.statusCode, this.result});

  UpdatePasswordResponseModel.fromJson(Map<String, dynamic> json) {
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
  String email;
  String password;

  Result({this.id, this.email, this.password});

  Result.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    email = json['email'];
    password = json['password'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['email'] = this.email;
    data['password'] = this.password;
    return data;
  }
}
