import 'dart:math';
import 'package:donation_management_system/features/donors/domain/use_case/get_donors_use_case.dart';
import 'package:donation_management_system/features/donors/presentation/view_model/donors_cubit/donors_state.dart';
import 'package:donation_management_system/features/donors/domain/entity/donor_entity.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DonorsCubit extends Cubit<DonorsState> {
  final GetDonorsUseCase getDonorsUseCase;
  static const int _pageSize = 10;

  DonorsCubit({required this.getDonorsUseCase}) : super(DonorsInitial());

  Future<void> getDonors() async {
    emit(DonorsLoading());

    // Fecth with a large pageSize to handle local search/pagination for now
    // Similar to donations pattern
    final failureOrDonors = await getDonorsUseCase(
      const DonorsParams(page: 1, pageSize: 1000),
    );

    failureOrDonors.fold(
      (failure) => emit(DonorsError(message: failure.message)),
      (response) {
        final allDonors = response.donors;
        _emitFilteredState(
          master: allDonors,
          page: 1,
          query: '',
        );
      },
    );
  }

  void searchDonors(String query) {
    if (state is DonorsLoaded) {
      final currentState = state as DonorsLoaded;
      _emitFilteredState(
        master: currentState.masterDonors,
        page: 1, // Reset to page 1 on search
        query: query,
      );
    }
  }

  void changePage(int page) {
    if (state is DonorsLoaded) {
      final currentState = state as DonorsLoaded;
      if (page < 1 || page > currentState.totalPages) return;

      emit(DonorsLoaded(
        masterDonors: currentState.masterDonors,
        filteredDonors: currentState.filteredDonors,
        currentPageDonors:
            _getSlicedDonors(currentState.filteredDonors, page),
        currentPage: page,
        totalPages: currentState.totalPages,
        totalCount: currentState.totalCount,
        searchQuery: currentState.searchQuery,
      ));
    }
  }

  void _emitFilteredState({
    required List<DonorEntity> master,
    required int page,
    required String query,
  }) {
    List<DonorEntity> filtered = master;

    // Apply search query
    if (query.isNotEmpty) {
      final q = query.toLowerCase();
      filtered = filtered.where((d) {
        return d.name.toLowerCase().contains(q) ||
            d.email.toLowerCase().contains(q) ||
            d.phone.contains(q) ||
            d.id.toString().contains(q);
      }).toList();
    }

    // Pagination math
    final totalCount = filtered.length;
    final totalPages = max(1, (totalCount / _pageSize).ceil());

    emit(DonorsLoaded(
      masterDonors: master,
      filteredDonors: filtered,
      currentPageDonors: _getSlicedDonors(filtered, page),
      currentPage: page,
      totalPages: totalPages,
      totalCount: totalCount,
      searchQuery: query,
    ));
  }

  List<DonorEntity> _getSlicedDonors(List<DonorEntity> source, int page) {
    final start = (page - 1) * _pageSize;
    final end = min(start + _pageSize, source.length);
    if (start >= source.length) return [];
    return source.sublist(start, end);
  }

  void refresh() {
    getDonors();
  }

  void onDonorDeleted(int id) {
    if (state is DonorsLoaded) {
      final currentState = state as DonorsLoaded;
      final newMaster =
          currentState.masterDonors.where((d) => d.id != id).toList();
      _emitFilteredState(
        master: newMaster,
        page: currentState.currentPage,
        query: currentState.searchQuery,
      );
    }
  }

  void onDonorUpdated(DonorEntity updatedDonor) {
    if (state is DonorsLoaded) {
      final currentState = state as DonorsLoaded;
      final newMaster = currentState.masterDonors
          .map((d) => d.id == updatedDonor.id ? updatedDonor : d)
          .toList();
      _emitFilteredState(
        master: newMaster,
        page: currentState.currentPage,
        query: currentState.searchQuery,
      );
    }
  }

  void onDonorAdded(DonorEntity newDonor) {
    if (state is DonorsLoaded) {
      final currentState = state as DonorsLoaded;
      final newMaster = [newDonor, ...currentState.masterDonors];
      _emitFilteredState(
        master: newMaster,
        page: 1, // Go to first page to see new donor
        query: currentState.searchQuery,
      );
    } else {
      getDonors(); // If not loaded, just fetch
    }
  }
}
