import 'package:donation_management_system/features/distributions/domain/entity/distribution_entity.dart';
import 'package:equatable/equatable.dart';

abstract class DistributionsState extends Equatable {
  const DistributionsState();

  @override
  List<Object> get props => [];
}

class DistributionsInitial extends DistributionsState {}

class DistributionsLoading extends DistributionsState {}

class DistributionsLoaded extends DistributionsState {
  final List<DistributionEntity> masterDistributions;
  final List<DistributionEntity> filteredDistributions;
  final List<DistributionEntity> currentPageDistributions;
  final int currentPage;
  final int totalPages;
  final int totalCount;
  final String selectedStatus;
  final String searchQuery;

  const DistributionsLoaded({
    required this.masterDistributions,
    required this.filteredDistributions,
    required this.currentPageDistributions,
    required this.currentPage,
    required this.totalPages,
    required this.totalCount,
    required this.selectedStatus,
    required this.searchQuery,
  });

  @override
  List<Object> get props => [
        masterDistributions,
        filteredDistributions,
        currentPageDistributions,
        currentPage,
        totalPages,
        totalCount,
        selectedStatus,
        searchQuery,
      ];
}

class DistributionsError extends DistributionsState {
  final String message;

  const DistributionsError({required this.message});

  @override
  List<Object> get props => [message];
}
