import 'package:donation_management_system/features/cases/domain/entity/case_entity.dart';

class CaseModel extends CaseEntity {
  const CaseModel({
    required super.id,
    required super.name,
    required super.phone,
    required super.address,
    required super.registDate,
    required super.status,
    required super.description,
    required super.categoryName,
    required super.supervisorName,
  });

  factory CaseModel.fromJson(Map<String, dynamic> json) {
    return CaseModel(
      id: json['id'] is int ? json['id'] : int.tryParse(json['id'].toString()) ?? 0,
      name: json['name']?.toString() ?? '',
      phone: json['phone']?.toString() ?? '',
      address: json['address']?.toString() ?? '',
      registDate: json['registDate'] != null 
          ? DateTime.parse(json['registDate'].toString()) 
          : DateTime.now(),
      status: json['status']?.toString() ?? '',
      description: json['description']?.toString() ?? '',
      categoryName: json['categoryName']?.toString() ?? '',
      supervisorName: json['supervisorName']?.toString() ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'phone': phone,
      'address': address,
      'registDate': registDate.toIso8601String(),
      'status': status,
      'description': description,
      'categoryName': categoryName,
      'supervisorName': supervisorName,
    };
  }
}
