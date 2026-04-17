import 'package:dartz/dartz.dart';
import 'package:donation_management_system/core/network/errors/failure.dart';
import 'package:donation_management_system/core/utils/use_case.dart';
import 'package:donation_management_system/features/donations/domain/repo/donations_repo.dart';
import 'package:equatable/equatable.dart';

class RegisterDonationUseCase implements UseCase<Unit, RegisterDonationParams> {
  final DonationsRepo repository;

  RegisterDonationUseCase({required this.repository});

  @override
  Future<Either<Failure, Unit>> call(RegisterDonationParams params) async {
    return await repository.registerDonation(
      amount: params.amount,
      description: params.description,
      status: params.status,
      date: params.date,
      donorId: params.donorId,
      categoryId: params.categoryId,
      supervisorId: params.supervisorId,
    );
  }
}

class RegisterDonationParams extends Equatable {
  final double amount;
  final String description;
  final String status;
  final String date;
  final int donorId;
  final int categoryId;
  final int supervisorId;

  const RegisterDonationParams({
    required this.amount,
    required this.description,
    required this.status,
    required this.date,
    required this.donorId,
    required this.categoryId,
    required this.supervisorId,
  });

  @override
  List<Object?> get props => [
        amount,
        description,
        status,
        date,
        donorId,
        categoryId,
        supervisorId,
      ];
}
