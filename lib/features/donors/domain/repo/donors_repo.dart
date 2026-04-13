import 'package:dartz/dartz.dart';
import 'package:donation_management_system/core/network/errors/failure.dart';
import 'package:donation_management_system/features/donors/domain/entity/donors_response_entity.dart';

abstract class DonorsRepo {
  Future<Either<Failure, DonorsResponseEntity>> getDonors({
    required int page,
    required int pageSize,
  });
}
