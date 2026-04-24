import 'package:donation_management_system/features/cases/domain/entity/case_entity.dart';
import 'package:donation_management_system/features/donations/domain/entity/donation_entity.dart';
import 'package:donation_management_system/features/employees/domain/entity/employee_entity.dart';
import 'package:equatable/equatable.dart';

abstract class AddDistributionState extends Equatable {
  final List<CaseEntity> cases;
  final List<Donation> donations;
  final List<EmployeeEntity> employees;

  const AddDistributionState({
    this.cases = const [],
    this.donations = const [],
    this.employees = const [],
  });

  @override
  List<Object?> get props => [cases, donations, employees];
}

class AddDistributionInitial extends AddDistributionState {
  const AddDistributionInitial() : super();
}

class DependenciesLoading extends AddDistributionState {
  const DependenciesLoading() : super();
}

class DependenciesLoaded extends AddDistributionState {
  const DependenciesLoaded({
    required super.cases,
    required super.donations,
    required super.employees,
  });
}

class AddDistributionLoading extends AddDistributionState {
  const AddDistributionLoading({
    required super.cases,
    required super.donations,
    required super.employees,
  });
}

class AddDistributionSuccess extends AddDistributionState {
  const AddDistributionSuccess({
    required super.cases,
    required super.donations,
    required super.employees,
  });
}

class AddDistributionError extends AddDistributionState {
  final String message;

  const AddDistributionError({
    required this.message,
    required super.cases,
    required super.donations,
    required super.employees,
  });

  @override
  List<Object?> get props => [message, ...super.props];
}

class DependenciesError extends AddDistributionState {
  final String message;

  const DependenciesError({required this.message}) : super();

  @override
  List<Object?> get props => [message];
}
