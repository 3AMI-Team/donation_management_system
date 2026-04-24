import 'package:donation_management_system/features/distributions/domain/entity/distribution_kpis_entity.dart';
import 'package:equatable/equatable.dart';

abstract class DistributionStatsState extends Equatable {
  const DistributionStatsState();

  @override
  List<Object> get props => [];
}

class DistributionStatsInitial extends DistributionStatsState {}

class DistributionStatsLoading extends DistributionStatsState {}

class DistributionStatsLoaded extends DistributionStatsState {
  final DistributionKpisEntity kpis;

  const DistributionStatsLoaded({required this.kpis});

  @override
  List<Object> get props => [kpis];
}

class DistributionStatsError extends DistributionStatsState {
  final String message;

  const DistributionStatsError({required this.message});

  @override
  List<Object> get props => [message];
}
