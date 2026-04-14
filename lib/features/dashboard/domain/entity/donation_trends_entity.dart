import 'package:equatable/equatable.dart';

class DonationTrendItem extends Equatable {
  final String label;
  final double amount;

  const DonationTrendItem({
    required this.label,
    required this.amount,
  });

  @override
  List<Object?> get props => [label, amount];
}

class DonationTrends extends Equatable {
  final List<DonationTrendItem> donationByMonth;
  final List<DonationTrendItem> donationByDay;
  final List<DonationTrendItem> donationByWeek;

  const DonationTrends({
    required this.donationByMonth,
    required this.donationByDay,
    required this.donationByWeek,
  });

  @override
  List<Object?> get props => [donationByMonth, donationByDay, donationByWeek];
}
