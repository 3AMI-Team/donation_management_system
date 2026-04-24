import 'package:dartz/dartz.dart';
import 'package:donation_management_system/core/network/errors/failure.dart';
import 'package:donation_management_system/features/distributions/domain/entity/distribution_entity.dart';
import 'package:donation_management_system/features/distributions/domain/repo/distributions_repo.dart';

class GetDistributionsUseCase {
  final DistributionsRepo repository;

  GetDistributionsUseCase({required this.repository});

  Future<Either<Failure, List<DistributionEntity>>> call() {
    return repository.getDistributions();
  }
}
