import 'package:equatable/equatable.dart';

class AddCaseParams extends Equatable {
  final String name;
  final String phone;
  final String address;
  final String registDate;
  final String status;
  final String description;
  final int categoryId;
  final int supervisorId;

  const AddCaseParams({
    required this.name,
    required this.phone,
    required this.address,
    required this.registDate,
    required this.status,
    required this.description,
    required this.categoryId,
    required this.supervisorId,
  });

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "phone": phone,
      "address": address,
      "registDate": registDate,
      "status": status,
      "description": description,
      "categoryId": categoryId,
      "supervisorId": supervisorId,
    };
  }

  @override
  List<Object?> get props => [
        name,
        phone,
        address,
        registDate,
        status,
        description,
        categoryId,
        supervisorId,
      ];
}
