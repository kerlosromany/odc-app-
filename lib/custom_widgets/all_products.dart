import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:instant_project/models/carts_model.dart';
import 'package:instant_project/state_management/provider/provider.dart';
import 'package:provider/provider.dart';

import '../constants/components.dart';
import '../constants/database_helper.dart';
import '../models/products_model.dart';
import '../state_management/home_cubit/cubit.dart';
import '../state_management/home_cubit/states.dart';

class AllProducts extends StatelessWidget {
  DBHelper? dbHelper = DBHelper();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return ConditionalBuilder(
          condition: HomeCubit.get(context).productsModel != null,
          fallback: (context) =>
              const Center(child: CircularProgressIndicator()),
          builder: (context) => allPlantsSeedsTools(
              HomeCubit.get(context).productsModel as ProductsModel, context),
        );
      },
    );
  }

  Widget allPlantsSeedsTools(ProductsModel model, context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            color: Colors.white,
            child: GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              children: List.generate(model.data.length,
                  (index) => buildGridPlant(model.data[index], context, index)),
              mainAxisSpacing: 5.0,
              crossAxisSpacing: 5.0,
              childAspectRatio: 1 / 2,
            ),
          ),
        ],
      ),
    );
  }

  Widget buildGridPlant(Data model, context, index) {
    int indexpressed = index;

    var cart = Provider.of<CartProvider>(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          alignment: Alignment.bottomLeft,
          children: [
            Image(
              image: NetworkImage(
                  //"https://hips.hearstapps.com/vader-prod.s3.amazonaws.com/1655830667-screen-shot-2022-06-21-at-12-57-21-pm-1655830653.png?crop=1.00xw:0.752xh;0,0.220xh&resize=480:*"
                  "${model.imageUrl}",
                  ),
              fit: BoxFit.cover,
              width: double.infinity,
              height: 200,
            ),
            // Container(
            //   padding: const EdgeInsets.all(8.0),
            //   child: Row(
            //     children: [
            //       CircleAvatar(
            //           child: IconButton(
            //             onPressed: () {},
            //             icon: const Icon(Icons.add),
            //           ),
            //           backgroundColor: Colors.white),
            //       const SizedBox(
            //         width: 5.0,
            //       ),
            //       Text(
            //         "0",
            //         style: const TextStyle(fontWeight: FontWeight.bold),
            //       ),
            //       const SizedBox(
            //         width: 5.0,
            //       ),
            //       CircleAvatar(
            //           child: IconButton(
            //             onPressed: () {},
            //             icon: const Icon(Icons.remove),
            //           ),
            //           backgroundColor: Colors.white),
            //     ],
            //   ),
            // ),
          ],
        ),
        Text(
          "${model.name}",
          style: const TextStyle(
            fontSize: 15.0,
            fontWeight: FontWeight.bold,
          ),
          maxLines: 1,
        ),
        Text(
          "${model.price}",
          maxLines: 2,
        ),
        const SizedBox(
          width: 10.0,
        ),
        MyButton(
          text: "Add to Cart",
          onPressed: () {
            print(index);
            print(model.productId);
            print(model.name);
            print(model.price);
            
            dbHelper
                ?.insert(
              CartModel(
                id: index,
                productId: model.productId,
                productName: model.name,
                initialPrice: model.price,
                productPrice: model.price,
                quantity: 1,
                image: model.imageUrl,
              ),
            )
                .then((value) {
              print("Object is added to Database");
              cart.addTotalPrice(double.parse(model.price.toString()));
              cart.addCounter();
            }).catchError((error) {
              print(error.toString());
            });
          },
        ),
      ],
    );
  }
}
