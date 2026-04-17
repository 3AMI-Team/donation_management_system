import 'package:equatable/equatable.dart';

class DonorKpisEntity extends Equatable {
  final int totalDonors;
  final int activeDonors;
  final double totalDonatedAmount;
  final double avgDonation;

  const DonorKpisEntity({
    required this.totalDonors,
    required this.activeDonors,
    required this.totalDonatedAmount,
    required this.avgDonation,
  });

  @override
  List<Object?> get props => [totalDonors, activeDonors, totalDonatedAmount, avgDonation];
}
