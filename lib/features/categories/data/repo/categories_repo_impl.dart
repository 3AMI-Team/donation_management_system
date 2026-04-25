import 'package:dartz/dartz.dart';
import 'package:donation_management_system/core/network/errors/exceptions.dart';
import 'package:donation_management_system/core/network/errors/failure.dart';
import 'package:donation_management_system/core/network/network_info.dart';
import 'package:donation_management_system/features/categories/data/data_source/categories_remote_data_source.dart';
import 'package:donation_management_system/features/categories/domain/entity/category_entity.dart';
import 'package:donation_management_system/features/categories/domain/repo/categories_repo.dart';

class CategoriesRepoImpl implements CategoriesRepo {
  final CategoriesRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  CategoriesRepoImpl({
    required this.remoteDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, List<CategoryEntity>>> getCategories() async {
    if (await networkInfo.isConnected) {
      try {
        final remoteCategories = await remoteDataSource.getCategories();
        return Right(remoteCategories);
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
  Future<Either<Failure, Unit>> addCategory(Map<String, dynamic> categoryData) async {
    if (await networkInfo.isConnected) {
      try {
        await remoteDataSource.addCategory(categoryData);
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
  Future<Either<Failure, Unit>> updateCategory(int id, Map<String, dynamic> categoryData) async {
    if (await networkInfo.isConnected) {
      try {
        await remoteDataSource.updateCategory(id, categoryData);
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
  Future<Either<Failure, Unit>> deleteCategory(int id) async {
    if (await networkInfo.isConnected) {
      try {
        await remoteDataSource.deleteCategory(id);
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
