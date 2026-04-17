import 'package:donation_management_system/features/donations/domain/entity/donation_entity.dart';
import 'package:equatable/equatable.dart';

abstract class DonationsState extends Equatable {
  const DonationsState();

  @override
  List<Object?> get props => [];
}

class DonationsInitial extends DonationsState {}

class DonationsLoading extends DonationsState {}

class DonationsLoaded extends DonationsState {
  final List<Donation> masterDonations; // Original fetched list
  final List<Donation> filteredDonations; // List after search/filter
  final List<Donation> currentPageDonations; // Slice for current page
  final int currentPage;
  final int totalPages;
  final int totalCount;
  final String? selectedCategory;
  final String? selectedStatus;
  final String searchQuery;

  const DonationsLoaded({
    required this.masterDonations,
    required this.filteredDonations,
    required this.currentPageDonations,
    required this.currentPage,
    required this.totalPages,
    required this.totalCount,
    this.selectedCategory,
    this.selectedStatus,
    this.searchQuery = '',
  });

  @override
  List<Object?> get props => [
        masterDonations,
        filteredDonations,
        currentPageDonations,
        currentPage,
        totalPages,
        totalCount,
        selectedCategory,
        selectedStatus,
        searchQuery,
      ];
}

class DonationsError extends DonationsState {
  final String message;

  const DonationsError({required this.message});

  @override
  List<Object?> get props => [message];
}
