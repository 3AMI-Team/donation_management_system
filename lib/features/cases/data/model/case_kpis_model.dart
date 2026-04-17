import 'package:donation_management_system/features/cases/domain/entity/case_kpis_entity.dart';

class CaseKpisModel extends CaseKpisEntity {
  const CaseKpisModel({
    required super.totalActive,
    required super.totalPending,
    required super.totalDonors,
    required super.avgResponseTime,
  });

  factory CaseKpisModel.fromJson(Map<String, dynamic> json) {
    return CaseKpisModel(
      totalActive: json['totalActive'] as int,
      totalPending: json['totalPending'] as int,
      totalDonors: json['totalDonors'] as int,
      avgResponseTime: (json['avgResponseTime'] as num).toDouble(),
    );
  }
}
