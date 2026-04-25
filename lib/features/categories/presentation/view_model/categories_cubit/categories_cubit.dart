import 'dart:math';
import 'package:donation_management_system/core/utils/use_case.dart';
import 'package:donation_management_system/features/categories/domain/use_case/get_categories_use_case.dart';
import 'package:donation_management_system/features/cases/domain/use_case/get_cases_use_case.dart';
import 'package:donation_management_system/features/donations/domain/use_case/get_donations_use_case.dart';
import 'package:donation_management_system/features/categories/domain/use_case/delete_category_use_case.dart';
import 'package:donation_management_system/features/categories/presentation/view_model/categories_cubit/category_ui_model.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'categories_state.dart';

class CategoriesCubit extends Cubit<CategoriesState> {
  final GetCategoriesUseCase getCategoriesUseCase;
  final GetCasesUseCase getCasesUseCase;
  final GetDonationsUseCase getDonationsUseCase;
  final DeleteCategoryUseCase deleteCategoryUseCase;
  static const int _pageSize = 5;

  CategoriesCubit({
    required this.getCategoriesUseCase,
    required this.getCasesUseCase,
    required this.getDonationsUseCase,
    required this.deleteCategoryUseCase,
  }) : super(CategoriesInitial());

  Future<void> deleteCategory(int id) async {
    final result = await deleteCategoryUseCase(id);

    result.fold(
      (failure) => emit(CategoriesError(message: failure.message)),
      (_) => getCategories(),
    );
  }

  Future<void> getCategories() async {
    emit(CategoriesLoading());

    final categoriesResult = await getCategoriesUseCase(NoParams());
    final casesResult = await getCasesUseCase(NoParams());
    final donationsResult =
        await getDonationsUseCase(const GetDonationsParams());

    categoriesResult.fold(
      (failure) => emit(CategoriesError(message: failure.message)),
      (categories) {
        casesResult.fold(
          (failure) => emit(CategoriesError(message: failure.message)),
          (casesResponse) {
            donationsResult.fold(
              (failure) => emit(CategoriesError(message: failure.message)),
              (donationsResponse) {
                final List<CategoryUIModel> categoryWithStats =
                    categories.map((category) {
                  final categoryCases = casesResponse.items
                      .where((c) => c.categoryId == category.id)
                      .toList();
                  final categoryDonations = donationsResponse.donations
                      .where((d) => d.categoryName == category.type)
                      .toList();

                  final totalDonationsAmount = categoryDonations.fold<double>(
                      0, (sum, d) => sum + d.amount);

                  return CategoryUIModel(
                    category: category,
                    totalCases: categoryCases.length,
                    totalDonations: totalDonationsAmount,
                  );
                }).toList();

                _emitFilteredState(
                  master: categoryWithStats,
                  page: 1,
                  filter: 'All',
                  query: '',
                );
              },
            );
          },
        );
      },
    );
  }

  void filterCategories({String? query, String? filter}) {
    if (state is CategoriesLoaded) {
      final currentState = state as CategoriesLoaded;
      _emitFilteredState(
        master: currentState.masterCategories,
        page: 1,
        filter: filter ?? currentState.selectedFilter ?? 'All',
        query: query ?? currentState.searchQuery,
      );
    }
  }

  void changePage(int page) {
    if (state is CategoriesLoaded) {
      final currentState = state as CategoriesLoaded;
      if (page < 1 || page > currentState.totalPages) return;

      emit(CategoriesLoaded(
        masterCategories: currentState.masterCategories,
        filteredCategories: currentState.filteredCategories,
        currentPageCategories:
            _getSlicedCategories(currentState.filteredCategories, page),
        currentPage: page,
        totalPages: currentState.totalPages,
        totalCount: currentState.totalCount,
        selectedFilter: currentState.selectedFilter,
        searchQuery: currentState.searchQuery,
      ));
    }
  }

  void _emitFilteredState({
    required List<CategoryUIModel> master,
    required int page,
    required String filter,
    required String query,
  }) {
    List<CategoryUIModel> filtered = master;

    // Apply search query
    if (query.isNotEmpty) {
      final q = query.toLowerCase();
      filtered = filtered.where((c) {
        return c.category.type.toLowerCase().contains(q) ||
            c.category.description.toLowerCase().contains(q);
      }).toList();
    }

    final totalCount = filtered.length;
    final totalPages = max(1, (totalCount / _pageSize).ceil());

    emit(CategoriesLoaded(
      masterCategories: master,
      filteredCategories: filtered,
      currentPageCategories: _getSlicedCategories(filtered, page),
      currentPage: page,
      totalPages: totalPages,
      totalCount: totalCount,
      selectedFilter: filter,
      searchQuery: query,
    ));
  }

  List<CategoryUIModel> _getSlicedCategories(
      List<CategoryUIModel> source, int page) {
    final start = (page - 1) * _pageSize;
    final end = min(start + _pageSize, source.length);
    if (start >= source.length) return [];
    return source.sublist(start, end);
  }
}
