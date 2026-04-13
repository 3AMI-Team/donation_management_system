import 'package:donation_management_system/features/donors/data/model/donor_model.dart';
import 'package:donation_management_system/features/donors/domain/entity/donors_response_entity.dart';

class DonorsResponseModel extends DonorsResponseEntity {
  const DonorsResponseModel({
    required super.donors,
    required super.page,
    required super.pageSize,
    required super.totalCount,
    required super.totalPages,
  });

  factory DonorsResponseModel.fromJson(dynamic json) {
    if (json is Map<String, dynamic> && json.containsKey('items')) {
      return DonorsResponseModel(
        donors: (json['items'] as List)
            .map((i) => DonorModel.fromJson(i as Map<String, dynamic>))
            .toList(),
        page: json['page'] as int? ?? 1,
        pageSize: json['pageSize'] as int? ?? 10,
        totalCount: json['totalCount'] as int? ?? (json['items'] as List).length,
        totalPages: json['totalPages'] as int? ?? 1,
      );
    } else if (json is List) {
      return DonorsResponseModel(
        donors: json
            .map((i) => DonorModel.fromJson(i as Map<String, dynamic>))
            .toList(),
        page: 1,
        pageSize: json.length,
        totalCount: json.length,
        totalPages: 1,
      );
    } else {
      throw Exception('Format error: Expected Map with items or List for donors');
    }
  }
}
