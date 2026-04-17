import 'package:donation_management_system/features/donors/domain/entity/donor_kpis_entity.dart';

class DonorKpisModel extends DonorKpisEntity {
  const DonorKpisModel({
    required super.totalDonors,
    required super.activeDonors,
    required super.totalDonatedAmount,
    required super.avgDonation,
  });

  factory DonorKpisModel.fromJson(Map<String, dynamic> json) {
    return DonorKpisModel(
      totalDonors: json['totalDonors'] as int,
      activeDonors: json['activeDonors'] as int,
      totalDonatedAmount: (json['totalDonatedAmount'] as num).toDouble(),
      avgDonation: (json['avgDonation'] as num).toDouble(),
    );
  }
}
