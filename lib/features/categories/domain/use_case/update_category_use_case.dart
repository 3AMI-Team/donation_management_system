import 'package:dartz/dartz.dart';
import 'package:donation_management_system/core/network/errors/failure.dart';
import 'package:donation_management_system/core/utils/use_case.dart';
import 'package:donation_management_system/features/categories/domain/repo/categories_repo.dart';

class UpdateCategoryUseCase implements UseCase<Unit, UpdateCategoryParams> {
  final CategoriesRepo repository;

  UpdateCategoryUseCase({required this.repository});

  @override
  Future<Either<Failure, Unit>> call(UpdateCategoryParams params) {
    return repository.updateCategory(params.id, params.categoryData);
  }
}

class UpdateCategoryParams {
  final int id;
  final Map<String, dynamic> categoryData;

  UpdateCategoryParams({required this.id, required this.categoryData});
}
