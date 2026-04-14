import 'package:dartz/dartz.dart';
import '../../../../core/network/errors/failure.dart';
import '../entity/dashboard_kpis_entity.dart';
import '../entity/donation_trends_entity.dart';
import '../entity/last_distribution_entity.dart';
import '../entity/last_donations_entity.dart';

abstract class DashboardRepo {
  Future<Either<Failure, DashboardKpis>> getDashboardKpis();
  Future<Either<Failure, DonationTrends>> getDonationTrends();
  Future<Either<Failure, List<LastDonation>>> getLastDonations();
  Future<Either<Failure, List<LastDistribution>>> getLastDistributions();
}
