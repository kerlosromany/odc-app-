class ToolsModel {
  String? type;
  String? message;
  List<DataToolModel> data = [];

  ToolsModel.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    message = json['message'];

    json['data'].forEach((element) {
      data.add(DataToolModel.fromJson(element));
    });
  }
}

class DataToolModel {
  String? toolId;
  String? name;
  String? description;
  String? imageUrl;

  DataToolModel.fromJson(Map<String, dynamic> json) {
    toolId = json['toolId'];
    name = json['name'];
    description = json['description'];
    imageUrl = "${json['imageUrl']}";
  }
}
