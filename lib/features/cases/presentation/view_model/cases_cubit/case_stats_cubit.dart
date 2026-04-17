import 'package:donation_management_system/core/utils/use_case.dart';
import 'package:donation_management_system/features/cases/domain/entity/case_kpis_entity.dart';
import 'package:donation_management_system/features/cases/domain/use_case/get_case_kpis_use_case.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'case_stats_state.dart';

class CaseStatsCubit extends Cubit<CaseStatsState> {
  final GetCaseKpisUseCase getCaseKpisUseCase;

  CaseStatsCubit({required this.getCaseKpisUseCase}) : super(CaseStatsInitial());

  Future<void> getCaseKpis() async {
    emit(CaseStatsLoading());
    final result = await getCaseKpisUseCase(NoParams());
    result.fold(
      (failure) => emit(CaseStatsError(message: failure.message)),
      (kpis) => emit(CaseStatsLoaded(kpis: kpis)),
    );
  }
}
