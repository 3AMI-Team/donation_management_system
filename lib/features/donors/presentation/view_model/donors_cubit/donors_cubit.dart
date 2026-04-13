import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:donation_management_system/features/donors/domain/use_case/get_donors_use_case.dart';
import 'donors_state.dart';

class DonorsCubit extends Cubit<DonorsState> {
  final GetDonorsUseCase getDonorsUseCase;

  DonorsCubit({required this.getDonorsUseCase}) : super(DonorsInitial());

  Future<void> getDonors({int page = 1, int pageSize = 10}) async {
    emit(DonorsLoading());

    final result = await getDonorsUseCase(
      DonorsParams(page: page, pageSize: pageSize),
    );

    result.fold(
      (failure) => emit(DonorsError(message: failure.message)),
      (donorsResponse) => emit(DonorsLoaded(donorsResponse: donorsResponse)),
    );
  }
}
