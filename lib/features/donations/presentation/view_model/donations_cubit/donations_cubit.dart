import 'dart:math';
import 'package:donation_management_system/features/donations/domain/entity/donation_entity.dart';
import 'package:donation_management_system/features/donations/domain/use_case/get_donations_use_case.dart';
import 'package:donation_management_system/features/donations/presentation/view_model/donations_cubit/donations_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DonationsCubit extends Cubit<DonationsState> {
  final GetDonationsUseCase getDonationsUseCase;
  static const int _pageSize = 10;

  DonationsCubit({required this.getDonationsUseCase})
      : super(DonationsInitial());

  Future<void> fetchDonations() async {
    emit(DonationsLoading());

    // We fetch EVERYTHING from the server once
    final failureOrDonations = await getDonationsUseCase(const GetDonationsParams());

    failureOrDonations.fold(
      (failure) => emit(DonationsError(message: failure.message)),
      (response) {
        final allDonations = response.donations;
        _emitFilteredState(
          master: allDonations,
          page: 1,
          category: null,
          query: '',
        );
      },
    );
  }

  void filterDonations({String? query, String? category}) {
    if (state is DonationsLoaded) {
      final currentState = state as DonationsLoaded;
      _emitFilteredState(
        master: currentState.masterDonations,
        page: 1, // Reset to page 1 on search/filter change
        category: category ?? currentState.selectedCategory,
        query: query ?? currentState.searchQuery,
      );
    }
  }

  void changePage(int page) {
    if (state is DonationsLoaded) {
      final currentState = state as DonationsLoaded;
      if (page < 1 || page > currentState.totalPages) return;

      emit(DonationsLoaded(
        masterDonations: currentState.masterDonations,
        filteredDonations: currentState.filteredDonations,
        currentPageDonations: _getSlicedDonations(currentState.filteredDonations, page),
        currentPage: page,
        totalPages: currentState.totalPages,
        totalCount: currentState.totalCount,
        selectedCategory: currentState.selectedCategory,
        selectedStatus: currentState.selectedStatus,
        searchQuery: currentState.searchQuery,
      ));
    }
  }

  void _emitFilteredState({
    required List<Donation> master,
    required int page,
    String? category,
    required String query,
  }) {
    // 1. Apply category filter
    List<Donation> filtered = master;
    if (category != null && category != 'All') {
      filtered = filtered.where((d) => d.categoryName == category).toList();
    }

    // 2. Apply search query
    if (query.isNotEmpty) {
      final q = query.toLowerCase();
      filtered = filtered.where((d) {
        return d.donorName.toLowerCase().contains(q) ||
            d.description.toLowerCase().contains(q) ||
            d.id.toString().contains(q);
      }).toList();
    }

    // 3. Pagination math
    final totalCount = filtered.length;
    final totalPages = max(1, (totalCount / _pageSize).ceil());

    emit(DonationsLoaded(
      masterDonations: master,
      filteredDonations: filtered,
      currentPageDonations: _getSlicedDonations(filtered, page),
      currentPage: page,
      totalPages: totalPages,
      totalCount: totalCount,
      selectedCategory: category,
      searchQuery: query,
    ));
  }

  List<Donation> _getSlicedDonations(List<Donation> source, int page) {
    final start = (page - 1) * _pageSize;
    final end = min(start + _pageSize, source.length);
    if (start >= source.length) return [];
    return source.sublist(start, end);
  }

  void refresh() {
    fetchDonations();
  }
}
