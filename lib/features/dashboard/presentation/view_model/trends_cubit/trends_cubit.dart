import 'package:donation_management_system/core/utils/use_case.dart';
import 'package:donation_management_system/features/dashboard/domain/use_case/get_donation_trends_use_case.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'trends_state.dart';

class TrendsCubit extends Cubit<TrendsState> {
  final GetDonationTrendsUseCase getDonationTrendsUseCase;

  TrendsCubit({required this.getDonationTrendsUseCase}) : super(TrendsInitial());

  Future<void> getTrends() async {
    emit(TrendsLoading());
    final result = await getDonationTrendsUseCase(NoParams());
    result.fold(
      (failure) => emit(TrendsError(failure.message)),
      (trends) => emit(TrendsLoaded(trends)),
    );
  }
}
