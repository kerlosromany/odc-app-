import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instant_project/state_management/forums_cubit/states.dart';

import '../../constants/components.dart';
import '../../constants/dio_helper.dart';
import '../../constants/end_points.dart';
import '../../models/comment_model.dart';
import '../../models/forums_model.dart';
import '../../models/like_model.dart';

class ForumsCubit extends Cubit<ForumsStates> {
  ForumsCubit() : super(ForumsInitialState());

  static ForumsCubit get(context) => BlocProvider.of(context);

  ForumsModel? forumsModel;
  void getForumsData() {
    emit(ForumsLoadingState());
    DioHelper.getData(
      url: FORUMS,
      //url: '/api/v1/forums/me',
      token: "Bearer $token",
    ).then((value) {
      forumsModel = ForumsModel.fromJson(value.data);
      emit(ForumsSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(ForumsErrorState());
    });
  }

  ForumsModel? myForumsModel;
  void getMyForumsData() {
    emit(MyForumsLoadingState());
    DioHelper.getData(
      url: MYFORUMS,
      //url: '/api/v1/forums/me',
      token: "Bearer $token",
    ).then((value) {
      myForumsModel = ForumsModel.fromJson(value.data);
      emit(MyForumsSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(MyForumsErrorState());
    });
  }

  int kindOfForumsChecked = 0;
  void checkKindOfForums(int index) {
    kindOfForumsChecked = index;
    emit(CheckKindOfForumsState());
  }

  CommentModel? commentModel;
  void createComment({
    required String comment,
    required String forumId,
  }) {
    emit(CommentLoadingState());
    DioHelper.postData(
      url: "/api/v1/forums/$forumId/comment",
      data: {
        "comment" : comment,
      },
      token: "Bearer $token",
    ).then((value) {
      commentModel = CommentModel.fromJson(value.data);
      getForumsData();
      emit(CommentSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(CommentErrorState());
    });
  }

  LikeModel? likeModel;
  void createLike({
    required String forumId,
  }) {
    emit(LikeLoadingState());
    DioHelper.postData(
      url: "/api/v1/forums/$forumId/like",
      data: {},
      token: "Bearer $token",
    ).then((value) {
      likeModel = LikeModel.fromJson(value.data);
      getForumsData();
      emit(LikeSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(LikeErrorState());
    });
  }

  bool isLiked = false;
  void changeLikeMode() {
    isLiked = !isLiked;
    emit(ChangeLikeMode());
  }
}
