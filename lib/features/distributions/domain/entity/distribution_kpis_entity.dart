import 'package:equatable/equatable.dart';

class DistributionKpisEntity extends Equatable {
  final double totalDistributed;
  final int casesServed;
  final double avgDistribution;
  final double remainingBalance;

  const DistributionKpisEntity({
    required this.totalDistributed,
    required this.casesServed,
    required this.avgDistribution,
    required this.remainingBalance,
  });

  factory DistributionKpisEntity.fromJson(Map<String, dynamic> json) {
    return DistributionKpisEntity(
      totalDistributed: (json['totalDistributed'] as num?)?.toDouble() ?? 0.0,
      casesServed: json['casesServed'] ?? 0,
      avgDistribution: (json['avgDistribution'] as num?)?.toDouble() ?? 0.0,
      remainingBalance: (json['remainingBalance'] as num?)?.toDouble() ?? 0.0,
    );
  }

  @override
  List<Object?> get props => [
        totalDistributed,
        casesServed,
        avgDistribution,
        remainingBalance,
      ];
}
