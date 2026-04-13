import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final int id;
  final String name;
  final String username;
  final String role;
  final String token;

  const UserEntity({
    required this.id,
    required this.name,
    required this.username,
    required this.role,
    required this.token,
  });

  @override
  List<Object?> get props => [id, name, username, role, token];
}
