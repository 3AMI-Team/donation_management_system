import 'package:equatable/equatable.dart';
import 'package:donation_management_system/features/donors/domain/entity/donor_entity.dart';

class DonorsResponseEntity extends Equatable {
  final List<DonorEntity> donors;
  final int page;
  final int pageSize;
  final int totalCount;
  final int totalPages;

  const DonorsResponseEntity({
    required this.donors,
    required this.page,
    required this.pageSize,
    required this.totalCount,
    required this.totalPages,
  });

  @override
  List<Object?> get props => [donors, page, pageSize, totalCount, totalPages];
}
