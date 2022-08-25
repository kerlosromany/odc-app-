class SeedsModel {
  String? type;
  String? message;
  List<DataSeedModel> data = [];


  SeedsModel.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    message = json['message'];
    
      json['data'].forEach((element) {
        data.add(DataSeedModel.fromJson(element));
      });
    
  }

  
}

class DataSeedModel {
  String? seedId;
  String? name;
  String? description;
  String? imageUrl;


  DataSeedModel.fromJson(Map<String, dynamic> json) {
    seedId = json['seedId'];
    name = json['name'];
    description = json['description'];
    imageUrl = "${json['imageUrl']}";
  }

 
}