import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instant_project/constants/components.dart';
import 'package:instant_project/screens/create_post.dart';
import 'package:instant_project/state_management/forums_cubit/states.dart';

import '../models/forums_model.dart';
import '../state_management/forums_cubit/cubit.dart';

class ForumsScreen extends StatelessWidget {
  TextEditingController commentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ForumsCubit()
        ..getForumsData()
        ..getMyForumsData(),
      child: BlocConsumer<ForumsCubit, ForumsStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = ForumsCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              title: const Text(
                "Discussion Forums",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
            body: ConditionalBuilder(
              condition: cubit.forumsModel != null,
              fallback: (context) =>
                  const Center(child: CircularProgressIndicator()),
              builder: (context) => SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    children: [
                      Container(
                        height: 60,
                        decoration: BoxDecoration(
                          color: Colors.grey.withOpacity(0.5),
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        child: TextField(
                          onChanged: (value) {
                            // search value
                          },
                          decoration: const InputDecoration(
                            prefixIcon: Icon(Icons.search),
                            hintText: "Search",
                            enabledBorder: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            contentPadding: EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 10,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 15.0,
                      ),
                      Row(
                        children: [
                          InkWell(
                            onTap: () {
                              cubit.checkKindOfForums(0);
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: cubit.kindOfForumsChecked == 0
                                    ? Colors.green
                                    : Colors.white,
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              child: Text(
                                "All Forums",
                                style: TextStyle(
                                  color: cubit.kindOfForumsChecked == 0
                                      ? Colors.white
                                      : Colors.grey,
                                ),
                              ),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 30.0, vertical: 10.0),
                            ),
                          ),
                          const SizedBox(
                            width: 10.0,
                          ),
                          InkWell(
                            onTap: () {
                              cubit.checkKindOfForums(1);
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: cubit.kindOfForumsChecked == 1
                                    ? Colors.green
                                    : Colors.white,
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              child: Text(
                                "My forums",
                                style: TextStyle(
                                  color: cubit.kindOfForumsChecked == 1
                                      ? Colors.white
                                      : Colors.grey,
                                ),
                              ),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 30.0, vertical: 10.0),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 15.0,
                      ),
                      if (cubit.kindOfForumsChecked == 0)
                        buildForums(cubit.forumsModel as ForumsModel, cubit,
                            state, context),
                      if (cubit.kindOfForumsChecked == 1)
                        buildForums(cubit.myForumsModel as ForumsModel, cubit,
                            state, context),
                    ],
                  ),
                ),
              ),
            ),
            floatingActionButton: FloatingActionButton(
              child: const Icon(Icons.add),
              onPressed: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (_) => CreatePostScreen()));
              },
            ),
          );
        },
      ),
    );
  }

  Expanded buildForums(ForumsModel model, ForumsCubit cubit, state, context) {
    return Expanded(
      child: ListView.builder(
        itemCount: model.data.length,
        itemBuilder: (context, index) {
          return SizedBox(
            height: 350,
            child: Column(
              children: [
                ListTile(
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(model
                            .data[index].user!.imageUrl ??
                        "https://encrypted-tbn3.gstatic.com/shopping?q=tbn:ANd9GcQCvhg8p844AmNnFfmosTo5dpl1jk1BW-z7J2t8l623Mjg1dnTTNBLayrw1dtx78WbtXO3RRVZ0Bg&usqp=CAc"),
                  ),
                  title: Text(
                    "${model.data[index].user!.firstName}  ${model.data[index].user!.lastName}",
                    maxLines: 1,
                  ),
                  subtitle: Text("${model.data[index].title}"),
                ),
                model.data[index].imageUrl == null?
                const Expanded(
                  child: Image(
                    image: NetworkImage("https://i0.wp.com/daisyflowereg.com/wp-content/uploads/2022/06/f02-min.jpg?fit=1200%2C1200&ssl=1"),
                    fit: BoxFit.cover,
                  ),
                )
                :Expanded(
                  child: Image(
                    image: NetworkImage("${model.data[index].imageUrl}"),
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(
                  height: 15.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Row(
                      children: [
                        IconButton(
                          //key: Key("${model.data[index].forumId}"),
                          icon: const Icon(
                            Icons.thumb_up,
                            color: Colors.grey,
                          ),
                          onPressed: () {
                            print(model.data[index].forumId);
                            cubit.createLike(
                                forumId: model.data[index].forumId as String);
                          },
                        ),
                        const SizedBox(
                          width: 2.0,
                        ),
                        Text("${model.data[index].forumLikes.length}"),
                        const SizedBox(
                          width: 2.0,
                        ),
                        const Text(
                          "Likes",
                          style: TextStyle(color: Colors.grey),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Text("${model.data[index].forumComments.length}"),
                        const SizedBox(
                          width: 2.0,
                        ),
                        TextButton(
                          child: const Text(
                            "Replies",
                            style: TextStyle(
                              color: Colors.grey,
                            ),
                          ),
                          onPressed: () {
                            showModalBottomSheet(
                                context: context,
                                builder: (_) {
                                  return ListView(
                                    shrinkWrap: true,
                                    children: [
                                      TextFormField(
                                        controller: commentController,
                                        keyboardType: TextInputType.text,
                                        decoration: InputDecoration(
                                          border: const OutlineInputBorder(),
                                          prefixIcon: IconButton(
                                            icon: const Icon(Icons.send),
                                            onPressed: () {
                                              cubit.createComment(
                                                comment: commentController.text,
                                                forumId: model.data[index]
                                                    .forumId as String,
                                              );
                                            },
                                          ),
                                        ),
                                      ),
                                      Column(
                                        children: List.generate(
                                            model.data[index].forumComments
                                                .length, (_) {
                                          return Padding(
                                            padding: const EdgeInsets.all(10.0),
                                            child: SingleChildScrollView(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                      "${model.data[index].forumComments[index].comment}"),
                                                  const SizedBox(
                                                    height: 3.0,
                                                  ),
                                                  Text(
                                                      "Created at  ${model.data[index].forumComments[index].createdAt}"),
                                                  const SizedBox(
                                                    height: 3.0,
                                                  ),
                                                  const Divider(
                                                    color: Colors.grey,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          );
                                        }),
                                      ),
                                    ],
                                  );
                                });
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
