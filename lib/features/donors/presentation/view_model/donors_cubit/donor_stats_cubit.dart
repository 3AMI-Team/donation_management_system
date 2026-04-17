import 'package:donation_management_system/core/utils/use_case.dart';
import 'package:donation_management_system/features/donors/domain/entity/donor_kpis_entity.dart';
import 'package:donation_management_system/features/donors/domain/use_case/get_donor_kpis_use_case.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'donor_stats_state.dart';

class DonorStatsCubit extends Cubit<DonorStatsState> {
  final GetDonorKpisUseCase getDonorKpisUseCase;

  DonorStatsCubit({required this.getDonorKpisUseCase}) : super(DonorStatsInitial());

  Future<void> getDonorKpis() async {
    emit(DonorStatsLoading());
    final result = await getDonorKpisUseCase(NoParams());
    result.fold(
      (failure) => emit(DonorStatsError(message: failure.message)),
      (kpis) => emit(DonorStatsLoaded(kpis: kpis)),
    );
  }
}
