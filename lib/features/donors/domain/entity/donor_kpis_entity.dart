import 'package:equatable/equatable.dart';

class DonorKpisEntity extends Equatable {
  final int totalDonors;
  final int newDonorsThisMonth;
  final double totalDonatedAmount;
  final double avgDonation;

  const DonorKpisEntity({
    required this.totalDonors,
    required this.newDonorsThisMonth,
    required this.totalDonatedAmount,
    required this.avgDonation,
  });

  @override
  List<Object?> get props =>
      [totalDonors, newDonorsThisMonth, totalDonatedAmount, avgDonation];
}
