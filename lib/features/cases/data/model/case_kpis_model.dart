import 'package:donation_management_system/features/cases/domain/entity/case_kpis_entity.dart';

class CaseKpisModel extends CaseKpisEntity {
  const CaseKpisModel({
    required super.totalCases,
    required super.pendingReview,
    required super.activeCases,
    required super.fundedCases,
  });

  factory CaseKpisModel.fromJson(Map<String, dynamic> json) {
    return CaseKpisModel(
      totalCases: json['totalCases'] as int? ?? 0,
      pendingReview: json['pendingReview'] as int? ?? 0,
      activeCases: json['activeCases'] as int? ?? 0,
      fundedCases: json['fundedCases'] as int? ?? 0,
    );
  }
}
