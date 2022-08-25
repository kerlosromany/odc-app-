import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instant_project/constants/dio_helper.dart';
import 'package:instant_project/constants/end_points.dart';
import 'package:instant_project/state_management/forums_cubit/cubit.dart';
import 'package:instant_project/state_management/posts_cubit/states.dart';

import '../../constants/components.dart';

class PostsCubit extends Cubit<PostsStates> {
  PostsCubit() : super(PostsInitialState());

  static PostsCubit get(context) => BlocProvider.of(context);

  File? image;
  String img64 = "";
  bool isImageUploaded = false;
  Future pickImage(ImageSource src) async {
    try {
      final image = await ImagePicker().pickImage(source: src);
      if (image == null) {
        return;
      }
      final File imageTemporary = File(image.path);
      this.image = imageTemporary;
      Uint8List bytes = await imageTemporary.readAsBytes();

      img64 = base64.encode(bytes);
      img64 = "data:image/jpeg;base64,$img64";

      print(img64);
      emit(PostsImageSuccessState());
    } on PlatformException catch (e) {
      print("Can not catch image");
      emit(PostsImageErrorState());
    }
  }

  void createPost({
    required String title,
    required String description,
    required String imageBase64,
    required context,
  }) {
    emit(PostsLoadingState());
    DioHelper.postData(
      url: "/api/v1/forums",
      data: {
        "title": title,
        "description": description,
        "imageBase64": imageBase64,
      },
      token: "Bearer $token",
    ).then((value) {
      navigateAndFinish(context);
      emit(PostsSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(PostsErrorState());
    });
  }
}
