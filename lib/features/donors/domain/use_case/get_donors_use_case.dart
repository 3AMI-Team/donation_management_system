import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:donation_management_system/core/network/errors/failure.dart';
import 'package:donation_management_system/core/utils/use_case.dart';
import 'package:donation_management_system/features/donors/domain/entity/donors_response_entity.dart';
import 'package:donation_management_system/features/donors/domain/repo/donors_repo.dart';

class GetDonorsUseCase implements UseCase<DonorsResponseEntity, DonorsParams> {
  final DonorsRepo repository;

  GetDonorsUseCase({required this.repository});

  @override
  Future<Either<Failure, DonorsResponseEntity>> call(DonorsParams params) async {
    return await repository.getDonors(
      page: params.page,
      pageSize: params.pageSize,
    );
  }
}

class DonorsParams extends Equatable {
  final int page;
  final int pageSize;

  const DonorsParams({required this.page, required this.pageSize});

  @override
  List<Object?> get props => [page, pageSize];
}
