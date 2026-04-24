import 'package:dartz/dartz.dart';
import 'package:donation_management_system/core/network/errors/failure.dart';
import 'package:donation_management_system/features/distributions/domain/entity/distribution_entity.dart';
import 'package:donation_management_system/features/distributions/domain/entity/distribution_kpis_entity.dart';

abstract class DistributionsRepo {
  Future<Either<Failure, DistributionKpisEntity>> getDistributionKpis();
  Future<Either<Failure, List<DistributionEntity>>> getDistributions();
  Future<Either<Failure, void>> addDistribution(Map<String, dynamic> distributionData);
}
