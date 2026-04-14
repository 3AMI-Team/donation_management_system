import 'package:donation_management_system/features/dashboard/domain/entity/dashboard_kpis_entity.dart';
import 'package:equatable/equatable.dart';

abstract class KpisState extends Equatable {
  const KpisState();
  @override
  List<Object?> get props => [];
}

class KpisInitial extends KpisState {}
class KpisLoading extends KpisState {}
class KpisLoaded extends KpisState {
  final DashboardKpis kpis;
  const KpisLoaded(this.kpis);
  @override
  List<Object?> get props => [kpis];
}
class KpisError extends KpisState {
  final String message;
  const KpisError(this.message);
  @override
  List<Object?> get props => [message];
}
