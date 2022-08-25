import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:la_vie/model/user/user_data_response.dart';
import 'package:la_vie/services/local/shared_preference/cache_helper.dart';
import 'package:la_vie/services/network/dio/dio_helper.dart';
import 'package:la_vie/services/network/dio/end_points.dart';
import 'package:meta/meta.dart';

import '../../model/user/uploaded_image.dart';

part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  UserCubit() : super(UserInitial());
  static UserCubit get(context) => BlocProvider.of(context);
  UserDataResponse? userDataResponse;
  void getUserData() {
    emit(GetUserDataLoadingState());
    DioHelper.getData(
            url: USER_DATA, token: CacheHelper.getData(key: "accessToken"))
        .then((value) {
      userDataResponse = UserDataResponse.fromJson(value.data);
      emit(GetUserDataSuccessfulState());
    }).catchError((error) {
      print("getting user error is: ${error.toString()}");
    });
  }

  UploadedImage? uploadedImage;
  Future<void> uploadImage() async {
    String base64Image = "";
    final ImagePicker imagePicker = ImagePicker();
    await imagePicker
        .pickImage(source: ImageSource.gallery)
        .then((value) async {
      if (value != null) {
        final resultFile = File(value.path);
        Uint8List bytes = await resultFile.readAsBytes();
        base64Image = base64.encode(bytes);
        base64Image = "data:image/${value.name.split('.').last};base64,$base64Image";
        log(base64Image);
        uploadedImage =
            UploadedImage(base64Image: base64Image, file: resultFile);
        emit(UploadImageSuccessful());
        updateProfilePicture(base64Image);
      }
    });
  }

  void updateProfilePicture(String base64Image) {
    emit(UpdateProfilePictureLoadingState());
    DioHelper.patchData(
            url: UPDATE_PROFILE,
            data: {"imageUrl": base64Image},
            token: CacheHelper.getData(key: "accessToken"))
        .then((value) {
      print(value.data);
      userDataResponse!.data.imageUrl = value.data["data"]["imageUrl"];
      emit(UpdateProfilePictureSuccessfulState());
    }).catchError((error) {
      print("update profile pic ${error.toString()}");
      emit(UpdateProfilePictureErrorState());
    });
  }

  void updateUserDate(
      {required String firstName,
      required String lastName,
      required String email,
      required String address}) {
    emit(UpdateUserDataLoadingState());
    DioHelper.patchData(
            url: UPDATE_PROFILE,
            data: {
              "firstName": firstName,
              "lastName": lastName,
              "email": email,
              "address": address
            },
            token: CacheHelper.getData(key: "accessToken"))
        .then((value) {
      print(value.data);
      // userDataResponse!.data.firstName = firstName;
      // userDataResponse!.data.lastName = lastName;
      // userDataResponse!.data.email = email;
      // userDataResponse!.data.address = address;
      emit(UpdateUserDataSuccessfulState());
      getUserData();
    }).catchError((error) {
      if (error is DioError) {
        print("update profile pic ${error.toString()}");
        emit(UpdateUserDataErrorState(
            message: error.response!.data["message"].toString()));
      }
    });
  }
}
