import 'package:dartz/dartz.dart';
import 'package:donation_management_system/core/network/errors/failure.dart';
import 'package:donation_management_system/features/categories/domain/entity/category_entity.dart';

abstract class CategoriesRepo {
  Future<Either<Failure, List<CategoryEntity>>> getCategories();
  Future<Either<Failure, Unit>> addCategory(Map<String, dynamic> categoryData);
  Future<Either<Failure, Unit>> updateCategory(int id, Map<String, dynamic> categoryData);
  Future<Either<Failure, Unit>> deleteCategory(int id);
}
