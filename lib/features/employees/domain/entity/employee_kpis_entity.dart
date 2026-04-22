class EmployeeKpisEntity {
  final int totalEmployees;
  final int adminCount;
  final int activeSupervisors;
  final double monthlyActivityRate;

  EmployeeKpisEntity({
    required this.totalEmployees,
    required this.adminCount,
    required this.activeSupervisors,
    required this.monthlyActivityRate,
  });

  factory EmployeeKpisEntity.fromJson(Map<String, dynamic> json) {
    return EmployeeKpisEntity(
      totalEmployees: json['totalEmployees'] ?? 0,
      adminCount: json['adminCount'] ?? 0,
      activeSupervisors: json['activeSupervisors'] ?? 0,
      monthlyActivityRate: (json['monthlyActivityRate'] as num?)?.toDouble() ?? 0.0,
    );
  }
}
