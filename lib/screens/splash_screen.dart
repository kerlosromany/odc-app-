import 'package:flutter/material.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:instant_project/constants/shared_preferences.dart';
import 'package:instant_project/main.dart';

import '../Login/login_screen.dart';
import '../my_flutter_app_icons.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AnimatedSplashScreen(
        nextScreen: LoginAndRegisterScreen(),
        splash: Row(
          children: const [
            Text(
              "La",
              style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 36,
                  fontFamily: 'Meddon'),
            ),
            Icon(
              MyIcons.clover,
              color: Colors.greenAccent,
              size: 40,
            ),
            Text(
              "Via",
              style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 36,
                  fontFamily: 'Meddon'),
            ),
          ],
        ),
        splashTransition: SplashTransition.slideTransition,
        duration: 5000,
        function: saveInCacheHelper(),
      ),
    );
  }
}

saveInCacheHelper() {
  CacheHelper.saveData(key: "splash", value: true);
}
