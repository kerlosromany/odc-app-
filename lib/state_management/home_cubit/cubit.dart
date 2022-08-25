import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instant_project/constants/components.dart';
import 'package:instant_project/constants/dio_helper.dart';
import 'package:instant_project/constants/end_points.dart';
import 'package:instant_project/constants/shared_preferences.dart';
import 'package:instant_project/models/carts_model.dart';
import 'package:instant_project/screens/notifications.dart';
import 'package:instant_project/screens/scan.dart';
import 'package:instant_project/screens/user.dart';
import 'package:instant_project/state_management/home_cubit/states.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';

import '../../constants/database_helper.dart';
import '../../models/blogs_model.dart';
import '../../models/products_model.dart';
import '../../models/plants_model.dart';
import '../../models/search_model.dart';
import '../../models/seeds_model.dart';
import '../../models/tools_model.dart';
import '../../screens/blogs.dart';

class HomeCubit extends Cubit<HomeStates> {
  HomeCubit() : super(HomeInitialState());

  static HomeCubit get(context) => BlocProvider.of(context);

  ProductsModel? productsModel;
  void getProductsData() {
    emit(ProductsLoadingDataState());
    DioHelper.getData(
      url: PRODUCTS,
      token: "Bearer $token",
    ).then((value) {
      productsModel = ProductsModel.fromJson(value.data);

      emit(ProductsSuccessDataState());
    }).catchError((error) {
      print(error.toString());
      emit(ProductsErrorDataState(error.toString()));
    });
  }

  PlantModel? plantModel;
  void getHomePlantsData() {
    emit(HomePlantsLoadingDataState());
    DioHelper.getData(
      url: HOMEPLANTS,
      token: "Bearer $token",
    ).then((value) {
      plantModel = PlantModel.fromJson(value.data);
      emit(HomePlantsSuccessDataState());
    }).catchError((error) {
      print(error.toString());
      emit(HomePlantsErrorDataState(error.toString()));
    });
  }

  ToolsModel? toolsModel;
  void getHomeToolsData() {
    emit(HomeToolsLoadingDataState());
    DioHelper.getData(
      url: HOMETOOLS,
      token: "Bearer $token",
    ).then((value) {
      toolsModel = ToolsModel.fromJson(value.data);
      emit(HomeToolsSuccessDataState());
    }).catchError((error) {
      print(error.toString());
      emit(HomeToolsErrorDataState(error.toString()));
    });
  }

  SeedsModel? seedsModel;
  void getHomeSeedsData() {
    emit(HomeSeedsLoadingDataState());
    DioHelper.getData(
      url: HOMESEEDS,
      token: "Bearer $token",
    ).then((value) {
      seedsModel = SeedsModel.fromJson(value.data);
      emit(HomeSeedsSuccessDataState());
    }).catchError((error) {
      print(error.toString());
      emit(HomeSeedsErrorDataState(error.toString()));
    });
  }

  SearchModel? searchModel;

  void getSearchData(String productId) {
    emit(SearchLoadingState());
    DioHelper.getData(
      url: '/api/v1/products/$productId',
      token: "Bearer $token",
    ).then((value) {
      //print(value.data);
      searchModel = SearchModel.fromJson(value.data);
      
      emit(SearchSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(SearchErrorState());
    });
  }
}
