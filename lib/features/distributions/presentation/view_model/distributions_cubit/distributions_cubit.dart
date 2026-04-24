import 'package:donation_management_system/features/distributions/domain/entity/distribution_entity.dart';
import 'package:donation_management_system/features/distributions/domain/use_case/get_distributions_use_case.dart';
import 'package:donation_management_system/features/distributions/presentation/view_model/distributions_cubit/distributions_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DistributionsCubit extends Cubit<DistributionsState> {
  final GetDistributionsUseCase getDistributionsUseCase;
  static const int _pageSize = 10;

  List<DistributionEntity> _allDistributions = [];

  DistributionsCubit({required this.getDistributionsUseCase})
      : super(DistributionsInitial());

  Future<void> getDistributions() async {
    emit(DistributionsLoading());
    final result = await getDistributionsUseCase();
    result.fold(
      (failure) => emit(DistributionsError(message: failure.message)),
      (distributions) {
        _allDistributions = distributions;
        _emitFilteredState(status: 'All', query: '', page: 1);
      },
    );
  }

  void filterDistributions({String? status, String? query}) {
    if (state is DistributionsLoaded) {
      final currentState = state as DistributionsLoaded;
      _emitFilteredState(
        status: status ?? currentState.selectedStatus,
        query: query ?? currentState.searchQuery,
        page: 1,
      );
    }
  }

  void changePage(int page) {
    if (state is DistributionsLoaded) {
      final currentState = state as DistributionsLoaded;
      if (page < 1 || page > currentState.totalPages) return;

      emit(DistributionsLoaded(
        masterDistributions: currentState.masterDistributions,
        filteredDistributions: currentState.filteredDistributions,
        currentPageDistributions:
            _getSlicedDistributions(currentState.filteredDistributions, page),
        currentPage: page,
        totalPages: currentState.totalPages,
        totalCount: currentState.totalCount,
        selectedStatus: currentState.selectedStatus,
        searchQuery: currentState.searchQuery,
      ));
    }
  }

  void _emitFilteredState(
      {required String status, required String query, required int page}) {
    List<DistributionEntity> filtered = _allDistributions;

    // 1. Apply status filter
    if (status != 'All') {
      filtered = filtered.where((dist) => dist.status == status).toList();
    }

    // 2. Apply search query
    if (query.isNotEmpty) {
      final q = query.toLowerCase();
      filtered = filtered.where((dist) {
        return dist.caseName.toLowerCase().contains(q) ||
            dist.donorName.toLowerCase().contains(q) ||
            dist.handledByEmployeeName.toLowerCase().contains(q) ||
            dist.notes.toLowerCase().contains(q);
      }).toList();
    }

    // 3. Pagination math
    final totalCount = filtered.length;
    final totalPages = (totalCount / _pageSize).ceil().clamp(1, 9999);

    emit(DistributionsLoaded(
      masterDistributions: _allDistributions,
      filteredDistributions: filtered,
      currentPageDistributions: _getSlicedDistributions(filtered, page),
      currentPage: page,
      totalPages: totalPages,
      totalCount: totalCount,
      selectedStatus: status,
      searchQuery: query,
    ));
  }

  List<DistributionEntity> _getSlicedDistributions(
      List<DistributionEntity> source, int page) {
    final start = (page - 1) * _pageSize;
    final end = (start + _pageSize).clamp(0, source.length);
    if (start >= source.length) return [];
    return source.sublist(start, end);
  }
}
