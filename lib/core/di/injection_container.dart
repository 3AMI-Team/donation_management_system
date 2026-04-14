import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

import 'package:donation_management_system/core/network/api/api_consumer.dart';
import 'package:donation_management_system/core/network/api/api_interceptors.dart';
import 'package:donation_management_system/core/network/api/dio_consumer.dart';
import 'package:donation_management_system/core/network/network_info.dart';

// Auth
import 'package:donation_management_system/features/auth/data/data_source/auth_remote_data_source.dart';
import 'package:donation_management_system/features/auth/data/data_source/user_local_data_source.dart';
import 'package:donation_management_system/features/auth/data/repo/auth_repo_impl.dart';
import 'package:donation_management_system/features/auth/domain/repo/auth_repo.dart';
import 'package:donation_management_system/features/auth/domain/use_case/login_use_case.dart';
import 'package:donation_management_system/features/auth/presentation/view_model/login_cubit/login_cubit.dart';

// Dashboard
import 'package:donation_management_system/features/dashboard/data/data_source/dashboard_remote_data_source.dart';
import 'package:donation_management_system/features/dashboard/data/repo/dashboard_repo_impl.dart';
import 'package:donation_management_system/features/dashboard/domain/repo/dashboard_repo.dart';
import 'package:donation_management_system/features/dashboard/domain/use_case/get_dashboard_kpis_use_case.dart';
import 'package:donation_management_system/features/dashboard/domain/use_case/get_donation_trends_use_case.dart';
import 'package:donation_management_system/features/dashboard/domain/use_case/get_last_donations_use_case.dart';
import 'package:donation_management_system/features/dashboard/domain/use_case/get_last_distributions_use_case.dart';
import 'package:donation_management_system/features/dashboard/presentation/view_model/kpis_cubit/kpis_cubit.dart';
import 'package:donation_management_system/features/dashboard/presentation/view_model/recent_activity_cubit/recent_activity_cubit.dart';
import 'package:donation_management_system/features/dashboard/presentation/view_model/trends_cubit/trends_cubit.dart';
import 'package:donation_management_system/features/dashboard/presentation/view_model/last_distributions_cubit/last_distributions_cubit.dart';

// Donors
import 'package:donation_management_system/features/donors/data/data_source/donors_remote_data_source.dart';
import 'package:donation_management_system/features/donors/data/repo/donors_repo_impl.dart';
import 'package:donation_management_system/features/donors/domain/repo/donors_repo.dart';
import 'package:donation_management_system/features/donors/domain/use_case/get_donors_use_case.dart';
import 'package:donation_management_system/features/donors/presentation/view_model/donors_cubit/donors_cubit.dart';

// Cases
import 'package:donation_management_system/features/cases/data/data_source/cases_remote_data_source.dart';
import 'package:donation_management_system/features/cases/data/repo/cases_repo_impl.dart';
import 'package:donation_management_system/features/cases/domain/repo/cases_repo.dart';
import 'package:donation_management_system/features/cases/domain/use_case/get_cases_use_case.dart';
import 'package:donation_management_system/features/cases/presentation/view_model/cases_cubit/cases_cubit.dart';

final sl = GetIt.instance;

Future<void> init() async {
  _initCore();
  _initAuth();
  _initDashboard();
  _initDonors();
  _initCases();
  _initExternal();
}

void _initCore() {
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));
}

void _initAuth() {
  // Cubit
  sl.registerFactory(() => LoginCubit(loginUseCase: sl()));

  // Use Case
  sl.registerLazySingleton(() => LoginUseCase(repository: sl()));

  // Repository
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
}

void _initDashboard() {
  // Cubits
  sl.registerFactory(() => KpisCubit(getDashboardKpisUseCase: sl()));
  sl.registerFactory(() => TrendsCubit(getDonationTrendsUseCase: sl()));
  sl.registerFactory(() => RecentActivityCubit(getLastDonationsUseCase: sl()));
  sl.registerFactory(
      () => LastDistributionsCubit(getLastDistributionsUseCase: sl()));

  // Use Cases
  sl.registerLazySingleton(() => GetDashboardKpisUseCase(sl()));
  sl.registerLazySingleton(() => GetDonationTrendsUseCase(sl()));
  sl.registerLazySingleton(() => GetLastDonationsUseCase(sl()));
  sl.registerLazySingleton(() => GetLastDistributionsUseCase(sl()));

  // Repository
  sl.registerLazySingleton<DashboardRepo>(
    () => DashboardRepoImpl(
      remoteDataSource: sl(),
      networkInfo: sl(),
    ),
  );

  // Data Source
  sl.registerLazySingleton<DashboardRemoteDataSource>(
    () => DashboardRemoteDataSourceImpl(sl()),
  );
}

void _initDonors() {
  // Cubit
  sl.registerFactory(() => DonorsCubit(getDonorsUseCase: sl()));

  // Use Case
  sl.registerLazySingleton(() => GetDonorsUseCase(repository: sl()));

  // Repository
  sl.registerLazySingleton<DonorsRepo>(
    () => DonorsRepoImpl(
      remoteDataSource: sl(),
      networkInfo: sl(),
    ),
  );

  // Data Source
  sl.registerLazySingleton<DonorsRemoteDataSource>(
    () => DonorsRemoteDataSourceImpl(api: sl()),
  );
}

void _initCases() {
  // Cubit
  sl.registerFactory(() => CasesCubit(getCasesUseCase: sl()));

  // Use Case
  sl.registerLazySingleton(() => GetCasesUseCase(repository: sl()));

  // Repository
  sl.registerLazySingleton<CasesRepo>(
    () => CasesRepoImpl(
      remoteDataSource: sl(),
      networkInfo: sl(),
    ),
  );

  // Data Source
  sl.registerLazySingleton<CasesRemoteDataSource>(
    () => CasesRemoteDataSourceImpl(api: sl()),
  );
}

void _initExternal() {
  // Storage
  sl.registerLazySingleton(() => const FlutterSecureStorage());

  // Network
  sl.registerLazySingleton(() => InternetConnectionChecker.instance);
  sl.registerLazySingleton(() => Dio());
  sl.registerLazySingleton<ApiConsumer>(() => DioConsumer(dio: sl()));

  // Interceptors
  sl.registerLazySingleton(() => ApiInterceptor());
  sl.registerLazySingleton(
    () => AuthInterceptor(
      getToken: () => sl<UserLocalDataSource>().getToken(),
    ),
  );

  // Apply Interceptors
  final dio = sl<Dio>();
  dio.interceptors.addAll([
    sl<ApiInterceptor>(),
    sl<AuthInterceptor>(),
  ]);
}
