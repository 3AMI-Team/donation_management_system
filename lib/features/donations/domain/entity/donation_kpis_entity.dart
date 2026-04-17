import 'package:equatable/equatable.dart';

class DonationKpisEntity extends Equatable {
  final double monthlyTotal;
  final int transactionCount;
  final String topCategory;
  final double pendingAmount;

  const DonationKpisEntity({
    required this.monthlyTotal,
    required this.transactionCount,
    required this.topCategory,
    required this.pendingAmount,
  });

  @override
  List<Object?> get props => [monthlyTotal, transactionCount, topCategory, pendingAmount];
}
