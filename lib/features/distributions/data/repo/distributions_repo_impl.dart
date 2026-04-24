import 'package:dartz/dartz.dart';
import 'package:donation_management_system/core/network/errors/exceptions.dart';
import 'package:donation_management_system/core/network/errors/failure.dart';
import 'package:donation_management_system/core/network/network_info.dart';
import 'package:donation_management_system/features/distributions/data/data_source/distributions_remote_data_source.dart';
import 'package:donation_management_system/features/distributions/domain/entity/distribution_entity.dart';
import 'package:donation_management_system/features/distributions/domain/entity/distribution_kpis_entity.dart';
import 'package:donation_management_system/features/distributions/domain/repo/distributions_repo.dart';

class DistributionsRepoImpl implements DistributionsRepo {
  final DistributionsRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  DistributionsRepoImpl({
    required this.remoteDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, DistributionKpisEntity>> getDistributionKpis() async {
    if (await networkInfo.isConnected) {
      try {
        final response = await remoteDataSource.getDistributionKpis();
        return Right(response);
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
  Future<Either<Failure, List<DistributionEntity>>> getDistributions() async {
    if (await networkInfo.isConnected) {
      try {
        final response = await remoteDataSource.getDistributions();
        return Right(response);
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
  Future<Either<Failure, void>> addDistribution(
      Map<String, dynamic> distributionData) async {
    if (await networkInfo.isConnected) {
      try {
        await remoteDataSource.addDistribution(distributionData);
        return const Right(null);
      } on AppException catch (e) {
        return Left(ServerFailure(message: e.message, code: e.statusCode));
      } catch (e) {
        return const Left(UnknownFailure());
      }
    } else {
      return const Left(NetworkFailure());
    }
  }
}
