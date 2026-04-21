import 'dart:math';
import 'package:donation_management_system/core/utils/use_case.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:donation_management_system/features/cases/domain/use_case/get_cases_use_case.dart';
import 'package:donation_management_system/features/cases/domain/entity/case_entity.dart';
import 'cases_state.dart';

class CasesCubit extends Cubit<CasesState> {
  final GetCasesUseCase getCasesUseCase;
  static const int _pageSize = 10;

  CasesCubit({required this.getCasesUseCase}) : super(CasesInitial());

  Future<void> getCases() async {
    emit(CasesLoading());

    final result = await getCasesUseCase(NoParams());

    result.fold(
      (failure) => emit(CasesError(message: failure.message)),
      (casesResponse) {
        final allCases = casesResponse.items;
        _emitFilteredState(
          master: allCases,
          page: 1,
          query: '',
        );
      },
    );
  }

  void searchCases(String query) {
    if (state is CasesLoaded) {
      final currentState = state as CasesLoaded;
      _emitFilteredState(
        master: currentState.masterCases,
        page: 1, // Reset to page 1 on search
        query: query,
      );
    }
  }

  void changePage(int page) {
    if (state is CasesLoaded) {
      final currentState = state as CasesLoaded;
      if (page < 1 || page > currentState.totalPages) return;

      emit(CasesLoaded(
        masterCases: currentState.masterCases,
        filteredCases: currentState.filteredCases,
        currentPageCases: _getSlicedCases(currentState.filteredCases, page),
        currentPage: page,
        totalPages: currentState.totalPages,
        totalCount: currentState.totalCount,
        searchQuery: currentState.searchQuery,
      ));
    }
  }

  void _emitFilteredState({
    required List<CaseEntity> master,
    required int page,
    required String query,
  }) {
    List<CaseEntity> filtered = master;

    // Apply search query
    if (query.isNotEmpty) {
      final q = query.toLowerCase();
      filtered = filtered.where((c) {
        return c.description.toLowerCase().contains(q) ||
            c.id.toString().contains(q) ||
            c.status.toLowerCase().contains(q);
      }).toList();
    }

    // Pagination math
    final totalCount = filtered.length;
    final totalPages = max(1, (totalCount / _pageSize).ceil());

    emit(CasesLoaded(
      masterCases: master,
      filteredCases: filtered,
      currentPageCases: _getSlicedCases(filtered, page),
      currentPage: page,
      totalPages: totalPages,
      totalCount: totalCount,
      searchQuery: query,
    ));
  }

  List<CaseEntity> _getSlicedCases(List<CaseEntity> source, int page) {
    final start = (page - 1) * _pageSize;
    final end = min(start + _pageSize, source.length);
    if (start >= source.length) return [];
    return source.sublist(start, end);
  }

  void refresh() {
    getCases();
  }

  void onCaseAdded(CaseEntity newCase) {
    if (state is CasesLoaded) {
      final currentState = state as CasesLoaded;
      final newMaster = [newCase, ...currentState.masterCases];
      _emitFilteredState(
        master: newMaster,
        page: 1, // Go to first page to see new case
        query: currentState.searchQuery,
      );
    } else {
      getCases();
    }
  }
}
