import 'package:dartz/dartz.dart';
import 'package:donation_management_system/core/network/errors/failure.dart';
import 'package:donation_management_system/core/utils/use_case.dart';
import 'package:donation_management_system/features/cases/domain/entity/add_case_params.dart';
import 'package:donation_management_system/features/cases/domain/repo/cases_repo.dart';

class UpdateCaseParams {
  final int id;
  final AddCaseParams params;

  UpdateCaseParams({required this.id, required this.params});
}

class UpdateCaseUseCase extends UseCase<Unit, UpdateCaseParams> {
  final CasesRepo repository;

  UpdateCaseUseCase({required this.repository});

  @override
  Future<Either<Failure, Unit>> call(UpdateCaseParams params) async {
    return await repository.updateCase(params.id, params.params);
  }
}
