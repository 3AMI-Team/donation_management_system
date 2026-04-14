import 'package:donation_management_system/features/dashboard/domain/entity/last_distribution_entity.dart';
import 'package:equatable/equatable.dart';

abstract class LastDistributionsState extends Equatable {
  const LastDistributionsState();
  @override
  List<Object?> get props => [];
}

class LastDistributionsInitial extends LastDistributionsState {}
class LastDistributionsLoading extends LastDistributionsState {}
class LastDistributionsLoaded extends LastDistributionsState {
  final List<LastDistribution> distributions;
  const LastDistributionsLoaded(this.distributions);
  @override
  List<Object?> get props => [distributions];
}
class LastDistributionsError extends LastDistributionsState {
  final String message;
  const LastDistributionsError(this.message);
  @override
  List<Object?> get props => [message];
}
