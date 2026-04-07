enum EmployeeRole { admin, staff, fieldWorker }

class EmployeeTableModel {
  final String name;
  final String email;
  final String username;
  final EmployeeRole role;
  final String phone;

  const EmployeeTableModel({
    required this.name,
    required this.email,
    required this.username,
    required this.role,
    required this.phone,
  });
}
