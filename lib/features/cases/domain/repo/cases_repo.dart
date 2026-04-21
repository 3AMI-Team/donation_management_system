import 'package:dartz/dartz.dart';
import 'package:donation_management_system/core/network/errors/failure.dart';
import 'package:donation_management_system/features/cases/domain/entity/cases_response_entity.dart';
import 'package:donation_management_system/features/cases/domain/entity/case_kpis_entity.dart';
import 'package:donation_management_system/features/cases/domain/entity/add_case_params.dart';
abstract class CasesRepo {
  Future<Either<Failure, CasesResponseEntity>> getCases();
  Future<Either<Failure, CaseKpisEntity>> getCaseKpis();
  Future<Either<Failure, Unit>> addCase(AddCaseParams params);
}
