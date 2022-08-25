import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instant_project/Login/login_screen.dart';
import 'package:instant_project/constants/components.dart';
import 'package:instant_project/constants/shared_preferences.dart';

import 'package:instant_project/custom_widgets/all_products.dart';
import 'package:instant_project/my_flutter_app_icons.dart';
import 'package:instant_project/screens/blogs.dart';
import 'package:instant_project/screens/carts.dart';
import 'package:instant_project/screens/forums.dart';
import 'package:instant_project/screens/quiz_screen.dart';
import 'package:instant_project/screens/search.dart';
import 'package:instant_project/screens/user.dart';
import 'package:instant_project/state_management/provider/provider.dart';
import 'package:provider/provider.dart';

import '../custom_widgets/plants.dart';
import '../custom_widgets/seeds.dart';
import '../custom_widgets/tools.dart';
import '../state_management/home_cubit/cubit.dart';
import '../state_management/home_cubit/states.dart';
import 'notifications.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int checkedWidget = 0;
  @override
  Widget build(BuildContext context) {
    var cart = Provider.of<CartProvider>(context);
    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (context, state) {},
      builder: (context, state) {
        HomeCubit cubit = HomeCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: const Text(
              "La Via",
              style: TextStyle(color: Colors.black),
            ),
            // actions: [
            //   signOut(context),
            //   IconButton(
            //     onPressed: () {},
            //     icon: const Icon(Icons.add),
            //   ),
            // ],
          ),
          body: SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
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
                        FloatingActionButton(
                          heroTag: Text("question"),
                          backgroundColor: Colors.greenAccent,
                          child: const Icon(
                            Icons.question_mark,
                            color: Colors.white,
                          ),
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (_) => QuizScreen()));
                          },
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 15.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: InkWell(
                            onTap: () => Navigator.of(context).push(
                                MaterialPageRoute(
                                    builder: (_) => SearchScreen())),
                            child: Container(
                              height: 60,
                              padding: const EdgeInsets.only(left: 20.0),
                              decoration: BoxDecoration(
                                color: Colors.grey.withOpacity(0.5),
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                              child: Row(
                                children: const [
                                  Icon(Icons.search),
                                  SizedBox(
                                    width: 20.0,
                                  ),
                                  Text("Search"),
                                ],
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 20.0,
                        ),
                        InkWell(
                          onTap: () {
                            //cart.clearSharedPref();
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (_) => CartsScreen()));
                          },
                          child: Container(
                            width: 60,
                            height: 60,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.greenAccent,
                            ),
                            child: Badge(
                              padding: const EdgeInsets.all(5.0),
                              badgeColor: Colors.green,
                              badgeContent: Consumer<CartProvider>(
                                builder: (context, value, child) {
                                  return Text(
                                    value.getCounter().toString(),
                                    style: const TextStyle(color: Colors.white),
                                  );
                                },
                              ),
                              child: const Icon(Icons.shopping_cart_outlined),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        homeFields(
                          text: "All",
                          index: 0,
                        ),
                        homeFields(
                          text: "Plants",
                          index: 1,
                        ),
                        homeFields(
                          text: "Seeds",
                          index: 2,
                        ),
                        homeFields(
                          text: "Tools",
                          index: 3,
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    if (checkedWidget == 0) AllProducts(),
                    if (checkedWidget == 1) Plants(),
                    if (checkedWidget == 2) Seeds(),
                    if (checkedWidget == 3) Tools(),
                  ],
                ),
              ),
            ),
          ),
          floatingActionButton: FloatingActionButton(
            child: const Icon(
              Icons.home,
              color: Colors.white,
            ),
            onPressed: () {},
            backgroundColor: Colors.greenAccent,
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          bottomNavigationBar: BottomAppBar(
            shape: const CircularNotchedRectangle(),
            child: SizedBox(
              height: 80,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      icon: const Icon(MyIcons.leaf),
                      onPressed: () {
                        Navigator.of(context).push(
                            MaterialPageRoute(builder: (_) => ForumsScreen()));
                      },
                    ),
                    IconButton(
                      icon: const Icon(Icons.crop_free),
                      onPressed: () {},
                    ),
                    const SizedBox.shrink(),
                    IconButton(
                      icon: const Icon(Icons.notifications),
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (_) => const NotificationsScreen()));
                      },
                    ),
                    IconButton(
                      icon: const Icon(Icons.person),
                      onPressed: () {
                        Navigator.of(context).push(
                            MaterialPageRoute(builder: (_) => const UserScreen()));
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  InkWell homeFields({
    required String text,
    required int index,
  }) {
    return InkWell(
      onTap: () => setState(() {
        checkedWidget = index;
        //print(checkedWidget);
      }),
      child: Container(
        width: 80,
        height: 50,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.0),
          color: (checkedWidget == index)
              ? Colors.greenAccent
              : Colors.grey.withOpacity(0.5),
        ),
        child: Center(
            child: Text(
          text,
          textAlign: TextAlign.center,
        )),
      ),
    );
  }
}
