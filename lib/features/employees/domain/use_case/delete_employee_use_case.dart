import 'package:dartz/dartz.dart';
import 'package:donation_management_system/core/network/errors/failure.dart';
import 'package:donation_management_system/features/employees/domain/repo/employees_repo.dart';

class DeleteEmployeeUseCase {
  final EmployeesRepo repository;

  DeleteEmployeeUseCase({required this.repository});

  Future<Either<Failure, void>> call(int id) {
    return repository.deleteEmployee(id);
  }
}
