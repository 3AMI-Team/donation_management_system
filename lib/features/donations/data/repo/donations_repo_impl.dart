import 'package:dartz/dartz.dart';
import 'package:donation_management_system/core/network/errors/exceptions.dart';
import 'package:donation_management_system/core/network/errors/failure.dart';
import 'package:donation_management_system/core/network/network_info.dart';
import 'package:donation_management_system/features/donations/data/data_source/donations_remote_data_source.dart';
import 'package:donation_management_system/features/donations/domain/entity/donations_response_entity.dart';
import 'package:donation_management_system/features/donations/domain/entity/donation_kpis_entity.dart';
import 'package:donation_management_system/features/donations/domain/repo/donations_repo.dart';

class DonationsRepoImpl implements DonationsRepo {
  final DonationsRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  DonationsRepoImpl({
    required this.remoteDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, DonationsResponse>> getDonations({
    String? status,
    String? category,
  }) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteDonations = await remoteDataSource.getDonations(
          status: status,
          category: category,
        );
        return Right(remoteDonations);
      } on ServerException catch (e) {
        return Left(ServerFailure(message: e.message));
      } catch (e) {
        return Left(ServerFailure(message: e.toString()));
      }
    } else {
      return const Left(NetworkFailure(message: 'No Internet Connection'));
    }
  }

  @override
  Future<Either<Failure, Unit>> registerDonation({
    required double amount,
    required String description,
    required String status,
    required String date,
    required int donorId,
    required int categoryId,
    required int supervisorId,
  }) async {
    if (await networkInfo.isConnected) {
      try {
        await remoteDataSource.registerDonation(
          amount: amount,
          description: description,
          status: status,
          date: date,
          donorId: donorId,
          categoryId: categoryId,
          supervisorId: supervisorId,
        );
        return const Right(unit);
      } on ServerException catch (e) {
        return Left(ServerFailure(message: e.message));
      } catch (e) {
        return Left(ServerFailure(message: e.toString()));
      }
    } else {
      return const Left(NetworkFailure(message: 'No Internet Connection'));
    }
  }

  @override
  Future<Either<Failure, DonationKpisEntity>> getDonationKpis() async {
    if (await networkInfo.isConnected) {
      try {
        final remoteKpis = await remoteDataSource.getDonationKpis();
        return Right(remoteKpis);
      } on ServerException catch (e) {
        return Left(ServerFailure(message: e.message));
      } catch (e) {
        return Left(ServerFailure(message: e.toString()));
      }
    } else {
      return const Left(NetworkFailure(message: 'No Internet Connection'));
    }
  }
}
