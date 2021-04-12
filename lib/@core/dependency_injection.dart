import 'package:flutter_to_do/screens/splash/splash_view_model.dart';
import 'package:flutter_to_do/screens/todo/add/add_item_view_model.dart';
import 'package:flutter_to_do/screens/todo/list/home_view_model.dart';
import 'package:get_it/get_it.dart';

import 'data/api/todo.api.dart';
import 'data/database/todo.database.dart';

GetIt byInject = GetIt.instance;

void initInject() {

  byInject.registerLazySingleton<DBProvider>(() => DBProvider());

  byInject.registerFactory<SplashViewModel>(() => SplashViewModel());
  byInject.registerFactory<HomeViewModel>(() => HomeViewModel());
  byInject.registerFactory<AddItemViewModel>(() => AddItemViewModel());
}
