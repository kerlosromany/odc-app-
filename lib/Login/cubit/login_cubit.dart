import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instant_project/Login/cubit/login_states.dart';
import 'package:instant_project/constants/dio_helper.dart';
import 'package:instant_project/constants/end_points.dart';

import '../../models/login_model.dart';

class LoginAndRegisterCubit extends Cubit<LoginAndRegisterStates> {
  LoginAndRegisterCubit() : super(LoginRegisterInitialState());

  static LoginAndRegisterCubit get(context) => BlocProvider.of(context);

  late LoginAndRegisterModel loginModel;
  void userDataLogin({
    required String email,
    required String password,
  }) {
    emit(LoginLoadingState());
    DioHelper.postData(
      url: LOGIN,
      data: {
        'email': email,
        'password': password,
      },
    ).then((value) {
      loginModel = LoginAndRegisterModel.fromJson(value.data);
      emit(LoginSuccessState(loginModel));
    }).catchError((error) {
      print(error.toString());
      emit(LoginErrorState(error.toString()));
    });
  }

  bool isPasword = true;
  IconData suffixIcon = Icons.visibility_outlined;

  void loginchangePasswordVisibility() {
    isPasword = !isPasword;
    suffixIcon =
        isPasword ? Icons.visibility_outlined : Icons.visibility_off_outlined;
    emit(LoginChangePasswordVisibility());
  }

  late LoginAndRegisterModel registerModel;
  void userDataRegister({
    required String email,
    required String password,
    required String firstName,
    required String lastName,
  }) {
    emit(RegisterLoadingState());
    DioHelper.postData(
      url: REGISTER,
      data: {
        'email': email,
        'password': password,
        "firstName": firstName,
        "lastName": lastName,
      },
    ).then((value) {
      registerModel = LoginAndRegisterModel.fromJson(value.data);
      emit(RegisterSuccessState(registerModel));
    }).catchError((error) {
      print(error.toString());
      emit(RegisterErrorState(error.toString()));
    });
  }

  bool isPaswordRegister = true;
  IconData suffixIconRegister = Icons.visibility_outlined;

  void registerchangePasswordVisibility() {
    isPasword = !isPasword;
    suffixIcon =
        isPasword ? Icons.visibility_outlined : Icons.visibility_off_outlined;
    emit(RegisterChangePasswordVisibility());
  }

  int signUpOrLogin = 0;
  void changeLoginAndRegister(index) {
    signUpOrLogin = index;
    emit(ChangeLoginAndRegisterState());
  }
}
