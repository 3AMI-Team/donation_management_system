part of 'donor_stats_cubit.dart';

abstract class DonorStatsState extends Equatable {
  @override
  List<Object?> get props => [];
}

class DonorStatsInitial extends DonorStatsState {}

class DonorStatsLoading extends DonorStatsState {}

class DonorStatsLoaded extends DonorStatsState {
  final DonorKpisEntity kpis;

  DonorStatsLoaded({required this.kpis});

  @override
  List<Object?> get props => [kpis];
}

class DonorStatsError extends DonorStatsState {
  final String message;

  DonorStatsError({required this.message});

  @override
  List<Object?> get props => [message];
}
