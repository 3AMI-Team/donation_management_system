import 'package:equatable/equatable.dart';

class KpiValue extends Equatable {
  final double amount;
  final double vsLastMonth;

  const KpiValue({
    required this.amount,
    required this.vsLastMonth,
  });

  @override
  List<Object?> get props => [amount, vsLastMonth];
}

class DashboardKpis extends Equatable {
  final KpiValue totalDonations;
  final KpiValue activeCases;
  final KpiValue totalDonors;
  final KpiValue fundsDistributed;

  const DashboardKpis({
    required this.totalDonations,
    required this.activeCases,
    required this.totalDonors,
    required this.fundsDistributed,
  });

  @override
  List<Object?> get props => [
        totalDonations,
        activeCases,
        totalDonors,
        fundsDistributed,
      ];
}
