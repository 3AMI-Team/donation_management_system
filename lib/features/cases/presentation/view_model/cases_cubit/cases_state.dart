import 'package:equatable/equatable.dart';
import 'package:donation_management_system/features/cases/domain/entity/case_entity.dart';

abstract class CasesState extends Equatable {
  const CasesState();

  @override
  List<Object?> get props => [];
}

class CasesInitial extends CasesState {}

class CasesLoading extends CasesState {}

class CasesLoaded extends CasesState {
  final List<CaseEntity> masterCases;
  final List<CaseEntity> filteredCases;
  final List<CaseEntity> currentPageCases;
  final int currentPage;
  final int totalPages;
  final int totalCount;
  final String searchQuery;

  const CasesLoaded({
    required this.masterCases,
    required this.filteredCases,
    required this.currentPageCases,
    required this.currentPage,
    required this.totalPages,
    required this.totalCount,
    required this.searchQuery,
  });

  @override
  List<Object?> get props => [
        masterCases,
        filteredCases,
        currentPageCases,
        currentPage,
        totalPages,
        totalCount,
        searchQuery,
      ];
}

class CasesError extends CasesState {
  final String message;

  const CasesError({required this.message});

  @override
  List<Object?> get props => [message];
}
