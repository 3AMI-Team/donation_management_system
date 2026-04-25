import 'package:dartz/dartz.dart';
import 'package:donation_management_system/core/network/errors/failure.dart';
import 'package:donation_management_system/core/utils/use_case.dart';
import 'package:donation_management_system/features/categories/domain/repo/categories_repo.dart';

class DeleteCategoryUseCase implements UseCase<Unit, int> {
  final CategoriesRepo repository;

  DeleteCategoryUseCase({required this.repository});

  @override
  Future<Either<Failure, Unit>> call(int params) {
    return repository.deleteCategory(params);
  }
}
