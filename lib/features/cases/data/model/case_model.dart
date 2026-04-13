import 'package:donation_management_system/features/cases/domain/entity/case_entity.dart';

class CaseModel extends CaseEntity {
  const CaseModel({
    required super.id,
    required super.amount,
    required super.description,
    required super.status,
    required super.date,
    required super.supervisorId,
    required super.donorId,
    required super.categoryId,
  });

  factory CaseModel.fromJson(Map<String, dynamic> json) {
    return CaseModel(
      id: json['id'] is int ? json['id'] : int.tryParse(json['id'].toString()) ?? 0,
      amount: (json['amount'] as num?)?.toDouble() ?? 0.0,
      description: json['description']?.toString() ?? '',
      status: json['status']?.toString() ?? '',
      date: json['date'] != null 
          ? DateTime.parse(json['date'].toString()) 
          : DateTime.now(),
      supervisorId: json['supervisorId'] is int 
          ? json['supervisorId'] 
          : int.tryParse(json['supervisorId'].toString()) ?? 0,
      donorId: json['donorId'] is int 
          ? json['donorId'] 
          : int.tryParse(json['donorId'].toString()) ?? 0,
      categoryId: json['categoryId'] is int 
          ? json['categoryId'] 
          : int.tryParse(json['categoryId'].toString()) ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'amount': amount,
      'description': description,
      'status': status,
      'date': date.toIso8601String(),
      'supervisorId': supervisorId,
      'donorId': donorId,
      'categoryId': categoryId,
    };
  }
}
