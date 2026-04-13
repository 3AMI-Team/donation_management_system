import 'package:donation_management_system/features/cases/data/model/case_model.dart';
import 'package:donation_management_system/features/cases/domain/entity/cases_response_entity.dart';

class CasesResponseModel extends CasesResponseEntity {
  const CasesResponseModel({
    required super.items,
    required super.page,
    required super.pageSize,
    required super.totalCount,
    required super.totalPages,
  });

  factory CasesResponseModel.fromJson(dynamic json) {
    if (json is Map<String, dynamic> && json.containsKey('items')) {
      return CasesResponseModel(
        items: (json['items'] as List)
            .map((i) => CaseModel.fromJson(i as Map<String, dynamic>))
            .toList(),
        page: json['page'] as int? ?? 1,
        pageSize: json['pageSize'] as int? ?? 10,
        totalCount: json['totalCount'] as int? ?? (json['items'] as List).length,
        totalPages: json['totalPages'] as int? ?? 1,
      );
    } else if (json is List) {
      return CasesResponseModel(
        items: json
            .map((i) => CaseModel.fromJson(i as Map<String, dynamic>))
            .toList(),
        page: 1,
        pageSize: json.length,
        totalCount: json.length,
        totalPages: 1,
      );
    } else {
      throw Exception('Format error: Expected Map with items or List, got ${json.runtimeType}');
    }
  }
}
