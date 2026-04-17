import 'package:donation_management_system/core/utils/use_case.dart';
import 'package:donation_management_system/features/auth/data/data_source/user_local_data_source.dart';
import 'package:donation_management_system/features/categories/domain/use_case/get_categories_use_case.dart';
import 'package:donation_management_system/features/donations/domain/use_case/register_donation_use_case.dart';
import 'package:donation_management_system/features/donors/domain/use_case/get_donors_use_case.dart';
import 'package:donation_management_system/features/donations/presentation/view_model/record_donation_cubit/record_donation_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:donation_management_system/features/donors/domain/entity/donor_entity.dart';
import 'package:donation_management_system/features/categories/domain/entity/category_entity.dart';

class RecordDonationCubit extends Cubit<RecordDonationState> {
  final GetDonorsUseCase getDonorsUseCase;
  final GetCategoriesUseCase getCategoriesUseCase;
  final RegisterDonationUseCase registerDonationUseCase;
  final UserLocalDataSource userLocalDataSource;

  RecordDonationCubit({
    required this.getDonorsUseCase,
    required this.getCategoriesUseCase,
    required this.registerDonationUseCase,
    required this.userLocalDataSource,
  }) : super(const RecordDonationState());

  Future<void> initForm() async {
    emit(state.copyWith(status: RecordDonationStatus.loading));

    final donorsResult = await getDonorsUseCase(const DonorsParams(page: 1, pageSize: 100));
    final categoriesResult = await getCategoriesUseCase(NoParams());

    donorsResult.fold(
      (failure) => emit(state.copyWith(status: RecordDonationStatus.error, errorMessage: failure.message)),
      (donorsResponse) {
        categoriesResult.fold(
          (failure) => emit(state.copyWith(status: RecordDonationStatus.error, errorMessage: failure.message)),
          (categories) {
            emit(state.copyWith(
              status: RecordDonationStatus.initial,
              donors: donorsResponse.donors,
              categories: categories,
            ));
          },
        );
      },
    );
  }

  void selectDonor(DonorEntity donor) {
    emit(state.copyWith(selectedDonor: donor));
  }

  void selectCategory(CategoryEntity category) {
    emit(state.copyWith(selectedCategory: category));
  }

  Future<void> submitDonation({
    required double amount,
    required String description,
  }) async {
    if (state.selectedDonor == null || state.selectedCategory == null) {
      emit(state.copyWith(errorMessage: 'Please select both a donor and a category'));
      return;
    }

    emit(state.copyWith(isSubmitting: true));

    final supervisorId = await userLocalDataSource.getUserId() ?? 1; // Fallback to 1 as placeholder
    final now = DateTime.now().toIso8601String();

    final result = await registerDonationUseCase(RegisterDonationParams(
      amount: amount,
      description: description,
      status: 'Completed',
      date: now,
      donorId: state.selectedDonor!.id,
      categoryId: state.selectedCategory!.id,
      supervisorId: supervisorId,
    ));

    result.fold(
      (failure) => emit(state.copyWith(isSubmitting: false, errorMessage: failure.message)),
      (_) => emit(state.copyWith(isSubmitting: false, status: RecordDonationStatus.success)),
    );
  }

  void resetStatus() {
    emit(state.copyWith(status: RecordDonationStatus.initial, errorMessage: null));
  }
}
