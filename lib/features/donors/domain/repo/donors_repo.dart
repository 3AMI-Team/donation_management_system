import 'package:dartz/dartz.dart';
import 'package:donation_management_system/core/network/errors/failure.dart';
import 'package:donation_management_system/features/donors/domain/entity/donors_response_entity.dart';
import 'package:donation_management_system/features/donors/domain/entity/donor_kpis_entity.dart';

abstract class DonorsRepo {
  Future<Either<Failure, DonorsResponseEntity>> getDonors({
    required int page,
    required int pageSize,
  });

  Future<Either<Failure, DonorKpisEntity>> getDonorKpis();

  Future<Either<Failure, void>> registerDonor({
    required String name,
    required String email,
    required String phone,
    required String address,
    required String type,
  });

  Future<Either<Failure, void>> updateDonor({
    required int id,
    required String name,
    required String email,
    required String phone,
    required String address,
    required String type,
  });

  Future<Either<Failure, void>> deleteDonor(int id);
}
