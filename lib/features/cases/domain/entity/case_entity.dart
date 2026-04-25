import 'package:equatable/equatable.dart';

class CaseEntity extends Equatable {
  final int id;
  final String name;
  final String phone;
  final String address;
  final DateTime registDate;
  final String status;
  final String description;
  final String categoryName;
  final String supervisorName;

  const CaseEntity({
    required this.id,
    required this.name,
    required this.phone,
    required this.address,
    required this.registDate,
    required this.status,
    required this.description,
    required this.categoryName,
    required this.supervisorName,
  });

  @override
  List<Object?> get props => [
        id,
        name,
        phone,
        address,
        registDate,
        status,
        description,
        categoryName,
        supervisorName,
      ];
}
