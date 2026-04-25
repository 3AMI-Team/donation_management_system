import 'package:donation_management_system/features/categories/domain/entity/category_entity.dart';
import 'package:equatable/equatable.dart';

class CategoryUIModel extends Equatable {
  final CategoryEntity category;
  final int totalCases;
  final double totalDonations;

  const CategoryUIModel({
    required this.category,
    required this.totalCases,
    required this.totalDonations,
  });

  @override
  List<Object?> get props => [category, totalCases, totalDonations];
}
