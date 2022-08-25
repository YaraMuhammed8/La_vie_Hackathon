import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:la_vie/model/home/all_products.dart';
import 'package:la_vie/model/home/plants.dart';
import 'package:la_vie/model/home/seeds.dart';
import 'package:la_vie/services/local/shared_preference/cache_helper.dart';
import 'package:la_vie/services/network/dio/dio_helper.dart';
import 'package:la_vie/services/network/dio/end_points.dart';
import 'package:meta/meta.dart';

import '../../model/home/tools.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());
  static HomeCubit get(context) => BlocProvider.of(context);

  int currentTabBarItem = 0;
  void changeCurrentTabBarItem(int index) {
    currentTabBarItem = index;
    emit(ChangeTabBarItem());
  }

  Seeds? seeds;
  void getSeeds() {
    emit(GetSeedsLoadingState());
    DioHelper.getData(
            url: SEEDS, token: CacheHelper.getData(key: "accessToken"))
        .then((value) {
      seeds = Seeds.fromJson(value.data);
      emit(GetSeedsSuccessfulState());
    }).catchError((error) {
      print("getting seeds error: ${error.toString()}");
      emit(GetSeedsErrorState());
    });
  }

  Plants? plants;
  void getPlants() {
    emit(GetPlantsLoadingState());
    DioHelper.getData(
            url: PLANTS, token: CacheHelper.getData(key: "accessToken"))
        .then((value) {
      plants = Plants.fromJson(value.data);
      emit(GetPlantsSuccessfulState());
    }).catchError((error) {
      print("getting plants error is: ${error.toString()}");
      emit(GetPlantsErrorState());
    });
  }

  Tools? tools;
  void getTools() {
    emit(GetToolsLoadingState());
    DioHelper.getData(
            url: TOOLS, token: CacheHelper.getData(key: "accessToken"))
        .then((value) {
      tools = Tools.fromJson(value.data);
      emit(GetToolsSuccessfulState());
    }).catchError((error) {
      print("getting tools error is: ${error.toString()}");
      emit(GetToolsErrorState());
    });
  }

  AllProductsResponse? allProductsResponse;
  List<dynamic> products = [];
  void getAllProducts() {
    emit(GetAllProductsLoadingState());
    DioHelper.getData(
            url: ALL_PRODUCTS, token: CacheHelper.getData(key: "accessToken"))
        .then((value) {
      allProductsResponse = AllProductsResponse.fromJson(value.data);
      fillProductsList();
      emit(GetAllProductsSuccessfulState());
    }).catchError((error) {
      print("getting all products error is: ${error.toString()}");
      emit(GetAllProductsErrorState());
    });
  }

  void fillProductsList() {
    for (dynamic item in allProductsResponse!.data.plants) {
      products.add(item);
    }
    for (dynamic item in allProductsResponse!.data.seeds) {
      products.add(item);
    }
    for (dynamic item in allProductsResponse!.data.tools) {
      products.add(item);
    }
    products.shuffle();
  }
  Plant? scannedPlant;
  void getPlantDetails(String plantId) {
    emit(GetPlantDetailsLoadingState());
    DioHelper.getData(
            url: PLANT,
            query: {"plantId": plantId},
            token: CacheHelper.getData(key: "accessToken"))
        .then((value) {
          print("*********\n*******\n********\n*********\n****");
      print(value.data);
      scannedPlant = Plant.fromJson(value.data["data"][0]);
      emit(GetPlantDetailsSuccessfulState());
    }).catchError((error) {
      print("getting plant details error is: ${error.toString()}");
      emit(GetPlantDetailsErrorState());
    });
  }

  void resetScannedResult(){
    scannedPlant = null;
    emit(state);
  }
}
