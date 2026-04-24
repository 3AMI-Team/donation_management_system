import 'package:donation_management_system/features/distributions/domain/use_case/get_distribution_kpis_use_case.dart';
import 'package:donation_management_system/features/distributions/presentation/view_model/distribution_stats_cubit/distribution_stats_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DistributionStatsCubit extends Cubit<DistributionStatsState> {
  final GetDistributionKpisUseCase getDistributionKpisUseCase;

  DistributionStatsCubit({required this.getDistributionKpisUseCase})
      : super(DistributionStatsInitial());

  Future<void> getDistributionKpis() async {
    emit(DistributionStatsLoading());
    final result = await getDistributionKpisUseCase();
    result.fold(
      (failure) => emit(DistributionStatsError(message: failure.message)),
      (kpis) => emit(DistributionStatsLoaded(kpis: kpis)),
    );
  }
}
