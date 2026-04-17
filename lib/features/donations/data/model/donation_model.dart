import 'package:donation_management_system/features/donations/domain/entity/donation_entity.dart';

class DonationModel extends Donation {
  const DonationModel({
    required super.id,
    required super.amount,
    required super.description,
    required super.status,
    required super.date,
    required super.donorName,
    required super.categoryName,
    required super.supervisorName,
  });

  factory DonationModel.fromJson(Map<String, dynamic> json) {
    return DonationModel(
      id: json['id'] as int,
      amount: (json['amount'] as num).toDouble(),
      description: json['description'] as String? ?? '',
      status: json['status'] as String? ?? 'Unknown',
      date: DateTime.parse(json['date'] as String),
      donorName: json['donorName'] as String? ?? 'Anonymous',
      categoryName: json['categoryName'] as String? ?? 'General',
      supervisorName: json['supervisorName'] as String? ?? 'N/A',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'amount': amount,
      'description': description,
      'status': status,
      'date': date.toIso8601String(),
      'donorName': donorName,
      'categoryName': categoryName,
      'supervisorName': supervisorName,
    };
  }
}
