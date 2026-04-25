import 'package:dartz/dartz.dart';
import 'package:donation_management_system/core/network/errors/failure.dart';
import 'package:donation_management_system/core/utils/use_case.dart';
import 'package:donation_management_system/features/categories/domain/repo/categories_repo.dart';

class AddCategoryUseCase implements UseCase<Unit, Map<String, dynamic>> {
  final CategoriesRepo repository;

  AddCategoryUseCase({required this.repository});

  @override
  Future<Either<Failure, Unit>> call(Map<String, dynamic> params) {
    return repository.addCategory(params);
  }
}
