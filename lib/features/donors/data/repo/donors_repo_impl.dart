import 'package:dartz/dartz.dart';
import 'package:donation_management_system/core/network/errors/exceptions.dart';
import 'package:donation_management_system/core/network/errors/failure.dart';
import 'package:donation_management_system/core/network/network_info.dart';
import 'package:donation_management_system/features/donors/data/data_source/donors_remote_data_source.dart';
import 'package:donation_management_system/features/donors/domain/entity/donors_response_entity.dart';
import 'package:donation_management_system/features/donors/domain/entity/donor_kpis_entity.dart';
import 'package:donation_management_system/features/donors/domain/repo/donors_repo.dart';

class DonorsRepoImpl implements DonorsRepo {
  final DonorsRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  DonorsRepoImpl({
    required this.remoteDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, DonorsResponseEntity>> getDonors({
    required int page,
    required int pageSize,
  }) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteDonors = await remoteDataSource.getDonors(
          page: page,
          pageSize: pageSize,
        );
        return Right(remoteDonors);
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
  Future<Either<Failure, DonorKpisEntity>> getDonorKpis() async {
    if (await networkInfo.isConnected) {
      try {
        final remoteKpis = await remoteDataSource.getDonorKpis();
        return Right(remoteKpis);
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
  Future<Either<Failure, void>> registerDonor({
    required String name,
    required String email,
    required String phone,
    required String address,
    required String type,
  }) async {
    if (await networkInfo.isConnected) {
      try {
        await remoteDataSource.registerDonor(
          name: name,
          email: email,
          phone: phone,
          address: address,
          type: type,
        );
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

  @override
  Future<Either<Failure, void>> updateDonor({
    required int id,
    required String name,
    required String email,
    required String phone,
    required String address,
    required String type,
  }) async {
    if (await networkInfo.isConnected) {
      try {
        await remoteDataSource.updateDonor(
          id: id,
          name: name,
          email: email,
          phone: phone,
          address: address,
          type: type,
        );
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

  @override
  Future<Either<Failure, void>> deleteDonor(int id) async {
    if (await networkInfo.isConnected) {
      try {
        await remoteDataSource.deleteDonor(id);
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
