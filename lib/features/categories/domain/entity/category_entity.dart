import 'package:equatable/equatable.dart';

class CategoryEntity extends Equatable {
  final int id;
  final String type;
  final String description;
  final int totalCases;
  final double totalDonations;

  const CategoryEntity({
    required this.id,
    required this.type,
    required this.description,
    this.totalCases = 0,
    this.totalDonations = 0.0,
  });

  CategoryEntity copyWith({
    int? id,
    String? type,
    String? description,
    int? totalCases,
    double? totalDonations,
  }) {
    return CategoryEntity(
      id: id ?? this.id,
      type: type ?? this.type,
      description: description ?? this.description,
      totalCases: totalCases ?? this.totalCases,
      totalDonations: totalDonations ?? this.totalDonations,
    );
  }

  @override
  List<Object?> get props => [id, type, description, totalCases, totalDonations];
}
