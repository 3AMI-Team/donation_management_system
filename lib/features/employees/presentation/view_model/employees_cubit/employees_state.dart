import 'package:donation_management_system/features/employees/domain/entity/employee_entity.dart';

sealed class EmployeesState {}

final class EmployeesInitial extends EmployeesState {}

final class EmployeesLoading extends EmployeesState {}

final class EmployeesLoaded extends EmployeesState {
  final List<EmployeeEntity> masterEmployees;
  final List<EmployeeEntity> filteredEmployees;
  final List<EmployeeEntity> currentPageEmployees;
  final int currentPage;
  final int totalPages;
  final int totalCount;
  final String selectedRole;
  final String searchQuery;

  EmployeesLoaded({
    required this.masterEmployees,
    required this.filteredEmployees,
    required this.currentPageEmployees,
    required this.currentPage,
    required this.totalPages,
    required this.totalCount,
    required this.selectedRole,
    this.searchQuery = '',
  });
}

final class EmployeesError extends EmployeesState {
  final String message;

  EmployeesError({required this.message});
}
