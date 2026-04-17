import 'package:dartz/dartz.dart';
import 'package:donation_management_system/core/network/errors/failure.dart';
import 'package:donation_management_system/features/donations/domain/entity/donations_response_entity.dart';
import 'package:donation_management_system/features/donations/domain/entity/donation_kpis_entity.dart';

abstract class DonationsRepo {
  Future<Either<Failure, DonationsResponse>> getDonations({
    String? status,
    String? category,
  });

  Future<Either<Failure, Unit>> registerDonation({
    required double amount,
    required String description,
    required String status,
    required String date,
    required int donorId,
    required int categoryId,
    required int supervisorId,
  });

  Future<Either<Failure, DonationKpisEntity>> getDonationKpis();
}
