import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instant_project/Login/cubit/login_cubit.dart';
import 'package:instant_project/Login/cubit/login_states.dart';
import 'package:instant_project/constants/components.dart';
import 'package:instant_project/constants/shared_preferences.dart';
import 'package:instant_project/main.dart';

import '../my_flutter_app_icons.dart';
import '../screens/home.dart';

class LoginAndRegisterScreen extends StatelessWidget {
  GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();
  GlobalKey<FormState> registerFormKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginAndRegisterCubit(),
      child: BlocConsumer<LoginAndRegisterCubit, LoginAndRegisterStates>(
        listener: (context, state) {
          if (state is LoginSuccessState) {
            if (state.loginModel.type == "Success") {
              CacheHelper.saveData(
                      key: "token", value: state.loginModel.data!.accessToken)
                  .then((value) {
                Navigator.of(context)
                    .pushReplacement(MaterialPageRoute(builder: (_) => Home()));
              });
            }
          }
          if (state is RegisterSuccessState) {
            if (state.registerModel.type == "Success") {
              CacheHelper.saveData(
                      key: "token",
                      value: state.registerModel.data!.accessToken)
                  .then((value) {
                Navigator.of(context)
                    .pushReplacement(MaterialPageRoute(builder: (_) => Home()));
              });
            }
          }
        },
        builder: (context, state) {
          var cubit = LoginAndRegisterCubit.get(context);
          return Scaffold(
            backgroundColor: Colors.white,
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Column(
                  children: [
                    Image.asset("assets/images/login1.png"),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        textButton(
                          text: "Sign Up",
                          onPressed: ()=> cubit.changeLoginAndRegister(0),
                        ),
                        const SizedBox(
                          width: 60.0,
                        ),
                        textButton(
                          text: "Login",
                          onPressed: ()=> cubit.changeLoginAndRegister(1),
                        ),
                      ],
                    ),
                    if (cubit.signUpOrLogin == 0) buildRegisterForm(context),
                    if (cubit.signUpOrLogin == 1) buildLoginForm(context),
                    const SizedBox(
                      height: 25.0,
                    ),
                    if (cubit.signUpOrLogin == 0)
                    ConditionalBuilder(
                      condition: state is! RegisterLoadingState,
                      fallback: (context) =>
                          const Center(child: CircularProgressIndicator()),
                      builder: (context) => MyButton(
                        text: "Register",
                        onPressed: () {
                          if (registerFormKey.currentState!.validate()) {
                            cubit.userDataRegister(
                              email: emailController.text,
                              password: passwordController.text,
                              firstName: firstNameController.text,
                              lastName: lastNameController.text,
                            );
                            // Navigator.of(context).pushReplacement(
                            //     MaterialPageRoute(builder: (_) => Home()));
                          }
                        },
                      ),
                    ),
                    if (cubit.signUpOrLogin == 1)
                    ConditionalBuilder(
                      condition: state is! LoginLoadingState,
                      fallback: (context) =>
                          const Center(child: CircularProgressIndicator()),
                      builder: (context) => MyButton(
                        text: "Login",
                        onPressed: () {
                          if (loginFormKey.currentState!.validate()) {
                            cubit.userDataLogin(
                              email: emailController.text,
                              password: passwordController.text,
                            );
                            // Navigator.of(context).pushReplacement(
                            //     MaterialPageRoute(builder: (_) => Home()));
                          }
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 25.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          color: Colors.grey,
                          height: 1,
                          width: 120.0,
                        ),
                        const Text(" or continue with "),
                        Container(
                          color: Colors.grey,
                          height: 1,
                          width: 120.0,
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 25.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                            onPressed: () {},
                            icon: const Icon(
                              MyIcons.google,
                              color: Colors.greenAccent,
                            )),
                        const SizedBox(
                          width: 25.0,
                        ),
                        IconButton(
                            onPressed: () {},
                            icon: const Icon(
                              MyIcons.facebook,
                              color: Colors.greenAccent,
                            )),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Form buildLoginForm(BuildContext context) {
    return Form(
      key: loginFormKey,
      child: Column(
        children: [
          textFormField(
            textFormFieldKey: "LoginEmail",
            textForm: "Email",
            textEditingController: emailController,
            prefixIcon: Icons.email_outlined,
            textInputType: TextInputType.emailAddress,
            validate: (value) {
              if (value!.isEmpty || !value.contains('@')) {
                return "Email doesn't validate please try again";
              }
              return null;
            },
          ),
          const SizedBox(
            height: 30.0,
          ),
          textFormField(
            textFormFieldKey: "RegisterEmail",
            textForm: "Password",
            textEditingController: passwordController,
            prefixIcon: Icons.lock_outline,
            textInputType: TextInputType.visiblePassword,
            validate: (value) {
              if (value!.length < 8) {
                return "Password must be at least 8 characters";
              }
              return null;
            },
            isPassword: LoginAndRegisterCubit.get(context).isPasword,
            suffixIcon: LoginAndRegisterCubit.get(context).suffixIcon,
            suffixPressed: () {
              LoginAndRegisterCubit.get(context)
                  .loginchangePasswordVisibility();
            },
          ),
        ],
      ),
    );
  }

  Form buildRegisterForm(BuildContext context) {
    return Form(
      key: registerFormKey,
      child: Column(
        children: [
          textFormField(
            textFormFieldKey: "RegisterFirstName",
            textForm: "First Name",
            textEditingController: firstNameController,
            //prefixIcon: Icons.email_outlined,
            textInputType: TextInputType.name,
            validate: (value) {
              if (value!.isEmpty) {
                return "First Name must be not empty";
              }
              return null;
            },
          ),
          const SizedBox(
            height: 30.0,
          ),
          textFormField(
            textFormFieldKey: "RegisterLastName",
            textForm: "Last Name",
            textEditingController: lastNameController,
            //prefixIcon: Icons.email_outlined,
            textInputType: TextInputType.name,
            validate: (value) {
              if (value!.isEmpty) {
                return "Last Name must be not empty";
              }
              return null;
            },
          ),
          const SizedBox(
            height: 30.0,
          ),
          textFormField(
            textFormFieldKey: "RegisterEmail",
            textForm: "Email",
            textEditingController: emailController,
            prefixIcon: Icons.email_outlined,
            textInputType: TextInputType.emailAddress,
            validate: (value) {
              if (value!.isEmpty || !value.contains('@')) {
                return "Email doesn't validate please try again";
              }
              return null;
            },
          ),
          const SizedBox(
            height: 30.0,
          ),
          textFormField(
            textFormFieldKey: "RegisterPassword",
            textForm: "Password",
            textEditingController: passwordController,
            prefixIcon: Icons.lock_outline,
            textInputType: TextInputType.visiblePassword,
            validate: (value) {
              if (value!.length < 8) {
                return "Password must be at least 8 characters";
              }
              return null;
            },
            isPassword: LoginAndRegisterCubit.get(context).isPasword,
            suffixIcon: LoginAndRegisterCubit.get(context).suffixIcon,
            suffixPressed: () {
              LoginAndRegisterCubit.get(context)
                  .loginchangePasswordVisibility();
            },
          ),
        ],
      ),
    );
  }
}
