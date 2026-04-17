import 'package:donation_management_system/features/donors/domain/use_case/delete_donor_use_case.dart';
import 'package:donation_management_system/features/donors/domain/use_case/update_donor_use_case.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:donation_management_system/features/donors/domain/use_case/register_donor_use_case.dart';
import 'add_donor_state.dart';

class AddDonorCubit extends Cubit<AddDonorState> {
  final RegisterDonorUseCase registerDonorUseCase;
  final UpdateDonorUseCase updateDonorUseCase;
  final DeleteDonorUseCase deleteDonorUseCase;

  AddDonorCubit({
    required this.registerDonorUseCase,
    required this.updateDonorUseCase,
    required this.deleteDonorUseCase,
  }) : super(AddDonorInitial());

  Future<void> registerDonor({
    required String name,
    required String email,
    required String phone,
    required String address,
    required String type,
  }) async {
    emit(AddDonorLoading());
    final result = await registerDonorUseCase(
      name: name,
      email: email,
      phone: phone,
      address: address,
      type: type,
    );

    result.fold(
      (failure) => emit(AddDonorError(message: failure.message)),
      (_) => emit(AddDonorSuccess()),
    );
  }

  Future<void> updateDonor({
    required int id,
    required String name,
    required String email,
    required String phone,
    required String address,
    required String type,
  }) async {
    emit(AddDonorLoading());
    final result = await updateDonorUseCase(
      id: id,
      name: name,
      email: email,
      phone: phone,
      address: address,
      type: type,
    );

    result.fold(
      (failure) => emit(AddDonorError(message: failure.message)),
      (_) => emit(UpdateDonorSuccess()),
    );
  }

  Future<void> deleteDonor(int id) async {
    emit(AddDonorLoading());
    final result = await deleteDonorUseCase(id);

    result.fold(
      (failure) => emit(AddDonorError(message: failure.message)),
      (_) => emit(DeleteDonorSuccess()),
    );
  }
}
