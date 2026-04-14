import 'package:dartz/dartz.dart';
import '../../../../core/network/errors/failure.dart';
import '../../../../core/utils/use_case.dart';
import '../entity/donation_trends_entity.dart';
import '../repo/dashboard_repo.dart';

class GetDonationTrendsUseCase implements UseCase<DonationTrends, NoParams> {
  final DashboardRepo repository;

  GetDonationTrendsUseCase(this.repository);

  @override
  Future<Either<Failure, DonationTrends>> call(NoParams params) async {
    return await repository.getDonationTrends();
  }
}
