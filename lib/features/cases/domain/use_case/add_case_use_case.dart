import 'package:dartz/dartz.dart';
import 'package:donation_management_system/core/network/errors/failure.dart';
import 'package:donation_management_system/core/utils/use_case.dart';
import 'package:donation_management_system/features/cases/domain/entity/add_case_params.dart';
import 'package:donation_management_system/features/cases/domain/repo/cases_repo.dart';

class AddCaseUseCase extends UseCase<Unit, AddCaseParams> {
  final CasesRepo repository;

  AddCaseUseCase({required this.repository});

  @override
  Future<Either<Failure, Unit>> call(AddCaseParams params) async {
    return await repository.addCase(params);
  }
}
