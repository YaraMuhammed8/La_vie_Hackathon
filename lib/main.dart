import 'package:bloc/bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:la_vie/services/local/shared_preference/cache_helper.dart';
import 'package:la_vie/services/local/sql/sql_helper.dart';
import 'package:la_vie/services/network/dio/dio_helper.dart';
import 'package:la_vie/src/app_root.dart';

import 'cubit/observer/bloc_observer.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  DioHelper.init();
  await SqlHelper.initDB();
  await CacheHelper.init();
  Bloc.observer = MyBlocObserver();
  runApp(const AppRoot());
}