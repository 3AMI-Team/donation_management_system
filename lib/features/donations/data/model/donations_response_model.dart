import 'package:donation_management_system/features/donations/data/model/donation_model.dart';
import 'package:donation_management_system/features/donations/domain/entity/donations_response_entity.dart';

class DonationsResponseModel extends DonationsResponse {
  const DonationsResponseModel({
    required super.donations,
    required super.page,
    required super.pageSize,
    required super.totalCount,
    required super.totalPages,
  });

  factory DonationsResponseModel.fromJson(dynamic json) {
    if (json is Map<String, dynamic> && json.containsKey('items')) {
      return DonationsResponseModel(
        donations: (json['items'] as List)
            .map((i) => DonationModel.fromJson(i as Map<String, dynamic>))
            .toList(),
        page: json['page'] as int? ?? 1,
        pageSize: json['pageSize'] as int? ?? 10,
        totalCount: json['totalCount'] as int? ?? (json['items'] as List).length,
        totalPages: json['totalPages'] as int? ?? 1,
      );
    } else if (json is List) {
      return DonationsResponseModel(
        donations: json
            .map((i) => DonationModel.fromJson(i as Map<String, dynamic>))
            .toList(),
        page: 1,
        pageSize: json.length,
        totalCount: json.length,
        totalPages: 1,
      );
    } else {
      throw Exception('Format error: Expected Map with items or List for donations');
    }
  }
}
