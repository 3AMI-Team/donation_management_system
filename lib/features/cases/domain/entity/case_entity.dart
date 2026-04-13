import 'package:equatable/equatable.dart';

class CaseEntity extends Equatable {
  final int id;
  final double amount;
  final String description;
  final String status;
  final DateTime date;
  final int supervisorId;
  final int donorId;
  final int categoryId;

  const CaseEntity({
    required this.id,
    required this.amount,
    required this.description,
    required this.status,
    required this.date,
    required this.supervisorId,
    required this.donorId,
    required this.categoryId,
  });

  @override
  List<Object?> get props => [
        id,
        amount,
        description,
        status,
        date,
        supervisorId,
        donorId,
        categoryId,
      ];
}
