import 'dart:io';

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instant_project/constants/components.dart';
import 'package:instant_project/screens/forums.dart';
import 'package:instant_project/state_management/posts_cubit/states.dart';

import '../state_management/posts_cubit/cubit.dart';

class CreatePostScreen extends StatelessWidget {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext ctx) {
    return BlocProvider(
      create: (context) => PostsCubit(),
      child: BlocConsumer<PostsCubit, PostsStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = PostsCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              title: const Text(
                "Create New Post",
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            body: Center(
              child: Padding(
                padding: const EdgeInsets.all(18.0),
                child: Form(
                  key: formKey,
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        InkWell(
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  content: Container(
                                    height: 100,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        InkWell(
                                          onTap: () {
                                            cubit
                                                .pickImage(ImageSource.gallery)
                                                .then((value) {
                                              cubit.isImageUploaded = true;
                                            });
                                          },
                                          child: Row(
                                            children: const [
                                              Icon(Icons.browse_gallery_sharp),
                                              SizedBox(
                                                width: 20.0,
                                              ),
                                              Text("Gallary"),
                                            ],
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 20.0,
                                        ),
                                        InkWell(
                                          onTap: () {
                                            cubit.pickImage(ImageSource.camera);
                                          },
                                          child: Row(
                                            children: const [
                                              Icon(Icons.camera),
                                              SizedBox(
                                                width: 20.0,
                                              ),
                                              Text("Camera"),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                          child: cubit.isImageUploaded
                              ? Container(
                                  width: 150,
                                  height: 150,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10.0),
                                    border: Border.all(
                                      color: Colors.green,
                                      width: 3.0,
                                    ),
                                  ),
                                  child: Center(
                                    child: Row(
                                      children: const [
                                        Icon(
                                          Icons.done,
                                          color: Colors.green,
                                        ),
                                        SizedBox(
                                          width: 10.0,
                                        ),
                                        Text(
                                          "Image is uploaded",
                                          style: TextStyle(
                                            color: Colors.green,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                )
                              : Container(
                                  width: 150,
                                  height: 150,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10.0),
                                    border: Border.all(
                                      color: Colors.green,
                                      width: 3.0,
                                    ),
                                  ),
                                  child: Center(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: const [
                                        Icon(Icons.add, color: Colors.green),
                                        SizedBox(
                                          height: 20.0,
                                        ),
                                        Text(
                                          "Add Photo",
                                          style: TextStyle(color: Colors.green),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                        ),
                        const SizedBox(
                          height: 20.0,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text("Title"),
                            const SizedBox(
                              height: 10.0,
                            ),
                            TextFormField(
                              controller: titleController,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  borderSide: const BorderSide(
                                    color: Colors.grey,
                                    width: 2.0,
                                  ),
                                ),
                              ),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Title must not be empty";
                                }
                                return null;
                              },
                              maxLines: 2,
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 15.0,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text("Description"),
                            const SizedBox(
                              height: 10.0,
                            ),
                            TextFormField(
                              controller: descriptionController,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  borderSide: BorderSide(
                                    color: Colors.grey,
                                    width: 2.0,
                                  ),
                                ),
                              ),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Description must not be empty";
                                }
                                return null;
                              },
                              maxLines: 6,
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 15.0,
                        ),
                        ConditionalBuilder(
                          condition: state is PostsLoadingState,
                          builder: (context) =>
                              const Center(child: CircularProgressIndicator()),
                          fallback: (context) => MyButton(
                              text: "Post",
                              onPressed: () {
                                if (formKey.currentState!.validate()) {
                                  cubit.createPost(
                                    title: titleController.text,
                                    description: descriptionController.text,
                                    imageBase64: cubit.img64,
                                    context: ctx,
                                  );
                                }
                                //Navigator.pop(context);
                              }),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
