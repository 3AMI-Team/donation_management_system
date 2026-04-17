import 'package:dartz/dartz.dart';
import 'package:donation_management_system/core/network/errors/failure.dart';
import 'package:donation_management_system/core/utils/use_case.dart';
import 'package:donation_management_system/features/cases/domain/entity/case_kpis_entity.dart';
import 'package:donation_management_system/features/cases/domain/repo/cases_repo.dart';

class GetCaseKpisUseCase implements UseCase<CaseKpisEntity, NoParams> {
  final CasesRepo repository;

  GetCaseKpisUseCase({required this.repository});

  @override
  Future<Either<Failure, CaseKpisEntity>> call(NoParams params) async {
    return await repository.getCaseKpis();
  }
}
