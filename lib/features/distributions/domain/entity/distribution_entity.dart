import 'package:equatable/equatable.dart';

class DistributionEntity extends Equatable {
  final int id;
  final double amount;
  final DateTime distributionDate;
  final String status;
  final String notes;
  final int caseId;
  final String caseName;
  final int donationId;
  final String donorName;
  final int handledByEmployeeId;
  final String handledByEmployeeName;

  const DistributionEntity({
    required this.id,
    required this.amount,
    required this.distributionDate,
    required this.status,
    required this.notes,
    required this.caseId,
    required this.caseName,
    required this.donationId,
    required this.donorName,
    required this.handledByEmployeeId,
    required this.handledByEmployeeName,
  });

  factory DistributionEntity.fromJson(Map<String, dynamic> json) {
    return DistributionEntity(
      id: json['id'] ?? 0,
      amount: (json['amount'] as num?)?.toDouble() ?? 0.0,
      distributionDate: json['distributionDate'] != null
          ? DateTime.parse(json['distributionDate'])
          : DateTime.now(),
      status: json['status'] ?? '',
      notes: json['notes'] ?? '',
      caseId: json['caseId'] ?? 0,
      caseName: json['caseName'] ?? '',
      donationId: json['donationId'] ?? 0,
      donorName: json['donorName'] ?? '',
      handledByEmployeeId: json['handledByEmployeeId'] ?? 0,
      handledByEmployeeName: json['handledByEmployeeName'] ?? '',
    );
  }

  @override
  List<Object?> get props => [
        id,
        amount,
        distributionDate,
        status,
        notes,
        caseId,
        caseName,
        donationId,
        donorName,
        handledByEmployeeId,
        handledByEmployeeName,
      ];
}
