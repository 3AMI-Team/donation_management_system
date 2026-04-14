import 'package:donation_management_system/features/dashboard/domain/entity/dashboard_kpis_entity.dart';
import 'package:equatable/equatable.dart';


abstract class DashboardState extends Equatable {
  const DashboardState();

  @override
  List<Object?> get props => [];
}

class DashboardInitial extends DashboardState {}

class DashboardLoading extends DashboardState {}

class DashboardKpisLoaded extends DashboardState {
  final DashboardKpis kpis;

  const DashboardKpisLoaded(this.kpis);

  @override
  List<Object?> get props => [kpis];
}

class DashboardError extends DashboardState {
  final String message;

  const DashboardError(this.message);

  @override
  List<Object?> get props => [message];
}
