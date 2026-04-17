part of 'case_stats_cubit.dart';

abstract class CaseStatsState extends Equatable {
  @override
  List<Object?> get props => [];
}

class CaseStatsInitial extends CaseStatsState {}

class CaseStatsLoading extends CaseStatsState {}

class CaseStatsLoaded extends CaseStatsState {
  final CaseKpisEntity kpis;

  CaseStatsLoaded({required this.kpis});

  @override
  List<Object?> get props => [kpis];
}

class CaseStatsError extends CaseStatsState {
  final String message;

  CaseStatsError({required this.message});

  @override
  List<Object?> get props => [message];
}
