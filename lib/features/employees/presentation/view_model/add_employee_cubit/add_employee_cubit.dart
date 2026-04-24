import 'package:donation_management_system/features/employees/domain/entity/add_employee_params.dart';
import 'package:donation_management_system/features/employees/domain/use_case/add_employee_use_case.dart';
import 'package:donation_management_system/features/employees/domain/use_case/update_employee_use_case.dart';
import 'package:donation_management_system/features/employees/presentation/view_model/add_employee_cubit/add_employee_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddEmployeeCubit extends Cubit<AddEmployeeState> {
  final AddEmployeeUseCase addEmployeeUseCase;
  final UpdateEmployeeUseCase updateEmployeeUseCase;

  AddEmployeeCubit({
    required this.addEmployeeUseCase,
    required this.updateEmployeeUseCase,
  }) : super(AddEmployeeInitial());

  Future<void> addEmployee(AddEmployeeParams params) async {
    emit(AddEmployeeLoading());
    final result = await addEmployeeUseCase(params);
    result.fold(
      (failure) => emit(AddEmployeeError(message: failure.message)),
      (_) => emit(AddEmployeeSuccess()),
    );
  }

  Future<void> updateEmployee(int id, AddEmployeeParams params) async {
    emit(AddEmployeeLoading());
    final result = await updateEmployeeUseCase(id, params);
    result.fold(
      (failure) => emit(AddEmployeeError(message: failure.message)),
      (_) => emit(AddEmployeeSuccess()),
    );
  }
}
