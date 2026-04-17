import 'package:donation_management_system/core/utils/use_case.dart';
import 'package:donation_management_system/features/donations/domain/entity/donation_kpis_entity.dart';
import 'package:donation_management_system/features/donations/domain/use_case/get_donation_kpis_use_case.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'donation_stats_state.dart';

class DonationStatsCubit extends Cubit<DonationStatsState> {
  final GetDonationKpisUseCase getDonationKpisUseCase;

  DonationStatsCubit({required this.getDonationKpisUseCase}) : super(DonationStatsInitial());

  Future<void> getDonationKpis() async {
    emit(DonationStatsLoading());
    final result = await getDonationKpisUseCase(NoParams());
    result.fold(
      (failure) => emit(DonationStatsError(message: failure.message)),
      (kpis) => emit(DonationStatsLoaded(kpis: kpis)),
    );
  }
}
