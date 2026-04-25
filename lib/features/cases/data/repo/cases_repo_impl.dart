import 'package:dartz/dartz.dart';
import 'package:donation_management_system/core/network/errors/exceptions.dart';
import 'package:donation_management_system/core/network/errors/failure.dart';
import 'package:donation_management_system/core/network/network_info.dart';
import 'package:donation_management_system/features/cases/data/data_source/cases_remote_data_source.dart';
import 'package:donation_management_system/features/cases/domain/entity/cases_response_entity.dart';
import 'package:donation_management_system/features/cases/domain/entity/case_kpis_entity.dart';
import 'package:donation_management_system/features/cases/domain/entity/add_case_params.dart';
import 'package:donation_management_system/features/cases/domain/repo/cases_repo.dart';

class CasesRepoImpl implements CasesRepo {
  final CasesRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  CasesRepoImpl({
    required this.remoteDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, CasesResponseEntity>> getCases() async {
    if (await networkInfo.isConnected) {
      try {
        final remoteCases = await remoteDataSource.getCases();
        return Right(remoteCases);
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
  Future<Either<Failure, CaseKpisEntity>> getCaseKpis() async {
    if (await networkInfo.isConnected) {
      try {
        final remoteKpis = await remoteDataSource.getCaseKpis();
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
  Future<Either<Failure, Unit>> addCase(AddCaseParams params) async {
    if (await networkInfo.isConnected) {
      try {
        await remoteDataSource.addCase(params);
        return const Right(unit);
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
  Future<Either<Failure, Unit>> updateCase(int id, AddCaseParams params) async {
    if (await networkInfo.isConnected) {
      try {
        await remoteDataSource.updateCase(id, params);
        return const Right(unit);
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
