class CreatePostModel {
  String? title;
  String? description;
  String? imageBase64;


  CreatePostModel.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    description = json['description'];
    imageBase64 = json['imageBase64'];
  }

  
}