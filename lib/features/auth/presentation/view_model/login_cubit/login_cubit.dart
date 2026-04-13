import 'package:donation_management_system/features/auth/domain/entity/user_entity.dart';
import 'package:donation_management_system/features/auth/domain/use_case/login_use_case.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final LoginUseCase loginUseCase;

  LoginCubit({required this.loginUseCase}) : super(LoginInitial());

  Future<void> login({required String username, required String password}) async {
    emit(LoginLoading());

    final result = await loginUseCase(
      LoginParams(username: username, password: password),
    );

    result.fold(
      (failure) => emit(LoginError(message: failure.message)),
      (user) => emit(LoginSuccess(user: user)),
    );
  }
}
