import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instant_project/state_management/home_cubit/cubit.dart';
import 'package:instant_project/state_management/home_cubit/states.dart';

import '../models/plants_model.dart';
import '../models/products_model.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = HomeCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: const Text("Search"),
          ),
          body: ConditionalBuilder(
            condition: cubit.productsModel?.data.length != null,
            fallback: (context) =>
                const Center(child: CircularProgressIndicator()),
            builder: (context) => SingleChildScrollView(
              child: Column(
                children: [
                  GridView.count(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisCount: 4,
                    crossAxisSpacing: 1,
                    mainAxisSpacing: 1,
                    children: List.generate(
                      cubit.productsModel!.data.length,
                      (index) => buildGridProduct(
                        cubit.productsModel!.data[index],
                        cubit.productsModel!.data[index].productId as String,
                        cubit,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  
                    
                    ConditionalBuilder(
                      condition: cubit.searchModel != null,
                      fallback: (context) => const Center(child: Text("No Data Searched" , style: TextStyle(fontWeight: FontWeight.bold),)),
                      builder: (context) => Card(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Image(
                              image: NetworkImage(
                                  "${cubit.searchModel!.data!.imageUrl}"),
                              width: 100,
                              height: 100,
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("${cubit.searchModel!.data!.name}"),
                                  Text(
                                    "${cubit.searchModel!.data!.description}",
                                    overflow: TextOverflow.fade,
                                    softWrap: true,
                                    textAlign: TextAlign.justify,
                                    maxLines: 2,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  InkWell buildGridProduct(Data model, String productId, HomeCubit cubit) =>
      InkWell(
        onTap: () {
          cubit.getSearchData(productId);
          print(productId);
        },
        child: Container(
          height: 7,
          width: 7,
          decoration: BoxDecoration(
            color: Colors.grey.withOpacity(0.5),
            borderRadius: BorderRadius.circular(15.0),
          ),
          child: Center(
            child: Text("${model.name}"),
          ),
        ),
      );
}
