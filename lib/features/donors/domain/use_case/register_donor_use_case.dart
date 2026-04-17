import 'package:dartz/dartz.dart';
import 'package:donation_management_system/core/network/errors/failure.dart';
import 'package:donation_management_system/features/donors/domain/repo/donors_repo.dart';

class RegisterDonorUseCase {
  final DonorsRepo repository;

  RegisterDonorUseCase({required this.repository});

  Future<Either<Failure, void>> call({
    required String name,
    required String email,
    required String phone,
    required String address,
    required String type,
  }) {
    return repository.registerDonor(
      name: name,
      email: email,
      phone: phone,
      address: address,
      type: type,
    );
  }
}
