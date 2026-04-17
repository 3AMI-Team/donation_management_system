import 'package:dartz/dartz.dart';
import 'package:donation_management_system/core/network/errors/failure.dart';
import 'package:donation_management_system/core/utils/use_case.dart';
import 'package:donation_management_system/features/donations/domain/entity/donation_kpis_entity.dart';
import 'package:donation_management_system/features/donations/domain/repo/donations_repo.dart';

class GetDonationKpisUseCase implements UseCase<DonationKpisEntity, NoParams> {
  final DonationsRepo repository;

  GetDonationKpisUseCase({required this.repository});

  @override
  Future<Either<Failure, DonationKpisEntity>> call(NoParams params) async {
    return await repository.getDonationKpis();
  }
}
