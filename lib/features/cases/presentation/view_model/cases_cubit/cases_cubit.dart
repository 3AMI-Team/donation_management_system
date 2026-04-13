import 'package:donation_management_system/core/utils/use_case.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:donation_management_system/features/cases/domain/use_case/get_cases_use_case.dart';
import 'cases_state.dart';

class CasesCubit extends Cubit<CasesState> {
  final GetCasesUseCase getCasesUseCase;

  CasesCubit({required this.getCasesUseCase}) : super(CasesInitial());

  Future<void> getCases() async {
    emit(CasesLoading());

    final result = await getCasesUseCase(NoParams());

    result.fold(
      (failure) => emit(CasesError(message: failure.message)),
      (casesResponse) => emit(CasesLoaded(casesResponse: casesResponse)),
    );
  }
}
