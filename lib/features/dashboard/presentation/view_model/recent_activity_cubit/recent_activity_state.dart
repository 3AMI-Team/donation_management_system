import 'package:donation_management_system/features/dashboard/domain/entity/last_donations_entity.dart';
import 'package:equatable/equatable.dart';

abstract class RecentActivityState extends Equatable {
  const RecentActivityState();
  @override
  List<Object?> get props => [];
}

class RecentActivityInitial extends RecentActivityState {}
class RecentActivityLoading extends RecentActivityState {}
class RecentActivityLoaded extends RecentActivityState {
  final List<LastDonation> donations;
  const RecentActivityLoaded(this.donations);
  @override
  List<Object?> get props => [donations];
}
class RecentActivityError extends RecentActivityState {
  final String message;
  const RecentActivityError(this.message);
  @override
  List<Object?> get props => [message];
}
