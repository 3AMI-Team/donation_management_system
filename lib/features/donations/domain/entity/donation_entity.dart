import 'package:equatable/equatable.dart';

class Donation extends Equatable {
  final int id;
  final double amount;
  final String description;
  final String status;
  final DateTime date;
  final String donorName;
  final String categoryName;
  final String supervisorName;

  const Donation({
    required this.id,
    required this.amount,
    required this.description,
    required this.status,
    required this.date,
    required this.donorName,
    required this.categoryName,
    required this.supervisorName,
  });

  @override
  List<Object?> get props => [
        id,
        amount,
        description,
        status,
        date,
        donorName,
        categoryName,
        supervisorName,
      ];
}
