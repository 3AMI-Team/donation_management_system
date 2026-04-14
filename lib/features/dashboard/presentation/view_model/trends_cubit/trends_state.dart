import 'package:donation_management_system/features/dashboard/domain/entity/donation_trends_entity.dart';
import 'package:equatable/equatable.dart';

abstract class TrendsState extends Equatable {
  const TrendsState();
  @override
  List<Object?> get props => [];
}

class TrendsInitial extends TrendsState {}
class TrendsLoading extends TrendsState {}
class TrendsLoaded extends TrendsState {
  final DonationTrends trends;
  const TrendsLoaded(this.trends);
  @override
  List<Object?> get props => [trends];
}
class TrendsError extends TrendsState {
  final String message;
  const TrendsError(this.message);
  @override
  List<Object?> get props => [message];
}
