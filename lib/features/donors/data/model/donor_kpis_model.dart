import 'package:donation_management_system/features/donors/domain/entity/donor_kpis_entity.dart';

class DonorKpisModel extends DonorKpisEntity {
  const DonorKpisModel({
    required super.totalDonors,
    required super.newDonorsThisMonth,
    required super.totalDonatedAmount,
    required super.avgDonation,
  });

  factory DonorKpisModel.fromJson(Map<String, dynamic> json) {
    return DonorKpisModel(
      totalDonors: json['totalDonors'] as int,
      newDonorsThisMonth: json['newDonorsThisMonth'] as int,
      totalDonatedAmount: (json['totalDonatedAmount'] as num).toDouble(),
      avgDonation: (json['avgDonation'] as num).toDouble(),
    );
  }
}
