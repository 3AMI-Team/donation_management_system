import 'package:donation_management_system/features/donations/domain/entity/donation_kpis_entity.dart';

class DonationKpisModel extends DonationKpisEntity {
  const DonationKpisModel({
    required super.monthlyTotal,
    required super.transactionCount,
    required super.topCategory,
    required super.pendingAmount,
  });

  factory DonationKpisModel.fromJson(Map<String, dynamic> json) {
    return DonationKpisModel(
      monthlyTotal: (json['monthlyTotal'] as num).toDouble(),
      transactionCount: json['transactionCount'] as int,
      topCategory: json['topCategory'] as String,
      pendingAmount: (json['pendingAmount'] as num).toDouble(),
    );
  }
}
