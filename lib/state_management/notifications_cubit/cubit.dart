import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instant_project/state_management/blogs_cubit/states.dart';
import 'package:instant_project/state_management/notifications_cubit/states.dart';

import '../../constants/components.dart';
import '../../constants/dio_helper.dart';
import '../../constants/end_points.dart';
import '../../models/blogs_model.dart';
import '../../models/notification_model.dart';

class NotificationCubit extends Cubit<NotificationStates> {
  NotificationCubit() : super(NotificationInitialState());

  static NotificationCubit get(context) => BlocProvider.of(context);

  NotificationModel? notificationModel;
  void getNotificationsData() {
    emit(NotificationLoadingState());
    DioHelper.getData(
      url: NOTIFICATIONS,
      token: "Bearer $token",
    ).then((value) {
      notificationModel = NotificationModel.fromJson(value.data);
      emit(NotificationSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(NotificationErrorState());
    });
  }
}
