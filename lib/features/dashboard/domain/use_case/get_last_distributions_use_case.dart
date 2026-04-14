import 'package:dartz/dartz.dart';
import 'package:donation_management_system/core/network/errors/failure.dart';
import 'package:donation_management_system/core/utils/use_case.dart';
import 'package:donation_management_system/features/dashboard/domain/entity/last_distribution_entity.dart';
import 'package:donation_management_system/features/dashboard/domain/repo/dashboard_repo.dart';

class GetLastDistributionsUseCase implements UseCase<List<LastDistribution>, NoParams> {
  final DashboardRepo repository;

  GetLastDistributionsUseCase(this.repository);

  @override
  Future<Either<Failure, List<LastDistribution>>> call(NoParams params) async {
    return await repository.getLastDistributions();
  }
}
