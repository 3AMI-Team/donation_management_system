import 'package:equatable/equatable.dart';
import 'package:donation_management_system/features/cases/domain/entity/cases_response_entity.dart';

abstract class CasesState extends Equatable {
  const CasesState();

  @override
  List<Object?> get props => [];
}

class CasesInitial extends CasesState {}

class CasesLoading extends CasesState {}

class CasesLoaded extends CasesState {
  final CasesResponseEntity casesResponse;

  const CasesLoaded({required this.casesResponse});

  @override
  List<Object?> get props => [casesResponse];
}

class CasesError extends CasesState {
  final String message;

  const CasesError({required this.message});

  @override
  List<Object?> get props => [message];
}
