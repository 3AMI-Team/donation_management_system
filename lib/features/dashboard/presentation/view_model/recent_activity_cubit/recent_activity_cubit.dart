import 'package:donation_management_system/core/utils/use_case.dart';
import 'package:donation_management_system/features/dashboard/domain/use_case/get_last_donations_use_case.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'recent_activity_state.dart';

class RecentActivityCubit extends Cubit<RecentActivityState> {
  final GetLastDonationsUseCase getLastDonationsUseCase;

  RecentActivityCubit({required this.getLastDonationsUseCase})
      : super(RecentActivityInitial());

  Future<void> getLastDonations() async {
    emit(RecentActivityLoading());
    final result = await getLastDonationsUseCase(NoParams());
    result.fold(
      (failure) => emit(RecentActivityError(failure.message)),
      (donations) => emit(RecentActivityLoaded(donations)),
    );
  }
}
