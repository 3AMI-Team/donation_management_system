import 'package:dartz/dartz.dart';
import 'package:donation_management_system/core/network/errors/failure.dart';
import 'package:donation_management_system/features/distributions/domain/repo/distributions_repo.dart';

class AddDistributionUseCase {
  final DistributionsRepo repository;

  AddDistributionUseCase({required this.repository});

  Future<Either<Failure, void>> call(Map<String, dynamic> distributionData) {
    return repository.addDistribution(distributionData);
  }
}
