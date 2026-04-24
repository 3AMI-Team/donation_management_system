import 'package:dartz/dartz.dart';
import 'package:donation_management_system/core/network/errors/failure.dart';
import 'package:donation_management_system/features/employees/domain/entity/add_employee_params.dart';
import 'package:donation_management_system/features/employees/domain/repo/employees_repo.dart';

class UpdateEmployeeUseCase {
  final EmployeesRepo repository;

  UpdateEmployeeUseCase({required this.repository});

  Future<Either<Failure, void>> call(int id, AddEmployeeParams params) {
    return repository.updateEmployee(id, params);
  }
}
