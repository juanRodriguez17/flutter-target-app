import 'package:dio/dio.dart';
import 'package:flutter_base_rootstrap/data/data_sources/local/abstract/preferences.dart';
import 'package:flutter_base_rootstrap/data/data_sources/local/concrete/preferences.dart';
import 'package:flutter_base_rootstrap/data/data_sources/remote/abstract/auth_data_source.dart';
import 'package:flutter_base_rootstrap/data/data_sources/remote/abstract/product_data_source.dart';
import 'package:flutter_base_rootstrap/data/data_sources/remote/concrete/product_data_source_impl.dart';
import 'package:flutter_base_rootstrap/data/network/config/network_config.dart';
import 'package:flutter_base_rootstrap/data/network/interceptors/header_interceptor.dart';
import 'package:flutter_base_rootstrap/data/preferences/preferences.dart'
    as prefs;
import 'package:flutter_base_rootstrap/data/preferences/preferences_impl.dart'
    as prefs_impl;
import 'package:flutter_base_rootstrap/data/repositories/auth_repository_impl.dart';
import 'package:flutter_base_rootstrap/data/repositories/product_repository_impl.dart';
import 'package:flutter_base_rootstrap/devices/permissions/abstract/permission_manager.dart';
import 'package:flutter_base_rootstrap/devices/permissions/concrete/mobile/_permissions_android.dart';
import 'package:flutter_base_rootstrap/devices/permissions/concrete/mobile/_permissions_ios.dart';
import 'package:flutter_base_rootstrap/devices/permissions/concrete/web/_permissions_web.dart';
import 'package:flutter_base_rootstrap/devices/platform/abstract/app_platform.dart';
import 'package:flutter_base_rootstrap/devices/platform/abstract/platform_info.dart';
import 'package:flutter_base_rootstrap/devices/platform/concrete/_app_platform_impl.dart'
    if (dart.library.io) 'package:flutter_base_rootstrap/devices/platform/concrete/mobile_desk/_app_platform_impl.dart'
    if (dart.library.html) 'package:flutter_base_rootstrap/devices/platform/concrete/web/_app_platform_impl.dart';
import 'package:flutter_base_rootstrap/devices/platform/concrete/_platform_info_impl.dart';
import 'package:flutter_base_rootstrap/domain/repositories/auth_repository.dart';
import 'package:flutter_base_rootstrap/domain/repositories/product_repository.dart';
import 'package:flutter_base_rootstrap/domain/use_cases/get_products_use_case.dart';
import 'package:flutter_base_rootstrap/domain/use_cases/sign_in_use_case.dart';
import 'package:flutter_base_rootstrap/presentation/bloc/get_products/get_products_cubit.dart';
import 'package:flutter_base_rootstrap/presentation/bloc/get_products_repo/get_products_repo_cubit.dart';
import 'package:flutter_base_rootstrap/presentation/bloc/sign_in/sign_in_cubit.dart';
import 'package:flutter_base_rootstrap/utils/globals.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../data/data_sources/remote/concrete/auth_data_source_impl.dart';

//**
// GetIt:
// registerFactory: instance will be created on each call
// registerSingleton: a singleton instance will be created when init the app
// registerLazySingleton: a singleton instance will be created the first time is called
// *Async: for async constructors or executing a flow before creating the instance
// to get the instance:
// getIt<ServiceExample>()
// tip: on widgets you should only get services.
// **//
Future<void> initialize() async {
  final pref = await SharedPreferences.getInstance();

  getIt.registerSingleton<SharedPreferences>(pref);
  getIt.registerSingleton<Preferences>(PreferencesImpl(getIt()));
  getIt.registerSingleton<AppPlatform>(AppPlatformImpl());
  getIt.registerSingleton<prefs.Preferences>(
    prefs_impl.PreferencesImpl(getIt()),
  );
  getIt.registerLazySingleton<PlatformInfo>(() => PlatformInfoImpl(getIt()));
  getIt.registerLazySingleton<PermissionManager>(() {
    final platforms = getIt<AppPlatform>();
    if (platforms.isWeb) {
      return PermissionsWeb();
    }
    if (platforms.isAndroid) {
      return PermissionsAndroid();
    }

    return PermissionsIOs();
  });

  //Network
  getIt.registerFactory(() => HeaderInterceptor());
  getIt.registerLazySingleton<Dio>(() => NetworkConfig.provideDio(getIt()));

  //Data Sources
  getIt.registerLazySingleton<ProductDataSource>(
    () => ProductDataSourceImpl(getIt()),
  );
  getIt.registerLazySingleton<AuthDataSource>(
    () => AuthDataSourceImpl(getIt(), getIt()),
  );
  //Repositories
  getIt.registerLazySingleton<ProductRepository>(
    () => ProductRepositoryImpl(getIt()),
  );
  getIt.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(getIt()),
  );
  //Use cases
  getIt.registerFactory(() => GetProductsUseCase(getIt()));
  getIt.registerFactory(() => SignInUseCase(getIt()));
  //Cubits
  getIt.registerFactory(() => GetProductsRepoCubit(getIt()));
  getIt.registerFactory(() => GetProductsCubit(getIt()));
  getIt.registerFactory(() => SignInCubit(getIt()));
}
