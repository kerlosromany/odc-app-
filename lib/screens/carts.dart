import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instant_project/state_management/provider/provider.dart';
import 'package:provider/provider.dart';

import '../constants/database_helper.dart';
import '../models/carts_model.dart';
import '../state_management/home_cubit/cubit.dart';
import '../state_management/home_cubit/states.dart';

class CartsScreen extends StatelessWidget {
  DBHelper? dbHelper = DBHelper();

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "My Carts",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          children: [
            FutureBuilder(
              future: cart.getData(),
              builder: (context, AsyncSnapshot<List<CartModel>> snapshot) {
                if (snapshot.hasData) {
                  if (snapshot.data!.isEmpty) {
                    return Center(
                      child: Text("No carts"),
                    );
                  } else {
                    return Expanded(
                      child: ListView.builder(
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          return Card(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Image(
                                  image: NetworkImage(
                                      snapshot.data![index].image.toString()
                                      // "https://hips.hearstapps.com/vader-prod.s3.amazonaws.com/1655830667-screen-shot-2022-06-21-at-12-57-21-pm-1655830653.png?crop=1.00xw:0.752xh;0,0.220xh&resize=480:*",
                                      ),
                                  width: 100,
                                  height: 100,
                                ),
                                Column(
                                  children: [
                                    Text(snapshot.data![index].productName
                                        .toString()),
                                    Text(snapshot.data![index].productPrice
                                        .toString()),
                                    Container(
                                      decoration: BoxDecoration(
                                        color: Colors.grey,
                                        borderRadius:
                                            BorderRadius.circular(15.0),
                                      ),
                                      child: Row(
                                        children: [
                                          IconButton(
                                            onPressed: () {
                                              int quantity = snapshot
                                                  .data![index].quantity!;
                                              int price = snapshot
                                                  .data![index].initialPrice!;
                                              quantity++;
                                              int? newPrice = price * quantity;
                                              dbHelper!
                                                  .updateQuantity(
                                                CartModel(
                                                  id: snapshot.data![index].id,
                                                  productId: snapshot
                                                      .data![index].productId,
                                                  productName: snapshot
                                                      .data![index].productName,
                                                  initialPrice: snapshot
                                                      .data![index]
                                                      .initialPrice,
                                                  productPrice: newPrice,
                                                  quantity: quantity,
                                                  image:
                                                      "https://hips.hearstapps.com/vader-prod.s3.amazonaws.com/1655830667-screen-shot-2022-06-21-at-12-57-21-pm-1655830653.png?crop=1.00xw:0.752xh;0,0.220xh&resize=480:*",
                                                ),
                                              )
                                                  .then((value) {
                                                newPrice = 0;
                                                quantity = 0;
                                                cart.addTotalPrice(double.parse(
                                                    snapshot.data![index]
                                                        .initialPrice
                                                        .toString()));
                                              }).catchError((error) {
                                                print(error.toString());
                                              });
                                            },
                                            icon: const Icon(Icons.add),
                                          ),
                                          const SizedBox(
                                            width: 5.0,
                                          ),
                                          Text(
                                            snapshot.data![index].quantity
                                                .toString(),
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                          const SizedBox(
                                            width: 5.0,
                                          ),
                                          IconButton(
                                            onPressed: () {
                                              int quantity = snapshot
                                                  .data![index].quantity!;
                                              int price = snapshot
                                                  .data![index].initialPrice!;
                                              quantity--;
                                              int? newPrice = price * quantity;
                                              if (quantity > 0) {
                                                dbHelper!
                                                    .updateQuantity(
                                                  CartModel(
                                                    id: snapshot
                                                        .data![index].id,
                                                    productId: snapshot
                                                        .data![index].productId,
                                                    productName: snapshot
                                                        .data![index]
                                                        .productName,
                                                    initialPrice: snapshot
                                                        .data![index]
                                                        .initialPrice,
                                                    productPrice: newPrice,
                                                    quantity: quantity,
                                                    image:
                                                        "https://hips.hearstapps.com/vader-prod.s3.amazonaws.com/1655830667-screen-shot-2022-06-21-at-12-57-21-pm-1655830653.png?crop=1.00xw:0.752xh;0,0.220xh&resize=480:*",
                                                  ),
                                                )
                                                    .then((value) {
                                                  newPrice = 0;
                                                  quantity = 0;
                                                  cart.removeTotalPrice(
                                                      double.parse(snapshot
                                                          .data![index]
                                                          .initialPrice
                                                          .toString()));
                                                }).catchError((error) {
                                                  print(error.toString());
                                                });
                                              }
                                            },
                                            icon: const Icon(Icons.remove),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                IconButton(
                                  icon: const Icon(Icons.delete),
                                  onPressed: () {
                                    dbHelper!.delete(snapshot.data![index].id!);
                                    cart.removeCounter();
                                    cart.removeTotalPrice(double.parse(snapshot
                                        .data![index].productPrice
                                        .toString()));
                                  },
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    );
                  }
                } else {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            ),
            Consumer<CartProvider>(
              builder: (context, value, child) {
                return Visibility(
                  visible:
                      value.getTotalPrice().toString() == "0.0" ? false : true,
                  child: Column(
                    children: [
                      ReusableWidget(
                        title: "Total",
                        value: value.getTotalPrice().toString(),
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class ReusableWidget extends StatelessWidget {
  final String title;
  final String value;

  ReusableWidget({required this.title, required this.value});
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          value.toString(),
          style: const TextStyle(
            color: Colors.black,
            fontSize: 20,
          ),
        )
      ],
    );
  }
}
