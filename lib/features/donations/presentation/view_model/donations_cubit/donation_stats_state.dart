part of 'donation_stats_cubit.dart';

abstract class DonationStatsState extends Equatable {
  @override
  List<Object?> get props => [];
}

class DonationStatsInitial extends DonationStatsState {}

class DonationStatsLoading extends DonationStatsState {}

class DonationStatsLoaded extends DonationStatsState {
  final DonationKpisEntity kpis;

  DonationStatsLoaded({required this.kpis});

  @override
  List<Object?> get props => [kpis];
}

class DonationStatsError extends DonationStatsState {
  final String message;

  DonationStatsError({required this.message});

  @override
  List<Object?> get props => [message];
}
