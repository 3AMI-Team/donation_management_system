import 'package:dartz/dartz.dart';
import '../../../../core/network/errors/failure.dart';
import '../../../../core/utils/use_case.dart';
import '../entity/last_donations_entity.dart';
import '../repo/dashboard_repo.dart';

class GetLastDonationsUseCase implements UseCase<List<LastDonation>, NoParams> {
  final DashboardRepo repository;

  GetLastDonationsUseCase(this.repository);

  @override
  Future<Either<Failure, List<LastDonation>>> call(NoParams params) async {
    return await repository.getLastDonations();
  }
}
