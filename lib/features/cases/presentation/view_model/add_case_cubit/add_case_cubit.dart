import 'package:donation_management_system/features/cases/domain/entity/add_case_params.dart';
import 'package:donation_management_system/features/cases/domain/use_case/add_case_use_case.dart';
import 'package:donation_management_system/features/cases/domain/use_case/update_case_use_case.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'add_case_state.dart';

class AddCaseCubit extends Cubit<AddCaseState> {
  final AddCaseUseCase addCaseUseCase;
  final UpdateCaseUseCase updateCaseUseCase;

  AddCaseCubit({
    required this.addCaseUseCase,
    required this.updateCaseUseCase,
  }) : super(AddCaseInitial());

  Future<void> addCase(AddCaseParams params) async {
    emit(AddCaseLoading());
    final result = await addCaseUseCase(params);
    result.fold(
      (failure) => emit(AddCaseError(message: failure.message)),
      (_) => emit(AddCaseSuccess()),
    );
  }

  Future<void> updateCase(int id, AddCaseParams params) async {
    emit(AddCaseLoading());
    final result = await updateCaseUseCase(UpdateCaseParams(id: id, params: params));
    result.fold(
      (failure) => emit(AddCaseError(message: failure.message)),
      (_) => emit(AddCaseSuccess()),
    );
  }
}
