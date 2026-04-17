import 'package:donation_management_system/features/donations/domain/entity/donation_entity.dart';
import 'package:equatable/equatable.dart';

class DonationsResponse extends Equatable {
  final List<Donation> donations;
  final int page;
  final int pageSize;
  final int totalCount;
  final int totalPages;

  const DonationsResponse({
    required this.donations,
    required this.page,
    required this.pageSize,
    required this.totalCount,
    required this.totalPages,
  });

  @override
  List<Object?> get props => [donations, page, pageSize, totalCount, totalPages];
}
