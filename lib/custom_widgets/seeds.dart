import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instant_project/models/seeds_model.dart';
import 'package:instant_project/models/tools_model.dart';
import 'package:instant_project/state_management/home_cubit/cubit.dart';


import '../constants/components.dart';
import '../models/plants_model.dart';
import '../state_management/home_cubit/states.dart';

class Seeds extends StatelessWidget {
  const Seeds({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return ConditionalBuilder(
          condition: HomeCubit.get(context).seedsModel != null,
          fallback: (context) =>
              const Center(child: CircularProgressIndicator()),
          builder: (context) =>
              buildSeeds(HomeCubit.get(context).seedsModel as SeedsModel , context),
        );
      },
    );
  }

  Widget buildSeeds(SeedsModel model , context) {
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
                  (index) => buildGridSeed(model.data[index] , context)),
              mainAxisSpacing: 5.0,
              crossAxisSpacing: 5.0,
              childAspectRatio: 1 / 1.5,
            ),
          ),
        ],
      ),
    );
  }

  Widget buildGridSeed(DataSeedModel model , context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          alignment: Alignment.bottomLeft,
          children: [
             model.imageUrl == ""
                ? const Image(
                    image: NetworkImage(
                        "https://i0.wp.com/daisyflowereg.com/wp-content/uploads/2022/06/f02-min.jpg?fit=1200%2C1200&ssl=1"),
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: 200,
                  )
                : Image(
                    image: NetworkImage(
                        "https://lavie.orangedigitalcenteregypt.com${model.imageUrl}"),
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: 200,
                  ),
            // Container(
            //   padding: const EdgeInsets.all(8.0),
            //   child: Row(
            //     children: [
            //       IconButton(onPressed: () => HomeCubit.get(context).incrementCounter(), icon: const Icon(Icons.add),),
            //       const SizedBox(width: 5.0,),
            //       Text("${HomeCubit.get(context).counter}" , style: const TextStyle(fontWeight: FontWeight.bold),),
            //       const SizedBox(width: 5.0,),
            //       IconButton(onPressed: () => HomeCubit.get(context).decrementCounter(), icon: const Icon(Icons.remove),),
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
          "${model.description}",
          maxLines: 2,
        ),
        //const SizedBox(height: 10.0,),
        //MyButton(text: "Add to Cart" , onPressed: (){},),

      ],
    );
  }
}
