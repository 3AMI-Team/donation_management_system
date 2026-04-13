import 'package:equatable/equatable.dart';
import 'package:donation_management_system/features/donors/domain/entity/donors_response_entity.dart';

abstract class DonorsState extends Equatable {
  const DonorsState();

  @override
  List<Object?> get props => [];
}

class DonorsInitial extends DonorsState {}

class DonorsLoading extends DonorsState {}

class DonorsLoaded extends DonorsState {
  final DonorsResponseEntity donorsResponse;

  const DonorsLoaded({required this.donorsResponse});

  @override
  List<Object?> get props => [donorsResponse];
}

class DonorsError extends DonorsState {
  final String message;

  const DonorsError({required this.message});

  @override
  List<Object?> get props => [message];
}
