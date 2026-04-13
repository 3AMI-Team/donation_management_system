import 'package:dio/dio.dart';
import 'package:donation_management_system/core/network/api/api_consumer.dart';
import 'package:donation_management_system/core/network/api/api_interceptors.dart';
import 'package:donation_management_system/core/network/api/dio_consumer.dart';
import 'package:donation_management_system/core/network/network_info.dart';
import 'package:donation_management_system/features/auth/data/data_source/auth_remote_data_source.dart';
import 'package:donation_management_system/features/auth/data/data_source/user_local_data_source.dart';
import 'package:donation_management_system/features/auth/data/repo/auth_repo_impl.dart';
import 'package:donation_management_system/features/auth/domain/repo/auth_repo.dart';
import 'package:donation_management_system/features/auth/domain/use_case/login_use_case.dart';
import 'package:donation_management_system/features/auth/presentation/view_model/login_cubit/login_cubit.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:donation_management_system/features/cases/data/data_source/cases_remote_data_source.dart';
import 'package:donation_management_system/features/cases/data/repo/cases_repo_impl.dart';
import 'package:donation_management_system/features/cases/domain/repo/cases_repo.dart';
import 'package:donation_management_system/features/cases/domain/use_case/get_cases_use_case.dart';
import 'package:donation_management_system/features/cases/presentation/view_model/cases_cubit/cases_cubit.dart';
import 'package:donation_management_system/features/donors/data/data_source/donors_remote_data_source.dart';
import 'package:donation_management_system/features/donors/data/repo/donors_repo_impl.dart';
import 'package:donation_management_system/features/donors/domain/repo/donors_repo.dart';
import 'package:donation_management_system/features/donors/domain/use_case/get_donors_use_case.dart';
import 'package:donation_management_system/features/donors/presentation/view_model/donors_cubit/donors_cubit.dart';

final sl = GetIt.instance;

/// Initialize Dependency Injection
Future<void> init() async {
  //! Features - Auth
  // Cubits
  sl.registerFactory(() => LoginCubit(loginUseCase: sl()));

  // UseCases
  sl.registerLazySingleton(() => LoginUseCase(repository: sl()));

  // Repositories
  sl.registerLazySingleton<AuthRepo>(
    () => AuthRepoImpl(
      remoteDataSource: sl(),
      localDataSource: sl(),
      networkInfo: sl(),
    ),
  );

  // Data Sources
  sl.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(api: sl()),
  );
  sl.registerLazySingleton<UserLocalDataSource>(
    () => UserLocalDataSourceImpl(secureStorage: sl()),
  );

  //! Features - Donors
  sl.registerFactory(() => DonorsCubit(getDonorsUseCase: sl()));
  sl.registerLazySingleton(() => GetDonorsUseCase(repository: sl()));
  sl.registerLazySingleton<DonorsRepo>(
    () => DonorsRepoImpl(remoteDataSource: sl(), networkInfo: sl()),
  );
  sl.registerLazySingleton<DonorsRemoteDataSource>(
    () => DonorsRemoteDataSourceImpl(api: sl()),
  );

  //! Features - Cases
  sl.registerFactory(() => CasesCubit(getCasesUseCase: sl()));
  sl.registerLazySingleton(() => GetCasesUseCase(repository: sl()));
  sl.registerLazySingleton<CasesRepo>(
    () => CasesRepoImpl(remoteDataSource: sl(), networkInfo: sl()),
  );
  sl.registerLazySingleton<CasesRemoteDataSource>(
    () => CasesRemoteDataSourceImpl(api: sl()),
  );

  //! Core
  sl.registerLazySingleton<ApiConsumer>(() => DioConsumer(dio: sl()));
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));

  //! External
  sl.registerLazySingleton(() => const FlutterSecureStorage());
  sl.registerLazySingleton(() {
    final dio = Dio();
    dio.interceptors.add(ApiInterceptor());
    dio.interceptors.add(AuthInterceptor(getToken: () => sl<UserLocalDataSource>().getToken()));
    return dio;
  });
  sl.registerLazySingleton(() => InternetConnectionChecker.createInstance());
}
