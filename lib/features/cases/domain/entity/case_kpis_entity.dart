import 'package:equatable/equatable.dart';

class CaseKpisEntity extends Equatable {
  final int totalCases;
  final int pendingReview;
  final int activeCases;
  final int fundedCases;

  const CaseKpisEntity({
    required this.totalCases,
    required this.pendingReview,
    required this.activeCases,
    required this.fundedCases,
  });

  @override
  List<Object?> get props => [totalCases, pendingReview, activeCases, fundedCases];
}
