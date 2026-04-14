import 'package:donation_management_system/core/utils/use_case.dart';
import 'package:donation_management_system/features/dashboard/domain/use_case/get_last_distributions_use_case.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'last_distributions_state.dart';

class LastDistributionsCubit extends Cubit<LastDistributionsState> {
  final GetLastDistributionsUseCase getLastDistributionsUseCase;

  LastDistributionsCubit({required this.getLastDistributionsUseCase})
      : super(LastDistributionsInitial());

  Future<void> getLastDistributions() async {
    emit(LastDistributionsLoading());
    final result = await getLastDistributionsUseCase(NoParams());
    result.fold(
      (failure) => emit(LastDistributionsError(failure.message)),
      (distributions) => emit(LastDistributionsLoaded(distributions)),
    );
  }
}
