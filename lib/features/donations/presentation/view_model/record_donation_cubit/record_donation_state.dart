import 'package:donation_management_system/features/categories/domain/entity/category_entity.dart';
import 'package:donation_management_system/features/donors/domain/entity/donor_entity.dart';
import 'package:equatable/equatable.dart';

enum RecordDonationStatus { initial, loading, success, error }

class RecordDonationState extends Equatable {
  final RecordDonationStatus status;
  final List<DonorEntity> donors;
  final List<CategoryEntity> categories;
  final DonorEntity? selectedDonor;
  final CategoryEntity? selectedCategory;
  final String? errorMessage;
  final bool isSubmitting;

  const RecordDonationState({
    this.status = RecordDonationStatus.initial,
    this.donors = const [],
    this.categories = const [],
    this.selectedDonor,
    this.selectedCategory,
    this.errorMessage,
    this.isSubmitting = false,
  });

  RecordDonationState copyWith({
    RecordDonationStatus? status,
    List<DonorEntity>? donors,
    List<CategoryEntity>? categories,
    DonorEntity? selectedDonor,
    CategoryEntity? selectedCategory,
    String? errorMessage,
    bool? isSubmitting,
  }) {
    return RecordDonationState(
      status: status ?? this.status,
      donors: donors ?? this.donors,
      categories: categories ?? this.categories,
      selectedDonor: selectedDonor ?? this.selectedDonor,
      selectedCategory: selectedCategory ?? this.selectedCategory,
      errorMessage: errorMessage ?? this.errorMessage,
      isSubmitting: isSubmitting ?? this.isSubmitting,
    );
  }

  @override
  List<Object?> get props => [
        status,
        donors,
        categories,
        selectedDonor,
        selectedCategory,
        errorMessage,
        isSubmitting,
      ];
}
