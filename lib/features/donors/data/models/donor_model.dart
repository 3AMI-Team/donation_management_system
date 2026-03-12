class DonorModel {
  final int id;
  final String name;
  final String phoneNumber;
  final String email;
  final String address;
  final DonorType type;
  final DateTime registDate;

  const DonorModel({
    required this.id,
    required this.name,
    required this.email,
    required this.phoneNumber,
    required this.address,
    required this.registDate,
    required this.type,
  });

  

}

enum DonorType { individual, organization }

 