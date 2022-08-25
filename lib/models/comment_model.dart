class CommentModel {
  String? type;
  String? message;
  Data? data;


  CommentModel.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

 
}

class Data {
  String? forumCommentId;
  String? forumId;
  String? userId;
  String? comment;
  String? createdAt;



  Data.fromJson(Map<String, dynamic> json) {
    forumCommentId = json['forumCommentId'];
    forumId = json['forumId'];
    userId = json['userId'];
    comment = json['comment'];
    createdAt = json['createdAt'];
  }

  
}