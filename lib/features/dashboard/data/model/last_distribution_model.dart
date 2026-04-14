import 'package:donation_management_system/features/dashboard/domain/entity/last_distribution_entity.dart';

class LastDistributionModel extends LastDistribution {
  const LastDistributionModel({
    required super.id,
    required super.caseName,
    required super.amount,
    required super.date,
  });

  factory LastDistributionModel.fromJson(Map<String, dynamic> json) {
    return LastDistributionModel(
      id: json['id'],
      caseName: json['caseName'],
      amount: (json['amount'] as num).toDouble(),
      date: DateTime.parse(json['date']),
    );
  }
}
