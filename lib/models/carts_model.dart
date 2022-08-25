class CartModel {
  late final int? id;
  String? productId;
  String? productName;
  int? initialPrice;
  int? productPrice;
  int? quantity;
  String? image;

  CartModel({
    required this.id,
    required this.productId,
    required this.productName,
    required this.initialPrice,
    required this.productPrice,
    required this.quantity,
    required this.image,
  });

  CartModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    productId = json['productId'];
    productName = json['productName'];
    initialPrice = json['initialPrice'];
    productPrice = json['productPrice'];
    quantity = json['quantity'];
    image = json['image'];
  }

  Map<String, dynamic> productToMap() {
    return {
      'id': id,
      'productId': productId,
      'productName': productName,
      'initialPrice': initialPrice,
      'productPrice': productPrice,
      'quantity': quantity,
      'image': image,
    };
  }
}
