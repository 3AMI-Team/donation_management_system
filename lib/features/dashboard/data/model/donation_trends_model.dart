import '../../domain/entity/donation_trends_entity.dart';

class DonationTrendItemModel extends DonationTrendItem {
  const DonationTrendItemModel({required super.label, required super.amount});

  factory DonationTrendItemModel.fromJson(Map<String, dynamic> json, String labelKey) {
    return DonationTrendItemModel(
      label: json[labelKey].toString(),
      amount: (json['amount'] as num?)?.toDouble() ?? 0.0,
    );
  }
}

class DonationTrendsModel extends DonationTrends {
  const DonationTrendsModel({
    required super.donationByMonth,
    required super.donationByDay,
    required super.donationByWeek,
  });

  factory DonationTrendsModel.fromJson(Map<String, dynamic> json) {
    return DonationTrendsModel(
      donationByMonth: (json['donationByMonth'] as List? ?? [])
          .map((e) => DonationTrendItemModel.fromJson(e, 'month'))
          .toList(),
      donationByDay: (json['donationByDay'] as List? ?? [])
          .map((e) => DonationTrendItemModel.fromJson(e, 'hour'))
          .toList(),
      donationByWeek: (json['donationByWeek'] as List? ?? [])
          .map((e) => DonationTrendItemModel.fromJson(e, 'day'))
          .toList(),
    );
  }
}
