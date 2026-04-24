import 'package:dartz/dartz.dart';
import 'package:donation_management_system/core/network/errors/exceptions.dart';
import 'package:donation_management_system/core/network/errors/failure.dart';
import 'package:donation_management_system/core/network/network_info.dart';
import 'package:donation_management_system/features/employees/data/data_source/employees_remote_data_source.dart';
import 'package:donation_management_system/features/employees/domain/entity/add_employee_params.dart';
import 'package:donation_management_system/features/employees/domain/entity/employee_entity.dart';
import 'package:donation_management_system/features/employees/domain/entity/employee_kpis_entity.dart';
import 'package:donation_management_system/features/employees/domain/repo/employees_repo.dart';

class EmployeesRepoImpl implements EmployeesRepo {
  final EmployeesRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  EmployeesRepoImpl({
    required this.remoteDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, void>> addEmployee(AddEmployeeParams params) async {
    if (await networkInfo.isConnected) {
      try {
        await remoteDataSource.addEmployee(params);
        return const Right(null);
      } on ServerException catch (e) {
        return Left(ServerFailure(message: e.message, code: e.statusCode));
      } catch (e) {
        return const Left(UnknownFailure());
      }
    } else {
      return const Left(NetworkFailure());
    }
  }

  @override
  Future<Either<Failure, void>> updateEmployee(
      int id, AddEmployeeParams params) async {
    if (await networkInfo.isConnected) {
      try {
        await remoteDataSource.updateEmployee(id, params);
        return const Right(null);
      } on ServerException catch (e) {
        return Left(ServerFailure(message: e.message, code: e.statusCode));
      } catch (e) {
        return const Left(UnknownFailure());
      }
    } else {
      return const Left(NetworkFailure());
    }
  }

  @override
  Future<Either<Failure, void>> deleteEmployee(int id) async {
    if (await networkInfo.isConnected) {
      try {
        await remoteDataSource.deleteEmployee(id);
        return const Right(null);
      } on ServerException catch (e) {
        return Left(ServerFailure(message: e.message, code: e.statusCode));
      } catch (e) {
        return const Left(UnknownFailure());
      }
    } else {
      return const Left(NetworkFailure());
    }
  }

  @override
  Future<Either<Failure, List<EmployeeEntity>>> getEmployees() async {
    if (await networkInfo.isConnected) {
      try {
        final response = await remoteDataSource.getEmployees();
        return Right(response);
      } on ServerException catch (e) {
        return Left(ServerFailure(message: e.message, code: e.statusCode));
      } catch (e) {
        return const Left(UnknownFailure());
      }
    } else {
      return const Left(NetworkFailure());
    }
  }

  @override
  Future<Either<Failure, EmployeeKpisEntity>> getEmployeeKpis() async {
    if (await networkInfo.isConnected) {
      try {
        final response = await remoteDataSource.getEmployeeKpis();
        return Right(response);
      } on ServerException catch (e) {
        return Left(ServerFailure(message: e.message, code: e.statusCode));
      } catch (e) {
        return const Left(UnknownFailure());
      }
    } else {
      return const Left(NetworkFailure());
    }
  }
}
