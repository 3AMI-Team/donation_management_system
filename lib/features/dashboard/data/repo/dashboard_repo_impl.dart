import 'package:dartz/dartz.dart';
import '../../../../core/network/errors/exceptions.dart';
import '../../../../core/network/errors/failure.dart';
import '../../../../core/network/network_info.dart';
import '../../domain/entity/dashboard_kpis_entity.dart';
import '../../domain/repo/dashboard_repo.dart';
import '../data_source/dashboard_remote_data_source.dart';

class DashboardRepoImpl implements DashboardRepo {
  final DashboardRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  DashboardRepoImpl({
    required this.remoteDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, DashboardKpis>> getDashboardKpis() async {
    if (await networkInfo.isConnected) {
      try {
        final result = await remoteDataSource.getDashboardKpis();
        return Right(result);
      } on AppException catch (e) {
        if (e is ServerException) {
          return Left(ServerFailure(message: e.message, code: e.statusCode));
        } else if (e is NetworkException) {
          return const Left(NetworkFailure());
        } else if (e is ValidationException) {
          return Left(ValidationFailure(message: e.message, errors: e.errors));
        } else if (e is UnauthorizedException) {
          return const Left(UnauthorizedFailure());
        } else {
          return Left(ServerFailure(message: e.message));
        }
      } catch (e) {
        return Left(UnknownFailure(message: 'Unexpected error: ${e.toString()}'));
      }
    } else {
      return const Left(NetworkFailure());
    }
  }
}
