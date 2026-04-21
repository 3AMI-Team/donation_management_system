import 'package:equatable/equatable.dart';

abstract class AddCaseState extends Equatable {
  const AddCaseState();

  @override
  List<Object?> get props => [];
}

class AddCaseInitial extends AddCaseState {}

class AddCaseLoading extends AddCaseState {}

class AddCaseSuccess extends AddCaseState {}

class AddCaseError extends AddCaseState {
  final String message;

  const AddCaseError({required this.message});

  @override
  List<Object?> get props => [message];
}
