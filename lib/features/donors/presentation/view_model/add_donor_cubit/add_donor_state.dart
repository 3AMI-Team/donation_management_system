import 'package:equatable/equatable.dart';

abstract class AddDonorState extends Equatable {
  const AddDonorState();

  @override
  List<Object> get props => [];
}

class AddDonorInitial extends AddDonorState {}

class AddDonorLoading extends AddDonorState {}

class AddDonorSuccess extends AddDonorState {}

class UpdateDonorSuccess extends AddDonorState {}

class DeleteDonorSuccess extends AddDonorState {}

class AddDonorError extends AddDonorState {
  final String message;

  const AddDonorError({required this.message});

  @override
  List<Object> get props => [message];
}
