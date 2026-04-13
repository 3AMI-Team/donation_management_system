import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:donation_management_system/core/network/errors/failure.dart';
import 'package:donation_management_system/core/utils/use_case.dart';
import 'package:donation_management_system/features/auth/domain/entity/user_entity.dart';
import 'package:donation_management_system/features/auth/domain/repo/auth_repo.dart';

class LoginUseCase implements UseCase<UserEntity, LoginParams> {
  final AuthRepo repository;

  LoginUseCase({required this.repository});

  @override
  Future<Either<Failure, UserEntity>> call(LoginParams params) async {
    return await repository.login(
      username: params.username,
      password: params.password,
    );
  }
}

class LoginParams extends Equatable {
  final String username;
  final String password;

  const LoginParams({required this.username, required this.password});

  @override
  List<Object?> get props => [username, password];
}
