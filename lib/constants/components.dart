import 'package:flutter/material.dart';
import 'package:instant_project/constants/shared_preferences.dart';

import '../Login/login_screen.dart';
import '../main.dart';

Widget textButton({
  required String text,
  required VoidCallback? onPressed,
}) {
  return TextButton(
    child: Text(text),
    onPressed: onPressed,
  );
}

Widget textFormField({
  required String textForm,
  required TextEditingController textEditingController,
  IconData? prefixIcon,
  required TextInputType textInputType,
  bool isPassword = false,
  IconData? suffixIcon,
  VoidCallback? suffixPressed,
  required FormFieldValidator<String>? validate,
  required String textFormFieldKey,
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(textForm),
      const SizedBox(
        height: 15.0,
      ),
      TextFormField(
        key: Key(textFormFieldKey),
        controller: textEditingController,
        decoration: InputDecoration(
          border: const OutlineInputBorder(),
          prefixIcon: Icon(prefixIcon),
          suffixIcon:
              IconButton(icon: Icon(suffixIcon), onPressed: suffixPressed),
        ),
        validator: validate,
        keyboardType: textInputType,
        obscureText: isPassword,
      ),
    ],
  );
}

Widget MyButton({
  required String text,
  required VoidCallback? onPressed,
}) {
  return Container(
    width: double.infinity,
    height: 40.0,
    decoration: BoxDecoration(
      color: Colors.greenAccent,
      borderRadius: BorderRadius.circular(15.0),
    ),
    child: MaterialButton(
      child: Text(text),
      onPressed: onPressed,
    ),
  );
}

String? token = '';

Widget signOut(context) {
  return TextButton(
    child: Text(
      "Sign out",
      style: TextStyle(color: Colors.black),
    ),
    onPressed: () {
      CacheHelper.removeData(key: 'token').then((value) {
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (_) => LoginAndRegisterScreen()));
      });
    },
  );
}

void navigateAndFinish(context) {
  return Navigator.of(context).pop();
}
