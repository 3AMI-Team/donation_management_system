import '../../domain/entity/last_donations_entity.dart';

class LastDonationModel extends LastDonation {
  const LastDonationModel({
    required super.id,
    required super.donorName,
    required super.amount,
    required super.category,
    required super.date,
  });

  factory LastDonationModel.fromJson(Map<String, dynamic> json) {
    return LastDonationModel(
      id: json['id'] as int,
      donorName: json['donorName'] as String? ?? 'Unknown',
      amount: (json['amount'] as num?)?.toDouble() ?? 0.0,
      category: json['category'] as String? ?? 'General',
      date: json['date'] != null 
          ? DateTime.parse(json['date'] as String) 
          : DateTime.now(),
    );
  }
}
