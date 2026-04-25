part of 'categories_cubit.dart';

abstract class CategoriesState extends Equatable {
  @override
  List<Object?> get props => [];
}

class CategoriesInitial extends CategoriesState {}

class CategoriesLoading extends CategoriesState {}

class CategoriesLoaded extends CategoriesState {
  final List<CategoryUIModel> masterCategories;
  final List<CategoryUIModel> filteredCategories;
  final List<CategoryUIModel> currentPageCategories;
  final int currentPage;
  final int totalPages;
  final int totalCount;
  final String? selectedFilter;
  final String searchQuery;

  CategoriesLoaded({
    required this.masterCategories,
    required this.filteredCategories,
    required this.currentPageCategories,
    required this.currentPage,
    required this.totalPages,
    required this.totalCount,
    this.selectedFilter,
    this.searchQuery = '',
  });

  @override
  List<Object?> get props => [
        masterCategories,
        filteredCategories,
        currentPageCategories,
        currentPage,
        totalPages,
        totalCount,
        selectedFilter,
        searchQuery,
      ];
}

class CategoriesError extends CategoriesState {
  final String message;

  CategoriesError({required this.message});

  @override
  List<Object?> get props => [message];
}
