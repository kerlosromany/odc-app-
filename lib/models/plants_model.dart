class PlantModel {
  String? type;
  String? message;
  List<DataPlantModel> data = [];

  PlantModel.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    message = json['message'];

    json['data'].forEach((element) {
      data.add(DataPlantModel.fromJson(element));
    });
  }
}

class DataPlantModel {
  String? plantId;
  String? name;
  String? description;
  String? imageUrl;
  int? waterCapacity;
  int? sunLight;
  int? temperature;

  DataPlantModel.fromJson(Map<String, dynamic> json) {
    plantId = json['plantId'];
    name = json['name'];
    description = json['description'];
    imageUrl = "${json['imageUrl']}";
    waterCapacity = json['waterCapacity'];
    sunLight = json['sunLight'];
    temperature = json['temperature'];
  }

}
