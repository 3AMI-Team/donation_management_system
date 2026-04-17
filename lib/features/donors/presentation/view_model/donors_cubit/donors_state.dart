import 'package:equatable/equatable.dart';
import 'package:donation_management_system/features/donors/domain/entity/donor_entity.dart';

abstract class DonorsState extends Equatable {
  const DonorsState();

  @override
  List<Object?> get props => [];
}

class DonorsInitial extends DonorsState {}

class DonorsLoading extends DonorsState {}

class DonorsLoaded extends DonorsState {
  final List<DonorEntity> masterDonors;
  final List<DonorEntity> filteredDonors;
  final List<DonorEntity> currentPageDonors;
  final int currentPage;
  final int totalPages;
  final int totalCount;
  final String searchQuery;

  const DonorsLoaded({
    required this.masterDonors,
    required this.filteredDonors,
    required this.currentPageDonors,
    required this.currentPage,
    required this.totalPages,
    required this.totalCount,
    this.searchQuery = '',
  });

  @override
  List<Object?> get props => [
        masterDonors,
        filteredDonors,
        currentPageDonors,
        currentPage,
        totalPages,
        totalCount,
        searchQuery,
      ];
}

class DonorsError extends DonorsState {
  final String message;

  const DonorsError({required this.message});

  @override
  List<Object?> get props => [message];
}
