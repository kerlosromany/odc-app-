import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instant_project/constants/shared_preferences.dart';
import 'package:instant_project/screens/create_post.dart';
import 'package:instant_project/screens/forums.dart';

import 'package:instant_project/screens/home.dart';
import 'package:instant_project/screens/splash_screen.dart';
import 'package:instant_project/state_management/home_cubit/cubit.dart';
import 'package:instant_project/state_management/home_cubit/states.dart';
import 'package:instant_project/state_management/provider/provider.dart';
import 'package:provider/provider.dart';

import 'Login/login_screen.dart';
import 'constants/bloc_observer.dart';
import 'constants/components.dart';
import 'constants/dio_helper.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  
  // ignore: deprecated_member_use
  BlocOverrides.runZoned(
    () async {
      DioHelper.init();
      await CacheHelper.init();

      bool? splash = CacheHelper.getData(key: "splash");
      token = CacheHelper.getData(key: "token");
      print(token);
      late Widget widget;
      if (splash != null) {
        if (token != null) {
          widget = Home();
        } else {
          widget = LoginAndRegisterScreen();
        }
      } else {
        widget = const SplashScreen();
      }

      runApp(MyApp(widget));
    },
    blocObserver: MyBlocObserver(),
  );
}

class MyApp extends StatelessWidget {
  late final Widget widget;
  MyApp(this.widget);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => HomeCubit()
            ..getProductsData()
            ..getHomePlantsData()
            ..getHomeToolsData()
            ..getHomeSeedsData()
            ,
        ),
      ],
      child: BlocConsumer<HomeCubit, HomeStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return ChangeNotifierProvider(
            create: (_) => CartProvider(),
            child: Builder(
              builder: (context) => MaterialApp(
                debugShowCheckedModeBanner: false,
                title: 'instant',
                theme: ThemeData(
                  primarySwatch: Colors.green,
                ),
                home: widget,
              ),
            ),
          );
        },
      ),
    );
  }
}
