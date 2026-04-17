import 'package:dartz/dartz.dart';
import 'package:donation_management_system/core/network/errors/failure.dart';
import 'package:donation_management_system/core/utils/use_case.dart';
import 'package:donation_management_system/features/donors/domain/entity/donor_kpis_entity.dart';
import 'package:donation_management_system/features/donors/domain/repo/donors_repo.dart';

class GetDonorKpisUseCase implements UseCase<DonorKpisEntity, NoParams> {
  final DonorsRepo repository;

  GetDonorKpisUseCase({required this.repository});

  @override
  Future<Either<Failure, DonorKpisEntity>> call(NoParams params) async {
    return await repository.getDonorKpis();
  }
}
