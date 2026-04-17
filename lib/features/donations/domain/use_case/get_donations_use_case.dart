import 'package:dartz/dartz.dart';
import 'package:donation_management_system/core/network/errors/failure.dart';
import 'package:donation_management_system/core/utils/use_case.dart';
import 'package:donation_management_system/features/donations/domain/entity/donations_response_entity.dart';
import 'package:donation_management_system/features/donations/domain/repo/donations_repo.dart';
import 'package:equatable/equatable.dart';

class GetDonationsUseCase extends UseCase<DonationsResponse, GetDonationsParams> {
  final DonationsRepo repository;

  GetDonationsUseCase({required this.repository});

  @override
  Future<Either<Failure, DonationsResponse>> call(GetDonationsParams params) {
    return repository.getDonations(
      status: params.status,
      category: params.category,
    );
  }
}

class GetDonationsParams extends Equatable {
  final String? status;
  final String? category;

  const GetDonationsParams({
    this.status,
    this.category,
  });

  @override
  List<Object?> get props => [status, category];
}
