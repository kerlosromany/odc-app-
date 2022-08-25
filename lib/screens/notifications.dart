import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instant_project/state_management/notifications_cubit/states.dart';

import '../models/notification_model.dart';
import '../state_management/notifications_cubit/cubit.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NotificationCubit()..getNotificationsData(),
      child: BlocConsumer<NotificationCubit , NotificationStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = NotificationCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              title: const Text("Notifications"),
            ),
            body: ConditionalBuilder(
              condition: cubit.notificationModel != null,
              fallback: (context) =>
                  const Center(child: CircularProgressIndicator()),
              builder: (context) => buildNotification(
                  cubit.notificationModel as NotificationModel),
            ),
          );
        },
      ),
    );
  }

  Widget buildNotification(NotificationModel model) {
    return SingleChildScrollView(
      child: Column(
        children: List.generate(
          model.data!.userNotification.length,
          (index) {
            return buildListTile(model, model.data!.userNotification[index]);
          },
        ),
      ),
    );
  }

  Widget buildListTile(NotificationModel model1, UserNotification model2) {
    return Column(
      children: [
        ListTile(
          leading: CircleAvatar(
            backgroundImage: NetworkImage("${model1.data!.imageUrl}"),
          ),
          title: Text("${model1.data!.firstName} ${model1.data!.lastName}"),
          subtitle: Text("${model2.createdAt}"),
        ),
      ],
    );
  }
}
