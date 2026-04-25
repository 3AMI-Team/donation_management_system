import 'package:donation_management_system/features/categories/domain/entity/category_entity.dart';
import 'package:equatable/equatable.dart';

abstract class CategoriesState extends Equatable {
  const CategoriesState();
  @override
  List<Object?> get props => [];
}

class CategoriesInitial extends CategoriesState {}

class CategoriesLoading extends CategoriesState {}

class CategoriesLoaded extends CategoriesState {
  final List<CategoryEntity> masterCategories;
  final List<CategoryEntity> filteredCategories;
  final List<CategoryEntity> currentPageCategories;
  final int currentPage;
  final int totalPages;
  final int totalCount;
  final String selectedFilter;
  final String searchQuery;

  const CategoriesLoaded({
    required this.masterCategories,
    required this.filteredCategories,
    required this.currentPageCategories,
    required this.currentPage,
    required this.totalPages,
    required this.totalCount,
    this.selectedFilter = 'All',
    this.searchQuery = '',
  });

  CategoriesLoaded copyWith({
    List<CategoryEntity>? masterCategories,
    List<CategoryEntity>? filteredCategories,
    List<CategoryEntity>? currentPageCategories,
    int? currentPage,
    int? totalPages,
    int? totalCount,
    String? selectedFilter,
    String? searchQuery,
  }) {
    return CategoriesLoaded(
      masterCategories: masterCategories ?? this.masterCategories,
      filteredCategories: filteredCategories ?? this.filteredCategories,
      currentPageCategories: currentPageCategories ?? this.currentPageCategories,
      currentPage: currentPage ?? this.currentPage,
      totalPages: totalPages ?? this.totalPages,
      totalCount: totalCount ?? this.totalCount,
      selectedFilter: selectedFilter ?? this.selectedFilter,
      searchQuery: searchQuery ?? this.searchQuery,
    );
  }

  /// Convenience factories to reduce boilerplate in Bloc action handlers.
  CategoryActionLoading toActionLoading() => CategoryActionLoading(
        masterCategories: masterCategories,
        filteredCategories: filteredCategories,
        currentPageCategories: currentPageCategories,
        currentPage: currentPage,
        totalPages: totalPages,
        totalCount: totalCount,
        selectedFilter: selectedFilter,
        searchQuery: searchQuery,
      );

  CategoryActionSuccess toActionSuccess(String msg) => CategoryActionSuccess(
        message: msg,
        masterCategories: masterCategories,
        filteredCategories: filteredCategories,
        currentPageCategories: currentPageCategories,
        currentPage: currentPage,
        totalPages: totalPages,
        totalCount: totalCount,
        selectedFilter: selectedFilter,
        searchQuery: searchQuery,
      );

  CategoryActionError toActionError(String msg) => CategoryActionError(
        message: msg,
        masterCategories: masterCategories,
        filteredCategories: filteredCategories,
        currentPageCategories: currentPageCategories,
        currentPage: currentPage,
        totalPages: totalPages,
        totalCount: totalCount,
        selectedFilter: selectedFilter,
        searchQuery: searchQuery,
      );

  @override
  List<Object?> get props => [
        masterCategories, filteredCategories, currentPageCategories,
        currentPage, totalPages, totalCount, selectedFilter, searchQuery,
      ];
}

class CategoriesError extends CategoriesState {
  final String message;
  const CategoriesError(this.message);
  @override
  List<Object?> get props => [message];
}

// ─── Action States (inherit CategoriesLoaded to keep table visible) ──

class CategoryActionLoading extends CategoriesLoaded {
  const CategoryActionLoading({
    required super.masterCategories,
    required super.filteredCategories,
    required super.currentPageCategories,
    required super.currentPage,
    required super.totalPages,
    required super.totalCount,
    super.selectedFilter,
    super.searchQuery,
  });
}

class CategoryActionSuccess extends CategoriesLoaded {
  final String message;
  const CategoryActionSuccess({
    required this.message,
    required super.masterCategories,
    required super.filteredCategories,
    required super.currentPageCategories,
    required super.currentPage,
    required super.totalPages,
    required super.totalCount,
    super.selectedFilter,
    super.searchQuery,
  });
  @override
  List<Object?> get props => [...super.props, message];
}

class CategoryActionError extends CategoriesLoaded {
  final String message;
  const CategoryActionError({
    required this.message,
    required super.masterCategories,
    required super.filteredCategories,
    required super.currentPageCategories,
    required super.currentPage,
    required super.totalPages,
    required super.totalCount,
    super.selectedFilter,
    super.searchQuery,
  });
  @override
  List<Object?> get props => [...super.props, message];
}
