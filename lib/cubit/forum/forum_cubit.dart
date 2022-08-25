import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:la_vie/core/styles/colors/app_colors.dart';
import 'package:la_vie/model/forum/forum_model.dart';
import 'package:la_vie/services/local/shared_preference/cache_helper.dart';
import 'package:la_vie/services/network/dio/dio_helper.dart';
import 'package:la_vie/services/network/dio/end_points.dart';
import 'package:meta/meta.dart';

part 'forum_state.dart';

class ForumCubit extends Cubit<ForumState> {
  ForumCubit() : super(ForumInitial());
  static ForumCubit get(context) => BlocProvider.of(context);

  int currentTabBarItem = 0;
  void changeCurrentTabBarItem(int index) {
    currentTabBarItem = index;
    emit(ChangeTabBarItem());
  }

  ForumModel? allForumModel;
  void getAllForums() {
    emit(ForumGetAllForumsLoadingState());
    DioHelper.getData(
      url: ALL_FORUMS,
      token: CacheHelper.getData(key: 'accessToken'),
    ).then((value) {
      allForumModel = ForumModel.fromJson(value.data);
      emit(ForumGetAllForumsSuccessState());
    }).catchError((error) {
      emit(ForumGetAllForumsErrorState());
    });
  }

  ForumModel? myForumModel;
  void getMyForums() {
    emit(ForumGetMyForumsLoadingState());
    DioHelper.getData(
      url: MY_FORUMS,
      token: CacheHelper.getData(key: 'accessToken'),
    ).then((value) {
      myForumModel = ForumModel.fromJson(value.data);
      emit(ForumGetMyForumsSuccessState());
    }).catchError((error) {
      emit(ForumGetMyForumsErrorState());
    });
  }

  void likeForum(String forumId, int forumKind) {
    addLikeToModels(forumId);
    emit(ForumLikeLoadingState());
    DioHelper.postData(
      url: "forums/$forumId/like",
      token: CacheHelper.getData(key: 'accessToken'),
    ).then((value) {
      if (forumKind == 0) {
        getAllForums();
      } else {
        getMyForums();
      }
      emit(ForumLikeSuccessState());
    }).catchError((error) {
      print("like post error is ${error.toString()}");
      addLikeToModels(forumId);
      emit(ForumLikeErrorState());
    });
  }

  bool isUserLiked(List<ForumLikes> forumLikes) {
    String userId = CacheHelper.getData(key: "userId") ?? "";
    for (var userLike in forumLikes) {
      if (userLike.userId == userId) return true;
    }
    return false;
  }

  void addLikeToModels(String forumId) {
    addLikeToAllForumsModel(forumId);
    addLikeToMyForumsModel(forumId);
  }

  void addLikeToAllForumsModel(String forumId) {
    for (var forum in allForumModel!.data!) {
      if (forum.forumId == forumId) {
        if (isUserLiked(forum.forumLikes!)) {
          forum.forumLikes!.removeWhere((element) =>
              element.userId == CacheHelper.getData(key: "userId"));
        } else {
          forum.forumLikes!.add(ForumLikes(
              forumId: forumId, userId: CacheHelper.getData(key: "userId")));
        }
      }
    }
  }

  void addLikeToMyForumsModel(String forumId) {
    for (var forum in myForumModel!.data!) {
      if (forum.forumId == forumId) {
        if (isUserLiked(forum.forumLikes!)) {
          forum.forumLikes!.removeWhere((element) =>
              element.userId == CacheHelper.getData(key: "userId"));
        } else {
          forum.forumLikes!.add(ForumLikes(
              forumId: forumId, userId: CacheHelper.getData(key: "userId")));
        }
      }
    }
  }

  void sendCommentOnForum(String forumId, int forumKind,
      {required String comment}) {
    emit(CommentOnForumLoadingState());
    DioHelper.postData(
        url: "forums/$forumId/comment",
        token: CacheHelper.getData(key: 'accessToken'),
        data: {"comment": comment}).then((value) {
      if (forumKind == 0) {
        getAllForums();
      } else {
        getMyForums();
      }
      emit(CommentOnForumSuccessfulState());
    }).catchError((error) {
      print("send comment error is ${error.toString()}");
      emit(CommentOnForumErrorState());
    });
  }

  void createPost({required String title, required String description}) {
    emit(ForumCreatePostLoadingState());
    DioHelper.postData(
      url: CREATE_POST,
      data: {
        "title": title,
        "description": description,
        "imageBase64": _base64Image,
      },
      token: CacheHelper.getData(key: 'accessToken'),
    ).then((value) {
      Fluttertoast.showToast(
        msg: "Your Post Uploaded Successfully",
        backgroundColor: AppColors.primaryColor,
      );
      uploadedPostImage = null;
      emit(ForumCreatePostSuccessState());
      getAllForums();
      getMyForums();
    }).catchError((error) {
      debugPrint(error.toString());
      emit(ForumCreatePostErrorState());
    });
  }

  String _base64Image = "";
  ImagePicker imagePicker = ImagePicker();
  File? uploadedPostImage;
  Future<void> pickPostImage() async {
    imagePicker.pickImage(source: ImageSource.gallery).then((value) {
      if (value != null) {
        uploadedPostImage = File(value.path);
        Uint8List bytes = uploadedPostImage!.readAsBytesSync();
        _base64Image = base64.encode(bytes);
        _base64Image =
            "data:image/${value.name.split('.').last};base64,$_base64Image";
      }
      emit(ForumPickImageState());
    });
  }
}
