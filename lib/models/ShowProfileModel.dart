/// Status_code : "200"
/// message : "Success"
/// result : [{"id":"4","first_name":"Vaibhav","last_name":"Mali","mobile_number":"9850179195","email":"v@gmail.com","bio":"new Bio","profile_image":"https://indialearner.in/admin/uploads/images/61e542fa97f74.jpg"}]

class ShowProfileModel {
  ShowProfileModel({
    String statusCode,
    String message,
    List<Result> result,
  }) {
    _statusCode = statusCode;
    _message = message;
    _result = result;
  }

  ShowProfileModel.fromJson(dynamic json) {
    _statusCode = json['Status_code'];
    _message = json['message'];
    if (json['result'] != null) {
      _result = [];
      json['result'].forEach((v) {
        _result.add(Result.fromJson(v));
      });
    }
  }
  String _statusCode;
  String _message;
  List<Result> _result;

  String get statusCode => _statusCode;
  String get message => _message;
  List<Result> get result => _result;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['Status_code'] = _statusCode;
    map['message'] = _message;
    if (_result != null) {
      map['result'] = _result.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

/// id : "4"
/// first_name : "Vaibhav"
/// last_name : "Mali"
/// mobile_number : "9850179195"
/// email : "v@gmail.com"
/// bio : "new Bio"
/// profile_image : "https://indialearner.in/admin/uploads/images/61e542fa97f74.jpg"

class Result {
  Result({
    String id,
    String firstName,
    String lastName,
    String mobileNumber,
    String email,
    String bio,
    String profileImage,
  }) {
    _id = id;
    _firstName = firstName;
    _lastName = lastName;
    _mobileNumber = mobileNumber;
    _email = email;
    _bio = bio;
    _profileImage = profileImage;
  }

  Result.fromJson(dynamic json) {
    _id = json['id'];
    _firstName = json['first_name'];
    _lastName = json['last_name'];
    _mobileNumber = json['mobile_number'];
    _email = json['email'];
    _bio = json['bio'];
    _profileImage = json['profile_image'];
  }
  String _id;
  String _firstName;
  String _lastName;
  String _mobileNumber;
  String _email;
  String _bio;
  String _profileImage;

  String get id => _id;
  String get firstName => _firstName;
  String get lastName => _lastName;
  String get mobileNumber => _mobileNumber;
  String get email => _email;
  String get bio => _bio;
  String get profileImage => _profileImage;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['first_name'] = _firstName;
    map['last_name'] = _lastName;
    map['mobile_number'] = _mobileNumber;
    map['email'] = _email;
    map['bio'] = _bio;
    map['profile_image'] = _profileImage;
    return map;
  }
}
