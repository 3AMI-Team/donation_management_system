import 'package:donation_management_system/core/utils/use_case.dart';
import 'package:donation_management_system/features/dashboard/domain/use_case/get_dashboard_kpis_use_case.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'dashboard_state.dart';

class DashboardCubit extends Cubit<DashboardState> {
  final GetDashboardKpisUseCase getDashboardKpisUseCase;

  DashboardCubit(this.getDashboardKpisUseCase) : super(DashboardInitial());

  Future<void> getKpis() async {
    emit(DashboardLoading());
    final result = await getDashboardKpisUseCase(NoParams());
    result.fold(
      (failure) => emit(DashboardError(failure.message)),
      (kpis) => emit(DashboardKpisLoaded(kpis)),
    );
  }
}
