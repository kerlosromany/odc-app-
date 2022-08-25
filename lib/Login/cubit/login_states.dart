import 'package:instant_project/models/login_model.dart';

abstract class LoginAndRegisterStates {}

class LoginRegisterInitialState extends LoginAndRegisterStates {}

class LoginLoadingState extends LoginAndRegisterStates {}

class LoginSuccessState extends LoginAndRegisterStates {
  final LoginAndRegisterModel loginModel;

  LoginSuccessState(this.loginModel);
}

class LoginErrorState extends LoginAndRegisterStates {
  final String error;

  LoginErrorState(this.error);
}

class LoginChangePasswordVisibility extends LoginAndRegisterStates {}


class RegisterLoadingState extends LoginAndRegisterStates {}

class RegisterSuccessState extends LoginAndRegisterStates {
  final LoginAndRegisterModel registerModel;

  RegisterSuccessState(this.registerModel);
}

class RegisterErrorState extends LoginAndRegisterStates {
  final String error;

  RegisterErrorState(this.error);
}

class RegisterChangePasswordVisibility extends LoginAndRegisterStates {}

class ChangeLoginAndRegisterState extends LoginAndRegisterStates {}

