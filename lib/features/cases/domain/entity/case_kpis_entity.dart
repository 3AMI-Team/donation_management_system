import 'package:equatable/equatable.dart';

class CaseKpisEntity extends Equatable {
  final int totalActive;
  final int totalPending;
  final int totalDonors;
  final double avgResponseTime;

  const CaseKpisEntity({
    required this.totalActive,
    required this.totalPending,
    required this.totalDonors,
    required this.avgResponseTime,
  });

  @override
  List<Object?> get props => [totalActive, totalPending, totalDonors, avgResponseTime];
}
