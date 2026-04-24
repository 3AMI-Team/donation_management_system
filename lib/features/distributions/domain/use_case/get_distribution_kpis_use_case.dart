import 'package:dartz/dartz.dart';
import 'package:donation_management_system/core/network/errors/failure.dart';
import 'package:donation_management_system/features/distributions/domain/entity/distribution_kpis_entity.dart';
import 'package:donation_management_system/features/distributions/domain/repo/distributions_repo.dart';

class GetDistributionKpisUseCase {
  final DistributionsRepo repository;

  GetDistributionKpisUseCase({required this.repository});

  Future<Either<Failure, DistributionKpisEntity>> call() {
    return repository.getDistributionKpis();
  }
}
