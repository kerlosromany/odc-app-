class LikeModel {
  String? type;
  String? message;
  Data? data;


  LikeModel.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  
}

class Data {
  String? forumId;
  String? userId;


  Data.fromJson(Map<String, dynamic> json) {
    forumId = json['forumId'];
    userId = json['userId'];
  }

 
}