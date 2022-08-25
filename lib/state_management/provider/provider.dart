import 'package:flutter/cupertino.dart';
import 'package:instant_project/models/carts_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../constants/database_helper.dart';

class CartProvider with ChangeNotifier {
  DBHelper db = DBHelper();

  int counter = 0;
  double totalPrice = 0.0;

  late Future<List<CartModel>> cartList;
  Future<List<CartModel>> getData() async {
    cartList = db.getCartList();
    return cartList;
  }

  void setSharedPref() async {
    SharedPreferences Prefs = await SharedPreferences.getInstance();
    Prefs.setInt("cart_item", counter);
    Prefs.setDouble("total_price", totalPrice);
    notifyListeners();
  }

  void getSharedPref() async {
    SharedPreferences Prefs = await SharedPreferences.getInstance();
    counter = Prefs.getInt("cart_item") ?? 0;
    totalPrice = Prefs.getDouble("total_price") ?? 0.0;
    notifyListeners();
  }

  void clearSharedPref() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove("cart_item");
    prefs.remove("total_price");
    notifyListeners();
  }

  void addTotalPrice(double productPrice) {
    totalPrice += productPrice;
    setSharedPref();
    notifyListeners();
  }

  void removeTotalPrice(double productPrice) {
    totalPrice -= productPrice;
    setSharedPref();
    notifyListeners();
  }

  double getTotalPrice() {
    getSharedPref();
    return totalPrice;
  }

  void addCounter() {
    counter++;
    setSharedPref();
    notifyListeners();
  }

  void removeCounter() {
    if (counter != 0) {
      counter--;
    }
    setSharedPref();
    notifyListeners();
  }

  int getCounter() {
    getSharedPref();
    return counter;
  }

  // List<dynamic> cartList = [];
  // getData() async {
  //   cartList = db.getCartList();
  //   return cartList;
  // }

  bool flag = false;
}
