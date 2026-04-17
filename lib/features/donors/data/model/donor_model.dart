import 'package:donation_management_system/features/donors/domain/entity/donor_entity.dart';

class DonorModel extends DonorEntity {
  const DonorModel({
    required super.id,
    required super.name,
    required super.email,
    required super.phone,
    required super.registerDate,
    required super.address,
    required super.type,
  });

  factory DonorModel.fromJson(Map<String, dynamic> json) {
    return DonorModel(
      id: json['id'] is int ? json['id'] : int.tryParse(json['id'].toString()) ?? 0,
      name: json['name']?.toString() ?? '',
      email: json['email']?.toString() ?? '',
      phone: json['phone']?.toString() ?? '',
      address: json['address']?.toString() ?? '',
      type: json['type']?.toString() ?? 'Individual',
      registerDate: json['registerDate'] != null 
          ? DateTime.parse(json['registerDate'].toString()) 
          : DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'phone': phone,
      'address': address,
      'type': type,
      'registerDate': registerDate.toIso8601String(),
    };
  }
}
