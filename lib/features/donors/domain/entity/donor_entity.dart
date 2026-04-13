import 'package:equatable/equatable.dart';

class DonorEntity extends Equatable {
  final int id;
  final String name;
  final String email;
  final String phone;
  final DateTime registerDate;

  const DonorEntity({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.registerDate,
  });

  @override
  List<Object?> get props => [id, name, email, phone, registerDate];
}
