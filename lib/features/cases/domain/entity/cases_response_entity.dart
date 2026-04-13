import 'package:equatable/equatable.dart';
import 'package:donation_management_system/features/cases/domain/entity/case_entity.dart';

class CasesResponseEntity extends Equatable {
  final List<CaseEntity> items;
  final int page;
  final int pageSize;
  final int totalCount;
  final int totalPages;

  const CasesResponseEntity({
    required this.items,
    required this.page,
    required this.pageSize,
    required this.totalCount,
    required this.totalPages,
  });

  @override
  List<Object?> get props => [items, page, pageSize, totalCount, totalPages];
}
