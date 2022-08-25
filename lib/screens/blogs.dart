import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instant_project/state_management/blogs_cubit/cubit.dart';
import 'package:instant_project/state_management/blogs_cubit/states.dart';
import 'package:instant_project/state_management/home_cubit/cubit.dart';

import '../models/blogs_model.dart';

class BlogsScreen extends StatelessWidget {
  const BlogsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => BlogCubit()..getBlogsData(),
      child: BlocConsumer<BlogCubit, BlogStates>(
        listener: (context, state) {},
        builder: (context, state) {
          BlogCubit cubit = BlogCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              title: const Text(
                "Blogs",
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              centerTitle: true,
            ),
            body: ConditionalBuilder(
              condition: cubit.blogModel != null,
              fallback: (context) =>
                  const Center(child: CircularProgressIndicator()),
              builder: (context) => buildblogPlant(
                cubit.blogModel as BlogsModel,
              ),
            ),
          );
        },
      ),
    );
  }

  Widget buildblogPlant(BlogsModel model) {
    
    return SingleChildScrollView(
      child: Column(
        children: [
          buildListViews(model.data!.plants , model.data!.seeds , model.data!.tools)
        ],
      ),
    );
  }

  Widget buildListViews(List<Plants> model1, List<Seeds> model2, List<Tools> model3) {
    return SingleChildScrollView(
      child: Column(
        children: [
          ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: model1.length,
            itemBuilder: (context , index) => buildCard(model1[index]),
          ),
          ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: model2.length,
            itemBuilder: (context , index) => buildCard(model2[index]),
          ),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: model3.length,
            itemBuilder: (context , index) => buildCard(model3[index]),
          ),
        ],
      ),
    );
  }

  Card buildCard(model) {
    return Card(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Image(
            image: NetworkImage("${model.imageUrl}"),
            width: 100,
            height: 100,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("${model.name}"),
                Text("${model.description}" , overflow: TextOverflow.fade , softWrap: true , textAlign: TextAlign.justify,maxLines: 2,),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
