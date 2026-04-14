import 'package:dartz/dartz.dart';
import 'package:donation_management_system/core/network/errors/exceptions.dart';
import 'package:donation_management_system/core/network/errors/failure.dart';
import 'package:donation_management_system/core/network/network_info.dart';
import 'package:donation_management_system/features/auth/data/data_source/auth_remote_data_source.dart';
import 'package:donation_management_system/features/auth/data/data_source/user_local_data_source.dart';
import 'package:donation_management_system/features/auth/domain/entity/user_entity.dart';
import 'package:donation_management_system/features/auth/domain/repo/auth_repo.dart';

class AuthRepoImpl implements AuthRepo {
  final AuthRemoteDataSource remoteDataSource;
  final UserLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  AuthRepoImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, UserEntity>> login({
    required String username,
    required String password,
  }) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteUser = await remoteDataSource.login(
          username: username,
          password: password,
        );

        // Save token locally
        await localDataSource.saveToken(remoteUser.token);

        return Right(remoteUser);
      } on AppException catch (e) {
        return Left(ServerFailure(message: e.message, code: e.statusCode));
      } catch (e) {
        return const Left(UnknownFailure());
      }
    } else {
      return const Left(NetworkFailure());
    }
  }

  @override
  Future<bool> isLoggedIn() async {
    return await localDataSource.hasToken();
  }
}
