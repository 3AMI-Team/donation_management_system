import 'package:donation_management_system/core/utils/use_case.dart';
import 'package:donation_management_system/features/dashboard/domain/use_case/get_dashboard_kpis_use_case.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'kpis_state.dart';

class KpisCubit extends Cubit<KpisState> {
  final GetDashboardKpisUseCase getDashboardKpisUseCase;

  KpisCubit({required this.getDashboardKpisUseCase}) : super(KpisInitial());

  Future<void> getKpis() async {
    emit(KpisLoading());
    final result = await getDashboardKpisUseCase(NoParams());
    result.fold(
      (failure) => emit(KpisError(failure.message)),
      (kpis) => emit(KpisLoaded(kpis)),
    );
  }
}
