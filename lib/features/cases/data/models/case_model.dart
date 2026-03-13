class CaseModel {
  final int id;
  final String name;
  final String phone;
  final String email;
  final DateTime registDate;
  final String description;
  final String address;
  final String category; //TODO convert to Enum
  final String status;

  CaseModel({required this.id, required this.name, required this.phone, required this.email, required this.registDate, required this.description, required this.address, required this.category, required this.status}); //TODO convert to Enum
}
