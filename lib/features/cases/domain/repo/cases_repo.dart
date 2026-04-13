import 'package:dartz/dartz.dart';
import 'package:donation_management_system/core/network/errors/failure.dart';
import 'package:donation_management_system/features/cases/domain/entity/cases_response_entity.dart';

abstract class CasesRepo {
  Future<Either<Failure, CasesResponseEntity>> getCases();
}
