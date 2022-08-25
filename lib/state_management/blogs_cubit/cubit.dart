import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instant_project/state_management/blogs_cubit/states.dart';

import '../../constants/components.dart';
import '../../constants/dio_helper.dart';
import '../../constants/end_points.dart';
import '../../models/blogs_model.dart';

class BlogCubit extends Cubit<BlogStates> {
  BlogCubit() : super(BlogInitialState());

  static BlogCubit get(context) => BlocProvider.of(context);

  
  BlogsModel? blogModel;
  void getBlogsData() {
    emit(BlogLoadingState());
    DioHelper.getData(
      url: BLOGS,
      token: "Bearer $token",
    ).then((value) {
      blogModel = BlogsModel.fromJson(value.data);
      emit(BlogSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(BlogErrorState());
    });
  }

}
