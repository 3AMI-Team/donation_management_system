import 'package:dartz/dartz.dart';
import 'package:donation_management_system/core/network/errors/failure.dart';
import 'package:donation_management_system/features/donors/domain/repo/donors_repo.dart';

class DeleteDonorUseCase {
  final DonorsRepo repository;

  DeleteDonorUseCase({required this.repository});

  Future<Either<Failure, void>> call(int id) {
    return repository.deleteDonor(id);
  }
}
