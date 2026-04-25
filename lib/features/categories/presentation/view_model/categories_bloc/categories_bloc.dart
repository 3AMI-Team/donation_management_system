import 'dart:math';
import 'package:dartz/dartz.dart';
import 'package:donation_management_system/core/network/errors/failure.dart';
import 'package:donation_management_system/core/utils/use_case.dart';
import 'package:donation_management_system/features/categories/domain/entity/category_entity.dart';
import 'package:donation_management_system/features/categories/domain/use_case/add_category_use_case.dart';
import 'package:donation_management_system/features/categories/domain/use_case/delete_category_use_case.dart';
import 'package:donation_management_system/features/categories/domain/use_case/get_categories_use_case.dart';
import 'package:donation_management_system/features/categories/domain/use_case/update_category_use_case.dart';
import 'package:donation_management_system/features/cases/domain/use_case/get_cases_use_case.dart';
import 'package:donation_management_system/features/donations/domain/use_case/get_donations_use_case.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'categories_event.dart';
import 'categories_state.dart';

class CategoriesBloc extends Bloc<CategoriesEvent, CategoriesState> {
  final GetCategoriesUseCase getCategoriesUseCase;
  final AddCategoryUseCase addCategoryUseCase;
  final UpdateCategoryUseCase updateCategoryUseCase;
  final DeleteCategoryUseCase deleteCategoryUseCase;

  // TODO: Move stats to a dedicated backend endpoint to remove cross-feature coupling.
  final GetCasesUseCase getCasesUseCase;
  final GetDonationsUseCase getDonationsUseCase;

  static const int _pageSize = 5;

  CategoriesBloc({
    required this.getCategoriesUseCase,
    required this.getCasesUseCase,
    required this.getDonationsUseCase,
    required this.addCategoryUseCase,
    required this.updateCategoryUseCase,
    required this.deleteCategoryUseCase,
  }) : super(CategoriesInitial()) {
    on<GetCategoriesEvent>(_onGetCategories);
    on<FilterCategoriesEvent>(_onFilterCategories);
    on<ChangePageEvent>(_onChangePage);
    on<AddCategoryEvent>(_onAddCategory);
    on<UpdateCategoryEvent>(_onUpdateCategory);
    on<DeleteCategoryEvent>(_onDeleteCategory);
  }

  // ─── Fetch ────────────────────────────────────────────────────────

  Future<void> _onGetCategories(
      GetCategoriesEvent event, Emitter<CategoriesState> emit) async {
    emit(CategoriesLoading());

    final catResult = await getCategoriesUseCase(NoParams());
    final casesResult = await getCasesUseCase(NoParams());
    final donResult = await getDonationsUseCase(const GetDonationsParams());

    // Early return on first failure — flat, no nesting
    final error = _firstError([catResult, casesResult, donResult]);
    if (error != null) {
      emit(CategoriesError(error));
      return;
    }

    final categories = catResult.getOrElse(() => []);
    final cases = casesResult.fold((_) => <dynamic>[], (r) => r.items);
    final donations = donResult.fold((_) => <dynamic>[], (r) => r.donations);

    final enriched = _enrichWithStats(categories, cases, donations);
    _emitLoaded(emit, master: enriched);
  }

  // ─── Filter & Paginate ────────────────────────────────────────────

  void _onFilterCategories(
      FilterCategoriesEvent event, Emitter<CategoriesState> emit) {
    if (state is! CategoriesLoaded) return;
    final s = state as CategoriesLoaded;
    _emitLoaded(
      emit,
      master: s.masterCategories,
      filter: event.filter ?? s.selectedFilter,
      query: event.query ?? s.searchQuery,
    );
  }

  void _onChangePage(ChangePageEvent event, Emitter<CategoriesState> emit) {
    if (state is! CategoriesLoaded) return;
    final s = state as CategoriesLoaded;
    if (event.page < 1 || event.page > s.totalPages) return;
    emit(s.copyWith(
      currentPageCategories: _paginate(s.filteredCategories, event.page),
      currentPage: event.page,
    ));
  }

  // ─── CRUD Actions ─────────────────────────────────────────────────

  Future<void> _onAddCategory(
      AddCategoryEvent event, Emitter<CategoriesState> emit) async {
    await _handleAction(
      emit: emit,
      action: () => addCategoryUseCase({
        'type': event.type,
        'description': event.description,
      }),
      successMessage: 'Category added successfully!',
    );
  }

  Future<void> _onUpdateCategory(
      UpdateCategoryEvent event, Emitter<CategoriesState> emit) async {
    await _handleAction(
      emit: emit,
      action: () => updateCategoryUseCase(UpdateCategoryParams(
        id: event.id,
        categoryData: {'type': event.type, 'description': event.description},
      )),
      successMessage: 'Category updated successfully!',
    );
  }

  Future<void> _onDeleteCategory(
      DeleteCategoryEvent event, Emitter<CategoriesState> emit) async {
    await _handleAction(
      emit: emit,
      action: () => deleteCategoryUseCase(event.id),
      successMessage: 'Category deleted successfully!',
    );
  }

  // ─── Private Helpers ──────────────────────────────────────────────

  /// Generic handler for all CRUD actions — eliminates repeated boilerplate.
  Future<void> _handleAction({
    required Emitter<CategoriesState> emit,
    required Future<Either<Failure, dynamic>> Function() action,
    required String successMessage,
  }) async {
    if (state is! CategoriesLoaded) return;
    final s = state as CategoriesLoaded;

    emit(s.toActionLoading());

    final result = await action();
    result.fold(
      (failure) => emit(s.toActionError(failure.message)),
      (_) {
        emit(s.toActionSuccess(successMessage));
        add(GetCategoriesEvent());
      },
    );
  }

  /// Returns the first error message from a list of Either results.
  String? _firstError(List<Either<Failure, dynamic>> results) {
    for (final r in results) {
      final msg = r.fold((f) => f.message, (_) => null);
      if (msg != null) return msg;
    }
    return null;
  }

  /// Enriches categories with case/donation stats.
  List<CategoryEntity> _enrichWithStats(
    List<CategoryEntity> categories,
    List<dynamic> cases,
    List<dynamic> donations,
  ) {
    return categories.map((cat) {
      final caseCount = cases.where((c) => c.categoryId == cat.id).length;
      final donationTotal = donations
          .where((d) => d.categoryName == cat.type)
          .fold<double>(0, (sum, d) => sum + d.amount);
      return cat.copyWith(totalCases: caseCount, totalDonations: donationTotal);
    }).toList();
  }

  /// Emits a [CategoriesLoaded] with filtering & pagination applied.
  void _emitLoaded(
    Emitter<CategoriesState> emit, {
    required List<CategoryEntity> master,
    int page = 1,
    String filter = 'All',
    String query = '',
  }) {
    var filtered = master;
    if (query.isNotEmpty) {
      final q = query.toLowerCase();
      filtered = filtered
          .where((c) =>
              c.type.toLowerCase().contains(q) ||
              c.description.toLowerCase().contains(q))
          .toList();
    }
    final total = filtered.length;
    final pages = max(1, (total / _pageSize).ceil());

    emit(CategoriesLoaded(
      masterCategories: master,
      filteredCategories: filtered,
      currentPageCategories: _paginate(filtered, page),
      currentPage: page,
      totalPages: pages,
      totalCount: total,
      selectedFilter: filter,
      searchQuery: query,
    ));
  }

  List<CategoryEntity> _paginate(List<CategoryEntity> source, int page) {
    final start = (page - 1) * _pageSize;
    final end = min(start + _pageSize, source.length);
    return start >= source.length ? [] : source.sublist(start, end);
  }
}
