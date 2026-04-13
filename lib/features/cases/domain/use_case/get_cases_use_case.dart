import 'package:dartz/dartz.dart';
import 'package:donation_management_system/core/network/errors/failure.dart';
import 'package:donation_management_system/core/utils/use_case.dart';
import 'package:donation_management_system/features/cases/domain/entity/cases_response_entity.dart';
import 'package:donation_management_system/features/cases/domain/repo/cases_repo.dart';

class GetCasesUseCase implements UseCase<CasesResponseEntity, NoParams> {
  final CasesRepo repository;

  GetCasesUseCase({required this.repository});

  @override
  Future<Either<Failure, CasesResponseEntity>> call(NoParams params) async {
    return await repository.getCases();
  }
}
