class HelpSupportListResponseModel {
  String statusCode;
  String message;
  List<MessageList> messageList;

  HelpSupportListResponseModel({this.statusCode, this.message, this.messageList});

  HelpSupportListResponseModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['status_code'];
    message = json['message'];
    if (json['message_list'] != null) {
      messageList = new List<MessageList>();
      json['message_list'].forEach((v) {
        messageList.add(new MessageList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status_code'] = this.statusCode;
    data['message'] = this.message;
    if (this.messageList != null) {
      data['message_list'] = this.messageList.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class MessageList {
  String id;
  String userId;
  String firstName;
  String lastName;
  String message;
  String date;
  String time;
  List<ReplyList> replyList;

  MessageList({this.id, this.userId, this.firstName, this.lastName, this.message, this.date, this.time, this.replyList});

  MessageList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    message = json['message'];
    date = json['date'];
    time = json['time'];
    if (json['reply_list'] != null) {
      replyList = new List<ReplyList>();
      json['reply_list'].forEach((v) {
        replyList.add(new ReplyList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['message'] = this.message;
    data['date'] = this.date;
    data['time'] = this.time;
    if (this.replyList != null) {
      data['reply_list'] = this.replyList.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ReplyList {
  String id;
  String messageId;
  String reply;
  String date;
  String time;

  ReplyList({this.id, this.messageId, this.reply, this.date, this.time});

  ReplyList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    messageId = json['message_id'];
    reply = json['reply'];
    date = json['date'];
    time = json['time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['message_id'] = this.messageId;
    data['reply'] = this.reply;
    data['date'] = this.date;
    data['time'] = this.time;
    return data;
  }
}
