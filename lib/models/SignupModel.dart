class SignupModel {
  String statusCode;
  Result result;

  SignupModel({this.statusCode, this.result});

  SignupModel.fromJson(Map<String, dynamic> json) {
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
  String userId;
  String firstName;
  String lastName;
  String mobileNumber;
  String email;
  String bio;

  Result({this.userId, this.firstName, this.lastName, this.mobileNumber, this.email, this.bio});

  Result.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    mobileNumber = json['mobile_number'];
    email = json['email'];
    bio = json['bio'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_id'] = this.userId;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['mobile_number'] = this.mobileNumber;
    data['email'] = this.email;
    data['bio'] = this.bio;
    return data;
  }
}
